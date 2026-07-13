"""Unit tests for scripts.verify_results using validated reference data."""

from __future__ import annotations

import shutil
import sqlite3
import unittest
from pathlib import Path

import pytest

from scripts.verify_results import (
    REFERENCE_DIRECTORY,
    TABLE_SPECS,
    TableSpec,
    compare_databases,
    compare_rows,
    numbers_match,
    open_read_only,
    read_rows,
    scientific_comparison,
)


BAU_REFERENCE = REFERENCE_DIRECTORY / "shungnak_bau_solved.sqlite"
BAU_UR_REFERENCE = REFERENCE_DIRECTORY / "shungnak_bau_ur_solved.sqlite"


class VerifyResultsTests(unittest.TestCase):
    """Exercise result comparison behavior against the BAU reference database."""

    def test_reference_database_matches_itself(self) -> None:
        self.assertEqual(compare_databases(BAU_REFERENCE, BAU_REFERENCE, 1e-9), [])

    def test_read_rows_uses_identifying_columns(self) -> None:
        objective_spec = TABLE_SPECS[0]
        with open_read_only(BAU_REFERENCE) as connection:
            rows = read_rows(connection, objective_spec)

        self.assertIn(("BAU", "TotalCost"), rows)
        self.assertEqual(len(rows[("BAU", "TotalCost")]), 1)

    def test_tolerance_accepts_small_numeric_difference(self) -> None:
        self.assertTrue(numbers_match(100.0, 100.0009, 0.001))
        self.assertFalse(numbers_match(100.0, 100.0011, 0.001))

    def test_compare_databases_reports_missing_table(self) -> None:
        nonexistent = TableSpec("NotAResultTable", ("id",), ("value",))

        differences = compare_databases(
            BAU_REFERENCE, BAU_REFERENCE, 1e-9, specs=(nonexistent,)
        )

        self.assertIn(
            "NotAResultTable: missing table in reference database", differences
        )
        self.assertIn(
            "NotAResultTable: missing table in generated database", differences
        )

    def test_compare_rows_reports_missing_extra_and_numeric_differences(self) -> None:
        spec = TableSpec("Example", ("id",), ("value",))
        reference = {(1,): (10.0,), (2,): (20.0,)}
        generated = {(1,): (11.0,), (3,): (30.0,)}

        differences = compare_rows(spec, reference, generated, tolerance=0.01)

        self.assertTrue(any("missing row" in message for message in differences))
        self.assertTrue(any("extra row" in message for message in differences))
        self.assertTrue(
            any("numeric difference" in message for message in differences)
        )

    def test_reference_database_is_opened_read_only(self) -> None:
        with open_read_only(BAU_REFERENCE) as connection:
            with self.assertRaises(sqlite3.OperationalError):
                connection.execute("CREATE TABLE must_not_be_created (value INTEGER)")


def copy_bau_reference(tmp_path: Path, name: str) -> Path:
    """Copy the immutable BAU reference before introducing test differences."""
    copied = tmp_path / name
    shutil.copy2(BAU_REFERENCE, copied)
    return copied


def test_scientific_mode_accepts_exactly_matching_results() -> None:
    report = scientific_comparison(BAU_REFERENCE, BAU_REFERENCE)

    assert report.passed
    assert report.row_differences == []


def test_exact_generation_equality_passes() -> None:
    report = scientific_comparison(BAU_REFERENCE, BAU_REFERENCE)

    assert report.generation_passed


def test_renewable_redistribution_passes_with_diagnostic_warning(
    tmp_path: Path,
) -> None:
    generated = tmp_path / "renewable_redistribution.sqlite"
    shutil.copy2(BAU_UR_REFERENCE, generated)
    with sqlite3.connect(generated) as connection:
        solar_update = connection.execute(
            "UPDATE OutputFlowOut SET flow = flow + 100.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowOut "
            "WHERE tech = 'GSOL_01' AND period = 2040 AND output_comm = 'ELC' "
            "ORDER BY flow DESC LIMIT 1)"
        )
        wind_update = connection.execute(
            "UPDATE OutputFlowOut SET flow = flow - 100.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowOut "
            "WHERE tech = 'GWND_01' AND period = 2040 AND output_comm = 'ELC' "
            "AND flow > 100.0 ORDER BY flow DESC LIMIT 1)"
        )
        assert solar_update.rowcount == 1
        assert wind_update.rowcount == 1

    report = scientific_comparison(BAU_UR_REFERENCE, generated)
    strict_differences = compare_databases(BAU_UR_REFERENCE, generated, 1e-6)

    assert report.passed
    assert report.generation_passed
    assert any(
        "alternative renewable dispatch allocation" in warning
        for warning in report.warnings
    )
    assert strict_differences


