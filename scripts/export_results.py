"""Export validated reference result tables to deterministic CSV files."""

from __future__ import annotations

import csv
import re
import sqlite3
import sys
from contextlib import closing
from pathlib import Path


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
DATABASE_DIRECTORY = REPOSITORY_ROOT / "results" / "reference" / "databases"
CSV_DIRECTORY = REPOSITORY_ROOT / "results" / "reference" / "csv"

TABLES = (
    "OutputObjective",
    "OutputBuiltCapacity",
    "OutputNetCapacity",
    "OutputCost",
    "OutputEmission",
    "OutputFlowIn",
    "OutputFlowOut",
)


def snake_case(name: str) -> str:
    """Convert a CamelCase name to lowercase snake case."""
    first_pass = re.sub(r"(.)([A-Z][a-z]+)", r"\1_\2", name)
    return re.sub(r"([a-z0-9])([A-Z])", r"\1_\2", first_pass).lower()


def quote_identifier(identifier: str) -> str:
    """Quote a trusted SQLite identifier."""
    return '"' + identifier.replace('"', '""') + '"'


def scenario_name(database_path: Path) -> str:
    """Derive a lowercase scenario name from a reference database filename."""
    name = database_path.stem
    prefix = "shungnak_"
    suffix = "_solved"
    if name.startswith(prefix):
        name = name[len(prefix) :]
    if name.endswith(suffix):
        name = name[: -len(suffix)]
    return snake_case(name)


def open_read_only(database_path: Path) -> sqlite3.Connection:
    """Open a SQLite database with writes prohibited by SQLite."""
    uri = f"{database_path.resolve().as_uri()}?mode=ro"
    return sqlite3.connect(uri, uri=True)


def table_columns(connection: sqlite3.Connection, table: str) -> list[str]:
    """Return database column names in their declared order."""
    pragma = f"PRAGMA table_info({quote_identifier(table)})"
    return [row[1] for row in connection.execute(pragma)]


def export_table(
    connection: sqlite3.Connection, table: str, csv_path: Path
) -> int:
    """Export one table with its original header and deterministic row order."""
    columns = table_columns(connection, table)
    if not columns:
        raise ValueError(f"required table does not exist: {table}")

    quoted_columns = ", ".join(quote_identifier(column) for column in columns)
    order_by = ", ".join(quote_identifier(column) for column in columns)
    query = (
        f"SELECT {quoted_columns} FROM {quote_identifier(table)} "
        f"ORDER BY {order_by}"
    )

    with csv_path.open("w", encoding="utf-8", newline="") as csv_file:
        writer = csv.writer(csv_file, lineterminator="\n")
        writer.writerow(columns)
        row_count = 0
        for row in connection.execute(query):
            # csv.writer uses Python's round-trip representation for SQLite floats.
            writer.writerow(row)
            row_count += 1
    return row_count


def export_database(database_path: Path, csv_root: Path = CSV_DIRECTORY) -> list[Path]:
    """Export all required tables from one reference database."""
    scenario_directory = csv_root / scenario_name(database_path)
    scenario_directory.mkdir(parents=True, exist_ok=True)
    exported: list[Path] = []

    with closing(open_read_only(database_path)) as connection:
        for table in TABLES:
            csv_path = scenario_directory / f"{snake_case(table)}.csv"
            export_table(connection, table, csv_path)
            exported.append(csv_path)
    return exported


def main() -> int:
    database_paths = sorted(DATABASE_DIRECTORY.glob("*.sqlite"))
    if not database_paths:
        print(
            f"ERROR: no reference databases found under {DATABASE_DIRECTORY}",
            file=sys.stderr,
        )
        return 1

    exported_count = 0
    for database_path in database_paths:
        scenario = scenario_name(database_path)
        try:
            exported = export_database(database_path)
        except (OSError, sqlite3.Error, ValueError) as error:
            print(f"[{scenario}] ERROR: {error}", file=sys.stderr)
            return 1
        exported_count += len(exported)
        print(f"[{scenario}] exported {len(exported)} CSV files")

    print(
        f"Exported {exported_count} files from {len(database_paths)} "
        f"reference databases to {CSV_DIRECTORY}."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
