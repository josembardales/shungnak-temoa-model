"""Repository-level tests that do not execute TEMOA or modify source data."""

from __future__ import annotations

import csv
import shutil
import sqlite3
import tomllib
from contextlib import closing
from pathlib import Path

import pytest

from scripts import build_databases, export_results, run_scenarios, verify_results


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
SQL_DIRECTORY = REPOSITORY_ROOT / "model_inputs" / "sql"
CONFIG_DIRECTORY = REPOSITORY_ROOT / "configs"
REFERENCE_DIRECTORY = REPOSITORY_ROOT / "results" / "reference" / "databases"

SCENARIOS = {
    "bau": "BAU",
    "bau_ur": "BAU_UR",
    "cp_mid": "CP_MID",
    "hdp": "HDP",
    "nz": "NZ",
    "nz_subsidy": "SUBSIDY",
}

REQUIRED_OUTPUT_TABLES = {
    "OutputObjective",
    "OutputBuiltCapacity",
    "OutputNetCapacity",
    "OutputCost",
    "OutputEmission",
    "OutputFlowIn",
    "OutputFlowOut",
}


def sql_path(slug: str) -> Path:
    return SQL_DIRECTORY / f"shungnak_{slug}.sql"


def config_path(slug: str) -> Path:
    return CONFIG_DIRECTORY / f"config_shungnak_{slug}.toml"


def reference_path(slug: str) -> Path:
    return REFERENCE_DIRECTORY / f"shungnak_{slug}_solved.sqlite"


def read_config(slug: str) -> dict[str, object]:
    with config_path(slug).open("rb") as config_file:
        return tomllib.load(config_file)


def open_read_only(path: Path) -> sqlite3.Connection:
    return sqlite3.connect(f"{path.resolve().as_uri()}?mode=ro", uri=True)


def sqlite_tables(connection: sqlite3.Connection) -> set[str]:
    return {
        row[0]
        for row in connection.execute(
            "SELECT name FROM sqlite_master WHERE type = 'table'"
        )
    }


def test_all_six_sql_files_exist() -> None:
    assert {path.name for path in SQL_DIRECTORY.glob("*.sql")} == {
        f"shungnak_{slug}.sql" for slug in SCENARIOS
    }


def test_all_six_configuration_files_exist() -> None:
    assert {path.name for path in CONFIG_DIRECTORY.glob("*.toml")} == {
        f"config_shungnak_{slug}.toml" for slug in SCENARIOS
    }