def test_different_total_renewable_generation_fails(tmp_path: Path) -> None:
    generated = copy_bau_reference(tmp_path, "different_renewable_total.sqlite")
    with sqlite3.connect(generated) as connection:
        connection.execute(
            "UPDATE OutputFlowOut SET flow = flow + 100.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowOut "
            "WHERE tech = 'GSOL_01' AND output_comm = 'ELC' LIMIT 1)"
        )

    report = scientific_comparison(BAU_REFERENCE, generated)

    assert not report.passed
    assert not report.generation_passed
    assert any("renewable_generation" in failure for failure in report.failures)


def test_different_diesel_generation_fails(tmp_path: Path) -> None:
    generated = copy_bau_reference(tmp_path, "different_diesel_generation.sqlite")
    with sqlite3.connect(generated) as connection:
        connection.execute(
            "UPDATE OutputFlowOut SET flow = flow + 100.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowOut "
            "WHERE tech = 'GDSL_01' AND output_comm = 'ELC' LIMIT 1)"
        )

    report = scientific_comparison(BAU_REFERENCE, generated)

    assert not report.passed
    assert not report.generation_passed
    assert any("diesel_generation" in failure for failure in report.failures)


def test_different_renewable_share_fails(tmp_path: Path) -> None:
    generated = copy_bau_reference(tmp_path, "different_renewable_share.sqlite")
    with sqlite3.connect(generated) as connection:
        connection.execute(
            "UPDATE OutputFlowOut SET flow = flow + 100000.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowOut "
            "WHERE tech = 'GDSL_01' AND period = 2030 AND output_comm = 'ELC' "
            "LIMIT 1)"
        )
        connection.execute(
            "UPDATE OutputFlowOut SET flow = flow - 100000.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowOut "
            "WHERE tech = 'GSOL_01' AND period = 2030 AND output_comm = 'ELC' "
            "LIMIT 1)"
        )

    report = scientific_comparison(BAU_REFERENCE, generated)

    assert not report.passed
    assert not report.generation_passed
    assert any("renewable_share" in failure for failure in report.failures)


def test_storage_throughput_below_relative_tolerance_passes(
    tmp_path: Path,
) -> None:
    generated = copy_bau_reference(tmp_path, "small_storage_throughput.sqlite")
    with sqlite3.connect(generated) as connection:
        connection.execute(
            "UPDATE OutputFlowIn SET flow = flow + 1.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowIn "
            "WHERE tech = 'EBATT_01' AND period = 2030 LIMIT 1)"
        )

    report = scientific_comparison(BAU_REFERENCE, generated)

    assert report.passed
    assert report.storage_passed


def test_materially_different_storage_throughput_fails(tmp_path: Path) -> None:
    generated = copy_bau_reference(tmp_path, "material_storage_throughput.sqlite")
    with sqlite3.connect(generated) as connection:
        connection.execute(
            "UPDATE OutputFlowIn SET flow = flow + 10.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowIn "
            "WHERE tech = 'EBATT_01' AND period = 2030 LIMIT 1)"
        )

    report = scientific_comparison(BAU_REFERENCE, generated)

    assert not report.passed
    assert not report.storage_passed


def test_small_storage_cycle_difference_produces_warning(tmp_path: Path) -> None:
    generated = copy_bau_reference(tmp_path, "small_storage_cycle.sqlite")
    with sqlite3.connect(generated) as connection:
        connection.execute(
            "UPDATE OutputFlowIn SET flow = flow + 1.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowIn "
            "WHERE tech = 'EBATT_01' AND period = 2030 LIMIT 1)"
        )
        connection.execute(
            "UPDATE OutputFlowOut SET flow = flow + 1.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowOut "
            "WHERE tech = 'GSOL_01' AND period = 2030 "
            "AND output_comm = 'ELC' LIMIT 1)"
        )

    report = scientific_comparison(BAU_REFERENCE, generated)

    assert report.passed
    assert any(
        warning
        == "The regenerated solution contains a small alternative "
        "storage-cycling allocation."
        for warning in report.warnings
    )
    assert any("charging difference=1" in item for item in report.storage_cycle_diagnostics)


def test_scientific_mode_accepts_numerically_equivalent_results(
    tmp_path: Path,
) -> None:
    generated = copy_bau_reference(tmp_path, "numerically_equivalent.sqlite")
    with sqlite3.connect(generated) as connection:
        connection.execute(
            "UPDATE OutputObjective SET total_system_cost = total_system_cost + 0.001"
        )
        connection.execute(
            "UPDATE OutputCost SET d_var = d_var + 0.001 "
            "WHERE rowid = (SELECT rowid FROM OutputCost LIMIT 1)"
        )

    report = scientific_comparison(BAU_REFERENCE, generated)

    assert report.passed
    assert report.objective_absolute_difference == pytest.approx(
        0.001,
        rel=0.0,
        abs=1e-8,
    )
    assert report.row_differences


