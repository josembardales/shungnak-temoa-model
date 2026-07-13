"""Build and validate scenario SQLite databases from TEMOA SQL dumps."""

from __future__ import annotations

import sqlite3
import sys
from pathlib import Path


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
SQL_DIRECTORY = REPOSITORY_ROOT / "model_inputs" / "sql"
OUTPUT_DIRECTORY = REPOSITORY_ROOT / "build" / "input_databases"

# Core tables required for a usable TEMOA input database.
EXPECTED_TEMOA_TABLES = {
    "Commodity",
    "CommodityType",
    "Demand",
    "Efficiency",
    "Region",
    "Technology",
    "TechnologyType",
    "TimeOfDay",
    "TimePeriod",
    "TimePeriodType",
    "TimeSeason",
    "TimeSegmentFraction",
}


def build_database(sql_path: Path) -> tuple[bool, str]:
    """Create and validate one SQLite database without changing its SQL source."""
    database_path = OUTPUT_DIRECTORY / f"{sql_path.stem}.sqlite"

    try:
        if database_path.exists():
            database_path.unlink()

        sql = sql_path.read_text(encoding="utf-8-sig")

        with sqlite3.connect(database_path) as connection:
            connection.execute("PRAGMA foreign_keys = ON")
            if connection.execute("PRAGMA foreign_keys").fetchone()[0] != 1:
                raise RuntimeError("could not enable SQLite foreign key checks")

            connection.executescript(sql)

            # SQL dumps may change this setting, so enforce it after import too.
            connection.execute("PRAGMA foreign_keys = ON")
            if connection.execute("PRAGMA foreign_keys").fetchone()[0] != 1:
                raise RuntimeError("SQL import left foreign key checks disabled")

            violations = connection.execute("PRAGMA foreign_key_check").fetchall()
            if violations:
                preview = ", ".join(str(row) for row in violations[:5])
                remainder = len(violations) - 5
                if remainder > 0:
                    preview += f", ... and {remainder} more"
                raise RuntimeError(f"foreign key violations found: {preview}")

            tables = {
                row[0]
                for row in connection.execute(
                    "SELECT name FROM sqlite_master WHERE type = 'table'"
                )
            }
            missing_tables = sorted(EXPECTED_TEMOA_TABLES - tables)
            if missing_tables:
                raise RuntimeError(
                    "missing expected TEMOA tables: " + ", ".join(missing_tables)
                )

        return True, f"created {database_path.relative_to(REPOSITORY_ROOT)}"
    except (OSError, UnicodeError, sqlite3.Error, RuntimeError) as error:
        # Do not leave a database that failed import or validation looking usable.
        try:
            database_path.unlink(missing_ok=True)
        except OSError as cleanup_error:
            return False, f"{error}; could not remove partial database: {cleanup_error}"
        return False, str(error)


def main() -> int:
    """Build every SQL dump and return a nonzero status if any build fails."""
    sql_files = sorted(SQL_DIRECTORY.glob("*.sql"))
    if not sql_files:
        print(f"FAIL: no SQL files found in {SQL_DIRECTORY}", file=sys.stderr)
        return 1

    OUTPUT_DIRECTORY.mkdir(parents=True, exist_ok=True)

    failures = 0
    for sql_path in sql_files:
        succeeded, message = build_database(sql_path)
        status = "SUCCESS" if succeeded else "FAILURE"
        stream = sys.stdout if succeeded else sys.stderr
        print(f"[{status}] {sql_path.stem}: {message}", file=stream)
        failures += not succeeded

    if failures:
        print(
            f"Build finished with {failures} failure(s) out of {len(sql_files)} scenario(s).",
            file=sys.stderr,
        )
        return 1

    print(f"Build finished successfully for all {len(sql_files)} scenario(s).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