@pytest.mark.parametrize("slug", SCENARIOS)
def test_sql_builds_with_valid_foreign_keys_and_required_tables(
    slug: str, tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    """Build each SQL source only into pytest's temporary directory."""
    output_directory = tmp_path / "input_databases"
    output_directory.mkdir()
    monkeypatch.setattr(build_databases, "OUTPUT_DIRECTORY", output_directory)
    monkeypatch.setattr(build_databases, "REPOSITORY_ROOT", tmp_path)

    source = sql_path(slug)
    original = source.read_bytes()
    succeeded, message = build_databases.build_database(source)

    assert succeeded, message
    assert source.read_bytes() == original
    database = output_directory / f"shungnak_{slug}.sqlite"
    assert database.is_file()

    with closing(sqlite3.connect(database)) as connection:
        connection.execute("PRAGMA foreign_keys = ON")
        assert connection.execute("PRAGMA foreign_keys").fetchone() == (1,)
        assert connection.execute("PRAGMA foreign_key_check").fetchall() == []
        assert build_databases.EXPECTED_TEMOA_TABLES <= sqlite_tables(connection)


@pytest.mark.parametrize("slug", SCENARIOS)
def test_reference_database_contains_required_outputs_and_objective(
    slug: str,
) -> None:
    database = reference_path(slug)
    assert database.is_file()

    with closing(open_read_only(database)) as connection:
        assert REQUIRED_OUTPUT_TABLES <= sqlite_tables(connection)
        objective_count = connection.execute(
            "SELECT COUNT(*) FROM OutputObjective "
            "WHERE total_system_cost IS NOT NULL"
        ).fetchone()[0]
        assert objective_count > 0


@pytest.mark.parametrize("slug, expected_label", SCENARIOS.items())
def test_configuration_label_and_database_locations(
    slug: str, expected_label: str
) -> None:
    config = read_config(slug)
    assert config["scenario"] == expected_label

    input_database = Path(config["input_database"])
    output_database = Path(config["output_database"])
    assert input_database.parts[:2] == ("build", "input_databases")
    assert output_database.parts[:3] == (
        "results",
        "generated",
        "databases",
    )
    assert "results/reference" not in config_path(slug).read_text(
        encoding="utf-8"
    ).replace("\\", "/")


def test_scripts_do_not_modify_sql_sources(tmp_path: Path) -> None:
    """Exercise repository writers against temporary outputs and hash SQL bytes."""
    before = {path: path.read_bytes() for path in sorted(SQL_DIRECTORY.glob("*.sql"))}

    export_results.export_database(reference_path("bau"), tmp_path / "csv")
    verify_results.compare_databases(
        reference_path("bau"), reference_path("bau"), tolerance=1e-9
    )

    after = {path: path.read_bytes() for path in sorted(SQL_DIRECTORY.glob("*.sql"))}
    assert after == before

    writable_directories = {
        build_databases.OUTPUT_DIRECTORY,
        export_results.CSV_DIRECTORY,
        run_scenarios.OUTPUT_DIRECTORY,
        run_scenarios.SCENARIO_OUTPUT_DIRECTORY,
        run_scenarios.LOG_DIRECTORY,
    }
    assert SQL_DIRECTORY not in writable_directories
    assert all(
        SQL_DIRECTORY not in directory.parents
        for directory in writable_directories
    )
    for scenario in run_scenarios.SCENARIOS:
        assert scenario.input_path.parent != SQL_DIRECTORY
        assert scenario.output_path.parent != SQL_DIRECTORY


def test_nz_subsidy_repository_and_internal_labels_are_distinct() -> None:
    scenario = run_scenarios.SCENARIOS_BY_LABEL["NZ_SUBSIDY"]

    assert scenario.slug == "nz_subsidy"
    assert scenario.internal_label == "SUBSIDY"
    assert verify_results.INTERNAL_SCENARIO_LABELS["nz_subsidy"] == "SUBSIDY"


def test_csv_export_functions_write_expected_temporary_files(
    tmp_path: Path,
) -> None:
    exported = export_results.export_database(reference_path("bau"), tmp_path)

    assert len(exported) == len(export_results.TABLES)
    assert {path.name for path in exported} == {
        f"{export_results.snake_case(table)}.csv"
        for table in export_results.TABLES
    }
    assert all(path.parent == tmp_path / "bau" for path in exported)

    for table, path in zip(export_results.TABLES, exported):
        with path.open("r", encoding="utf-8", newline="") as csv_file:
            rows = list(csv.reader(csv_file))
        assert rows
        with closing(open_read_only(reference_path("bau"))) as connection:
            assert rows[0] == export_results.table_columns(connection, table)

    first_export = {path.name: path.read_bytes() for path in exported}
    repeated = export_results.export_database(reference_path("bau"), tmp_path)
    assert {path.name: path.read_bytes() for path in repeated} == first_export


def test_verification_functions_identify_matching_and_different_data(
    tmp_path: Path,
) -> None:
    reference = reference_path("bau")
    assert verify_results.compare_databases(reference, reference, 1e-9) == []

    generated_copy = tmp_path / "shungnak_bau_solved.sqlite"
    shutil.copy2(reference, generated_copy)
    with sqlite3.connect(generated_copy) as connection:
        connection.execute(
            "UPDATE OutputObjective "
            "SET total_system_cost = total_system_cost + 1.0"
        )

    differences = verify_results.compare_databases(
        reference, generated_copy, tolerance=1e-9
    )
    assert any(
        "OutputObjective: numeric difference" in difference
        for difference in differences
    )