def test_scientific_mode_accepts_alternative_diesel_allocations(
    tmp_path: Path,
) -> None:
    generated = copy_bau_reference(tmp_path, "diesel_reallocation.sqlite")
    with sqlite3.connect(generated) as connection:
        connection.execute(
            "UPDATE OutputNetCapacity SET capacity = capacity + 1.0 "
            "WHERE tech = 'GDSL_01' AND period = 2030"
        )
        connection.execute(
            "UPDATE OutputNetCapacity SET capacity = capacity - 1.0 "
            "WHERE tech = 'GDSL_03' AND period = 2030"
        )
        connection.execute(
            "UPDATE OutputEmission SET emission = emission + 1.0 "
            "WHERE tech = 'GDSL_01' AND period = 2030"
        )
        connection.execute(
            "UPDATE OutputEmission SET emission = emission - 1.0 "
            "WHERE tech = 'GDSL_03' AND period = 2030"
        )

    report = scientific_comparison(BAU_REFERENCE, generated)

    assert report.passed
    assert report.row_differences
    assert any("individual-unit diagnostic" in warning for warning in report.warnings)


def test_seasonal_redistribution_warns_scientific_and_fails_strict(
    tmp_path: Path,
) -> None:
    generated = copy_bau_reference(tmp_path, "seasonal_redistribution.sqlite")
    with sqlite3.connect(generated) as connection:
        connection.execute(
            "UPDATE OutputFlowIn SET flow = flow + 100.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowIn "
            "WHERE tech = 'GDSL_01' AND period = 2030 AND season = 'spring' "
            "LIMIT 1)"
        )
        connection.execute(
            "UPDATE OutputFlowIn SET flow = flow - 100.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowIn "
            "WHERE tech = 'GDSL_01' AND period = 2030 AND season = 'winter' "
            "LIMIT 1)"
        )

    report = scientific_comparison(BAU_REFERENCE, generated)
    strict_differences = compare_databases(BAU_REFERENCE, generated, 1e-6)

    assert report.passed
    assert any("seasonal dispatch was not reproduced" in warning for warning in report.warnings)
    assert any("hourly dispatch was not reproduced" in warning for warning in report.warnings)
    assert strict_differences


def test_scientific_mode_rejects_different_annual_diesel_total(
    tmp_path: Path,
) -> None:
    generated = copy_bau_reference(tmp_path, "different_diesel_total.sqlite")
    with sqlite3.connect(generated) as connection:
        connection.execute(
            "UPDATE OutputFlowIn SET flow = flow + 100.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowIn "
            "WHERE tech = 'GDSL_01' AND input_comm = 'DSL' LIMIT 1)"
        )

    report = scientific_comparison(BAU_REFERENCE, generated)

    assert not report.passed
    assert not report.diesel_fuel_passed


def test_scientific_mode_rejects_genuinely_different_objective(
    tmp_path: Path,
) -> None:
    generated = copy_bau_reference(tmp_path, "different_objective.sqlite")
    with sqlite3.connect(generated) as connection:
        connection.execute(
            "UPDATE OutputObjective SET total_system_cost = total_system_cost + 100.0"
        )

    report = scientific_comparison(BAU_REFERENCE, generated)

    assert not report.passed
    assert not report.objective_passed


@pytest.mark.parametrize(
    "name, update_sql, passed_field",
    (
        (
            "physical_capacity",
            "UPDATE OutputNetCapacity SET capacity = capacity + 1.0 "
            "WHERE rowid = (SELECT rowid FROM OutputNetCapacity "
            "WHERE tech = 'GSOL_01' LIMIT 1)",
            "capacity_passed",
        ),
        (
            "emissions",
            "UPDATE OutputEmission SET emission = emission + 1.0 "
            "WHERE rowid = (SELECT rowid FROM OutputEmission LIMIT 1)",
            "emissions_passed",
        ),
        (
            "cost",
            "UPDATE OutputCost SET d_var = d_var + 100.0 "
            "WHERE rowid = (SELECT rowid FROM OutputCost LIMIT 1)",
            "costs_passed",
        ),
        (
            "demand_served",
            "UPDATE OutputFlowOut SET flow = flow + 100.0 "
            "WHERE rowid = (SELECT rowid FROM OutputFlowOut "
            "WHERE output_comm = 'ELECD' LIMIT 1)",
            "demand_passed",
        ),
    ),
)
def test_scientific_mode_rejects_decision_relevant_difference(
    tmp_path: Path, name: str, update_sql: str, passed_field: str
) -> None:
    generated = copy_bau_reference(tmp_path, f"different_{name}.sqlite")
    with sqlite3.connect(generated) as connection:
        connection.execute(update_sql)

    report = scientific_comparison(BAU_REFERENCE, generated)

    assert not report.passed
    assert not getattr(report, passed_field)


if __name__ == "__main__":
    unittest.main()
