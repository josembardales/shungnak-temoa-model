"""Verify generated Shungnak results strictly or by scientific equivalence."""

from __future__ import annotations

import argparse
import math
import sqlite3
import sys
from contextlib import closing
from dataclasses import dataclass, field
from pathlib import Path
from typing import Iterable


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
GENERATED_DIRECTORY = REPOSITORY_ROOT / "results" / "generated" / "databases"
REFERENCE_DIRECTORY = REPOSITORY_ROOT / "results" / "reference" / "databases"
DEFAULT_TOLERANCE = 1e-6

OBJECTIVE_REL_TOL = 1e-8
OBJECTIVE_ABS_TOL = 0.01
CAPACITY_REL_TOL = 1e-7
CAPACITY_ABS_TOL = 1e-4
EMISSION_REL_TOL = 1e-8
EMISSION_ABS_TOL = 1e-5
COST_REL_TOL = 1e-8
COST_ABS_TOL = 0.01
GENERATION_REL_TOL = 1e-5
GENERATION_ABS_TOL = 0.01
DIESEL_REL_TOL = 1e-7
DIESEL_ABS_TOL = 0.01
STORAGE_REL_TOL = 1e-4
STORAGE_ABS_TOL = 0.01
DEMAND_REL_TOL = 1e-7
DEMAND_ABS_TOL = 0.01
OPTIONAL_OUTPUT_REL_TOL = 1e-7
OPTIONAL_OUTPUT_ABS_TOL = 0.01
DIAGNOSTIC_FLOW_REL_TOL = 1e-7
DIAGNOSTIC_FLOW_ABS_TOL = 0.01
FLOW_ZERO_THRESHOLD = 1e-8

DIESEL_TECHNOLOGIES = {"GDSL_01", "GDSL_02", "GDSL_03"}
NONPHYSICAL_TECHNOLOGIES = {"ELECT"}
COST_COLUMNS = (
    "d_invest",
    "d_fixed",
    "d_var",
    "d_emiss",
    "invest",
    "fixed",
    "var",
    "emiss",
)
DISCOUNTED_COST_COLUMNS = COST_COLUMNS[:4]

SCENARIOS = {
    "BAU": "bau",
    "BAU_UR": "bau_ur",
    "CP_MID": "cp_mid",
    "HDP": "hdp",
    "NZ": "nz",
    "NZ_SUBSIDY": "nz_subsidy",
}
INTERNAL_SCENARIO_LABELS = {
    "bau": "BAU",
    "bau_ur": "BAU_UR",
    "cp_mid": "CP_MID",
    "hdp": "HDP",
    "nz": "NZ",
    "nz_subsidy": "SUBSIDY",
}


@dataclass(frozen=True)
class TableSpec:
    """Columns used to identify rows and compare result values strictly."""

    name: str
    key_columns: tuple[str, ...]
    value_columns: tuple[str, ...]


TABLE_SPECS = (
    TableSpec(
        "OutputObjective",
        ("scenario", "objective_name"),
        ("total_system_cost",),
    ),
    TableSpec(
        "OutputBuiltCapacity",
        ("scenario", "region", "sector", "tech", "vintage"),
        ("capacity",),
    ),
    TableSpec(
        "OutputNetCapacity",
        ("scenario", "region", "sector", "period", "tech", "vintage"),
        ("capacity",),
    ),
    TableSpec(
        "OutputEmission",
        (
            "scenario",
            "region",
            "sector",
            "period",
            "emis_comm",
            "tech",
            "vintage",
        ),
        ("emission",),
    ),
    TableSpec(
        "OutputCost",
        ("scenario", "region", "period", "tech", "vintage"),
        COST_COLUMNS,
    ),
    TableSpec(
        "OutputFlowIn",
        (
            "scenario",
            "region",
            "sector",
            "period",
            "season",
            "tod",
            "input_comm",
            "tech",
            "vintage",
            "output_comm",
        ),
        ("flow",),
    ),
    TableSpec(
        "OutputFlowOut",
        (
            "scenario",
            "region",
            "sector",
            "period",
            "season",
            "tod",
            "input_comm",
            "tech",
            "vintage",
            "output_comm",
        ),
        ("flow",),
    ),
)


@dataclass
class ScientificReport:
    """Scientific-equivalence results and informational diagnostics."""

    objective_reference: float | None = None
    objective_generated: float | None = None
    objective_absolute_difference: float = math.inf
    objective_relative_difference: float = math.inf
    objective_passed: bool = False
    capacity_passed: bool = False
    emissions_passed: bool = False
    costs_passed: bool = False
    generation_passed: bool = False
    diesel_fuel_passed: bool = False
    storage_passed: bool = False
    demand_passed: bool = False
    curtailment_passed: bool = False
    failures: list[str] = field(default_factory=list)
    warnings: list[str] = field(default_factory=list)
    row_differences: list[str] = field(default_factory=list)
    storage_cycle_diagnostics: list[str] = field(default_factory=list)

    @property
    def passed(self) -> bool:
        return (
            self.objective_passed
            and self.capacity_passed
            and self.emissions_passed
            and self.costs_passed
            and self.generation_passed
            and self.diesel_fuel_passed
            and self.storage_passed
            and self.demand_passed
            and self.curtailment_passed
            and not self.failures
        )


def quote_identifier(identifier: str) -> str:
    """Quote a trusted SQLite identifier."""
    return '"' + identifier.replace('"', '""') + '"'


def open_read_only(database_path: Path) -> sqlite3.Connection:
    """Open an existing SQLite database in enforced read-only mode."""
    uri = f"{database_path.resolve().as_uri()}?mode=ro"
    return sqlite3.connect(uri, uri=True)


def table_names(connection: sqlite3.Connection) -> set[str]:
    """Return the names of all tables in a database."""
    rows = connection.execute(
        "SELECT name FROM sqlite_master WHERE type = 'table'"
    ).fetchall()
    return {row[0] for row in rows}


def output_scenario_labels(database_path: Path) -> set[str]:
    """Return scenario labels stored with objective results."""
    with closing(open_read_only(database_path)) as connection:
        if "OutputObjective" not in table_names(connection):
            return set()
        return {
            row[0]
            for row in connection.execute(
                "SELECT DISTINCT scenario FROM OutputObjective"
            )
        }


def read_rows(
    connection: sqlite3.Connection, spec: TableSpec
) -> dict[tuple[object, ...], tuple[object, ...]]:
    """Read a result table into a mapping keyed by identifying columns."""
    columns = spec.key_columns + spec.value_columns
    selection = ", ".join(quote_identifier(column) for column in columns)
    query = f"SELECT {selection} FROM {quote_identifier(spec.name)}"
    key_length = len(spec.key_columns)
    keyed_rows: dict[tuple[object, ...], tuple[object, ...]] = {}

    for row in connection.execute(query):
        key = tuple(row[:key_length])
        if key in keyed_rows:
            raise ValueError(f"{spec.name} contains duplicate identifying row {key!r}")
        keyed_rows[key] = tuple(row[key_length:])
    return keyed_rows


def numbers_match(
    reference: object,
    generated: object,
    tolerance: float | None = None,
    *,
    relative_tolerance: float = 0.0,
    absolute_tolerance: float | None = None,
) -> bool:
    """Compare numeric values with explicit relative and absolute tolerances."""
    if reference is None or generated is None:
        return reference is generated
    if not isinstance(reference, (int, float)) or not isinstance(
        generated, (int, float)
    ):
        return reference == generated
    if absolute_tolerance is None:
        absolute_tolerance = DEFAULT_TOLERANCE if tolerance is None else tolerance
    return math.isclose(
        float(reference),
        float(generated),
        rel_tol=relative_tolerance,
        abs_tol=absolute_tolerance,
    )


def compare_rows(
    spec: TableSpec,
    reference_rows: dict[tuple[object, ...], tuple[object, ...]],
    generated_rows: dict[tuple[object, ...], tuple[object, ...]],
    tolerance: float,
) -> list[str]:
    """Report strict missing, extra, and numerically different rows."""
    differences: list[str] = []
    reference_keys = set(reference_rows)
    generated_keys = set(generated_rows)

    for key in sorted(reference_keys - generated_keys, key=repr):
        differences.append(f"{spec.name}: missing row: {key!r}")
    for key in sorted(generated_keys - reference_keys, key=repr):
        differences.append(f"{spec.name}: extra row: {key!r}")

    for key in sorted(reference_keys & generated_keys, key=repr):
        for column, reference, generated in zip(
            spec.value_columns, reference_rows[key], generated_rows[key]
        ):
            if not numbers_match(reference, generated, tolerance):
                if isinstance(reference, (int, float)) and isinstance(
                    generated, (int, float)
                ):
                    absolute_difference: float | str = abs(reference - generated)
                else:
                    absolute_difference = "not numeric"
                differences.append(
                    f"{spec.name}: numeric difference at {key!r}, column "
                    f"{column!r}: reference={reference!r}, "
                    f"generated={generated!r}, "
                    f"absolute_difference={absolute_difference!r}"
                )
    return differences


def compare_databases(
    reference_path: Path,
    generated_path: Path,
    tolerance: float,
    specs: Iterable[TableSpec] = TABLE_SPECS,
) -> list[str]:
    """Perform the strict row-level comparison."""
    differences: list[str] = []
    with closing(open_read_only(reference_path)) as reference_connection, closing(
        open_read_only(generated_path)
    ) as generated_connection:
        reference_tables = table_names(reference_connection)
        generated_tables = table_names(generated_connection)

        for spec in specs:
            reference_has_table = spec.name in reference_tables
            generated_has_table = spec.name in generated_tables
            if not reference_has_table:
                differences.append(f"{spec.name}: missing table in reference database")
            if not generated_has_table:
                differences.append(f"{spec.name}: missing table in generated database")
            if not reference_has_table or not generated_has_table:
                continue
            try:
                reference_rows = read_rows(reference_connection, spec)
                generated_rows = read_rows(generated_connection, spec)
            except (sqlite3.Error, ValueError) as error:
                differences.append(f"{spec.name}: could not compare table: {error}")
                continue
            differences.extend(
                compare_rows(spec, reference_rows, generated_rows, tolerance)
            )
    return differences


def technology_family(technology: str) -> str:
    """Map equivalent diesel units to their scientific comparison family."""
    return "Diesel" if technology in DIESEL_TECHNOLOGIES else technology


def relative_difference(reference: float, generated: float) -> float:
    """Return a symmetric relative difference, with zero handled explicitly."""
    scale = max(abs(reference), abs(generated))
    return abs(reference - generated) / scale if scale else 0.0


def compare_aggregates(
    label: str,
    reference: dict[tuple[object, ...], float],
    generated: dict[tuple[object, ...], float],
    relative_tolerance: float,
    absolute_tolerance: float,
) -> list[str]:
    """Compare aggregate mappings, treating absent groups as zero."""
    differences: list[str] = []
    for key in sorted(set(reference) | set(generated), key=repr):
        reference_value = reference.get(key, 0.0)
        generated_value = generated.get(key, 0.0)
        if not numbers_match(
            reference_value,
            generated_value,
            relative_tolerance=relative_tolerance,
            absolute_tolerance=absolute_tolerance,
        ):
            differences.append(
                f"{label} {key!r}: reference={reference_value!r}, "
                f"generated={generated_value!r}, "
                f"absolute_difference={abs(reference_value-generated_value)!r}"
            )
    return differences


def objective_value(connection: sqlite3.Connection) -> float:
    """Read the single total-system-cost objective required for verification."""
    rows = connection.execute(
        "SELECT total_system_cost FROM OutputObjective "
        "WHERE total_system_cost IS NOT NULL"
    ).fetchall()
    if not rows:
        raise ValueError("OutputObjective does not contain an objective result")
    if len(rows) != 1:
        raise ValueError(f"OutputObjective contains {len(rows)} objective results")
    return float(rows[0][0])


def aggregate_capacity(
    connection: sqlite3.Connection,
    table: str,
    *,
    families: bool,
    include_nonphysical: bool,
) -> dict[tuple[object, ...], float]:
    """Aggregate capacity over vintages, optionally using technology families."""
    period_column = "period" if table == "OutputNetCapacity" else "vintage"
    selection = f"scenario, region, {period_column}, tech, capacity"
    aggregates: dict[tuple[object, ...], float] = {}
    for row in connection.execute(f"SELECT {selection} FROM {table}"):
        *dimensions, technology, capacity = row
        if not include_nonphysical and technology in NONPHYSICAL_TECHNOLOGIES:
            continue
        compared_technology = technology_family(technology) if families else technology
        key = (*dimensions, compared_technology)
        aggregates[key] = aggregates.get(key, 0.0) + float(capacity or 0.0)
    return aggregates


def aggregate_emissions(
    connection: sqlite3.Connection,
) -> dict[tuple[object, ...], float]:
    """Aggregate emissions over technologies and vintages."""
    aggregates: dict[tuple[object, ...], float] = {}
    query = (
        "SELECT scenario, region, period, emis_comm, emission "
        "FROM OutputEmission"
    )
    for scenario, region, period, commodity, emission in connection.execute(query):
        key = (scenario, region, period, commodity)
        aggregates[key] = aggregates.get(key, 0.0) + float(emission or 0.0)
    return aggregates


def aggregate_costs(
    connection: sqlite3.Connection,
    *,
    families: bool,
) -> dict[tuple[object, ...], float]:
    """Aggregate each cost category across vintages and diesel units."""
    columns = ", ".join(COST_COLUMNS)
    query = f"SELECT scenario, region, period, tech, {columns} FROM OutputCost"
    aggregates: dict[tuple[object, ...], float] = {}
    for row in connection.execute(query):
        scenario, region, period, technology, *values = row
        compared_technology = technology_family(technology) if families else technology
        for category, value in zip(COST_COLUMNS, values):
            key = (scenario, region, period, compared_technology, category)
            aggregates[key] = aggregates.get(key, 0.0) + float(value or 0.0)
    return aggregates


def aggregate_period_costs(
    connection: sqlite3.Connection,
) -> dict[tuple[object, ...], float]:
    """Aggregate cost categories across technologies and vintages by period."""
    columns = ", ".join(COST_COLUMNS)
    query = f"SELECT scenario, region, period, {columns} FROM OutputCost"
    aggregates: dict[tuple[object, ...], float] = {}
    for row in connection.execute(query):
        scenario, region, period, *values = row
        for category, value in zip(COST_COLUMNS, values):
            key = (scenario, region, period, category)
            aggregates[key] = aggregates.get(key, 0.0) + float(value or 0.0)
    return aggregates


def discounted_cost_total(connection: sqlite3.Connection) -> float:
    """Sum the discounted OutputCost categories represented by the objective."""
    expression = " + ".join(f"COALESCE({column}, 0)" for column in DISCOUNTED_COST_COLUMNS)
    return float(connection.execute(f"SELECT SUM({expression}) FROM OutputCost").fetchone()[0])


def aggregate_flows(
    connection: sqlite3.Connection,
    table: str,
) -> dict[tuple[object, ...], float]:
    """Aggregate flows over vintages and technologies by time and commodity."""
    commodity_column = "input_comm" if table == "OutputFlowIn" else "output_comm"
    query = (
        f"SELECT scenario, region, period, season, tod, {commodity_column}, flow "
        f"FROM {table}"
    )
    aggregates: dict[tuple[object, ...], float] = {}
    for *dimensions, flow in connection.execute(query):
        value = float(flow or 0.0)
        if abs(value) < FLOW_ZERO_THRESHOLD:
            value = 0.0
        key = tuple(dimensions)
        aggregates[key] = aggregates.get(key, 0.0) + value
    return aggregates


def aggregate_generation_summary(
    connection: sqlite3.Connection,
) -> dict[tuple[object, ...], float]:
    """Aggregate decision-relevant generation metrics by planning period."""
    period_values: dict[tuple[object, ...], dict[str, float]] = {}
    query = (
        "SELECT scenario, region, period, tech, flow FROM OutputFlowOut "
        "WHERE output_comm = 'ELC'"
    )
    renewable_technologies = {"GSOL_01", "GWND_01", "GHYD_01"}
    for scenario, region, period, technology, flow in connection.execute(query):
        if technology not in DIESEL_TECHNOLOGIES | renewable_technologies:
            continue
        key = (scenario, region, period)
        values = period_values.setdefault(key, {"diesel": 0.0, "renewable": 0.0})
        category = "diesel" if technology in DIESEL_TECHNOLOGIES else "renewable"
        values[category] += float(flow or 0.0)

    aggregates: dict[tuple[object, ...], float] = {}
    for key, values in period_values.items():
        diesel = values["diesel"]
        renewable = values["renewable"]
        physical = diesel + renewable
        aggregates[(*key, "physical_generation")] = physical
        aggregates[(*key, "diesel_generation")] = diesel
        aggregates[(*key, "renewable_generation")] = renewable
        aggregates[(*key, "renewable_share")] = renewable / physical if physical else 0.0
    return aggregates


def aggregate_renewable_technology_generation(
    connection: sqlite3.Connection,
) -> dict[tuple[object, ...], float]:
    """Aggregate solar, wind, and hydro separately for diagnostics."""
    renewable_technologies = {"GSOL_01", "GWND_01", "GHYD_01"}
    aggregates: dict[tuple[object, ...], float] = {}
    query = (
        "SELECT scenario, region, period, tech, flow FROM OutputFlowOut "
        "WHERE output_comm = 'ELC'"
    )
    for scenario, region, period, technology, flow in connection.execute(query):
        if technology not in renewable_technologies:
            continue
        key = (scenario, region, period, technology)
        aggregates[key] = aggregates.get(key, 0.0) + float(flow or 0.0)
    return aggregates


def aggregate_diesel_fuel(
    connection: sqlite3.Connection,
    *,
    include_season: bool = False,
) -> dict[tuple[object, ...], float]:
    """Aggregate DSL input to the diesel family by planning period."""
    season_column = ", season" if include_season else ""
    query = (
        f"SELECT scenario, region, period{season_column}, flow FROM OutputFlowIn "
        "WHERE input_comm = 'DSL' AND tech IN ('GDSL_01', 'GDSL_02', 'GDSL_03')"
    )
    aggregates: dict[tuple[object, ...], float] = {}
    for row in connection.execute(query):
        *dimensions, flow = row
        key = tuple(dimensions)
        aggregates[key] = aggregates.get(key, 0.0) + float(flow or 0.0)
    return aggregates


def aggregate_storage(
    connection: sqlite3.Connection,
    table: str,
) -> dict[tuple[object, ...], float]:
    """Aggregate storage charging or discharging by planning period."""
    commodity = "input_comm" if table == "OutputFlowIn" else "output_comm"
    query = (
        f"SELECT scenario, region, period, flow FROM {table} "
        f"WHERE tech = 'EBATT_01' AND {commodity} = 'ELC'"
    )
    aggregates: dict[tuple[object, ...], float] = {}
    for scenario, region, period, flow in connection.execute(query):
        key = (scenario, region, period)
        aggregates[key] = aggregates.get(key, 0.0) + float(flow or 0.0)
    return aggregates


def aggregate_demand_served(
    connection: sqlite3.Connection,
) -> dict[tuple[object, ...], float]:
    """Aggregate delivered electricity by period and season."""
    aggregates: dict[tuple[object, ...], float] = {}
    query = (
        "SELECT scenario, region, period, season, flow FROM OutputFlowOut "
        "WHERE output_comm = 'ELECD'"
    )
    for scenario, region, period, season, flow in connection.execute(query):
        key = (scenario, region, period, season)
        aggregates[key] = aggregates.get(key, 0.0) + float(flow or 0.0)
    return aggregates


def aggregate_commodity_period(
    connection: sqlite3.Connection,
    table: str,
    commodity: str,
) -> dict[tuple[object, ...], float]:
    """Aggregate one intermediate commodity by region and planning period."""
    column = "input_comm" if table == "OutputFlowIn" else "output_comm"
    query = (
        f"SELECT scenario, region, period, flow FROM {table} "
        f"WHERE {column} = ?"
    )
    aggregates: dict[tuple[object, ...], float] = {}
    for scenario, region, period, flow in connection.execute(query, (commodity,)):
        key = (scenario, region, period)
        aggregates[key] = aggregates.get(key, 0.0) + float(flow or 0.0)
    return aggregates


def aggregate_flow_technologies(
    connection: sqlite3.Connection,
    table: str,
    technologies: set[str],
) -> dict[tuple[object, ...], float]:
    """Aggregate selected technologies by region and planning period."""
    placeholders = ", ".join("?" for _ in technologies)
    query = (
        f"SELECT scenario, region, period, tech, flow FROM {table} "
        f"WHERE tech IN ({placeholders})"
    )
    aggregates: dict[tuple[object, ...], float] = {}
    for scenario, region, period, technology, flow in connection.execute(
        query, tuple(sorted(technologies))
    ):
        key = (scenario, region, period, technology)
        aggregates[key] = aggregates.get(key, 0.0) + float(flow or 0.0)
    return aggregates


def aggregate_optional_outputs(
    connection: sqlite3.Connection,
) -> dict[tuple[object, ...], float]:
    """Aggregate curtailment, unmet-demand, and slack outputs when represented."""
    candidates = [
        name
        for name in table_names(connection)
        if name.startswith("Output")
        and any(term in name.lower() for term in ("curtail", "unmet", "slack"))
    ]
    aggregates: dict[tuple[object, ...], float] = {}
    for table in candidates:
        columns = connection.execute(
            f"PRAGMA table_info({quote_identifier(table)})"
        ).fetchall()
        names = {column[1] for column in columns}
        if not {"region", "period"} <= names:
            continue
        values = [
            column[1]
            for column in columns
            if column[1] not in {"period", "vintage"}
            and any(
                kind in (column[2] or "").upper()
                for kind in ("REAL", "FLOAT", "NUMERIC")
            )
        ]
        for value_column in values:
            query = (
                f"SELECT scenario, region, period, {quote_identifier(value_column)} "
                f"FROM {quote_identifier(table)}"
            )
            for scenario, region, period, value in connection.execute(query):
                key = (table, scenario, region, period, value_column)
                aggregates[key] = aggregates.get(key, 0.0) + float(value or 0.0)
    return aggregates


def select_metrics(
    aggregates: dict[tuple[object, ...], float],
    metrics: set[str],
) -> dict[tuple[object, ...], float]:
    """Select named metrics from a generation-summary mapping."""
    return {key: value for key, value in aggregates.items() if key[-1] in metrics}


def build_storage_cycle_diagnostics(
    reference: sqlite3.Connection,
    generated: sqlite3.Connection,
) -> tuple[list[str], bool]:
    """Calculate per-period storage-cycle and physical-generation differences."""
    reference_charging = aggregate_storage(reference, "OutputFlowIn")
    generated_charging = aggregate_storage(generated, "OutputFlowIn")
    reference_discharging = aggregate_storage(reference, "OutputFlowOut")
    generated_discharging = aggregate_storage(generated, "OutputFlowOut")
    reference_generation = select_metrics(
        aggregate_generation_summary(reference), {"physical_generation"}
    )
    generated_generation = select_metrics(
        aggregate_generation_summary(generated), {"physical_generation"}
    )
    base_keys = (
        set(reference_charging)
        | set(generated_charging)
        | set(reference_discharging)
        | set(generated_discharging)
    )
    diagnostics: list[str] = []
    alternative_cycle = False
    for key in sorted(base_keys, key=repr):
        charging_difference = generated_charging.get(key, 0.0) - reference_charging.get(
            key, 0.0
        )
        discharging_difference = generated_discharging.get(
            key, 0.0
        ) - reference_discharging.get(key, 0.0)
        net_loss_difference = charging_difference - discharging_difference
        generation_key = (*key, "physical_generation")
        generation_difference = generated_generation.get(
            generation_key, 0.0
        ) - reference_generation.get(generation_key, 0.0)
        diagnostics.append(
            f"{key!r}: charging difference={charging_difference:.12g}; "
            f"discharging difference={discharging_difference:.12g}; "
            f"net storage loss difference={net_loss_difference:.12g}; "
            f"total generation difference={generation_difference:.12g}"
        )
        if (
            generation_difference > 0.0
            and net_loss_difference > 0.0
            and numbers_match(
                generation_difference,
                net_loss_difference,
                relative_tolerance=STORAGE_REL_TOL,
                absolute_tolerance=STORAGE_ABS_TOL,
            )
        ):
            alternative_cycle = True
    return diagnostics, alternative_cycle


def scientific_comparison(
    reference_path: Path,
    generated_path: Path,
) -> ScientificReport:
    """Compare decision-relevant aggregates with scientific tolerances."""
    report = ScientificReport()
    report.row_differences = compare_databases(
        reference_path, generated_path, DEFAULT_TOLERANCE
    )

    with closing(open_read_only(reference_path)) as reference, closing(
        open_read_only(generated_path)
    ) as generated:
        required = {spec.name for spec in TABLE_SPECS}
        for database_label, connection in (("reference", reference), ("generated", generated)):
            missing = sorted(required - table_names(connection))
            if missing:
                report.failures.append(
                    f"{database_label} database missing tables: {', '.join(missing)}"
                )
        if report.failures:
            return report

        try:
            report.objective_reference = objective_value(reference)
            report.objective_generated = objective_value(generated)
        except (sqlite3.Error, ValueError) as error:
            report.failures.append(str(error))
            return report

        report.objective_absolute_difference = abs(
            report.objective_reference - report.objective_generated
        )
        report.objective_relative_difference = relative_difference(
            report.objective_reference, report.objective_generated
        )
        report.objective_passed = numbers_match(
            report.objective_reference,
            report.objective_generated,
            relative_tolerance=OBJECTIVE_REL_TOL,
            absolute_tolerance=OBJECTIVE_ABS_TOL,
        )
        if not report.objective_passed:
            report.failures.append("objective values exceed scientific tolerances")

        capacity_failures: list[str] = []
        for table in ("OutputBuiltCapacity", "OutputNetCapacity"):
            capacity_failures.extend(
                compare_aggregates(
                    table,
                    aggregate_capacity(
                        reference, table, families=True, include_nonphysical=False
                    ),
                    aggregate_capacity(
                        generated, table, families=True, include_nonphysical=False
                    ),
                    CAPACITY_REL_TOL,
                    CAPACITY_ABS_TOL,
                )
            )
            individual = compare_aggregates(
                f"{table} individual-unit diagnostic",
                aggregate_capacity(
                    reference, table, families=False, include_nonphysical=False
                ),
                aggregate_capacity(
                    generated, table, families=False, include_nonphysical=False
                ),
                CAPACITY_REL_TOL,
                CAPACITY_ABS_TOL,
            )
            report.warnings.extend(individual)
            elect = compare_aggregates(
                f"{table} ELECT diagnostic",
                {
                    key: value
                    for key, value in aggregate_capacity(
                        reference, table, families=False, include_nonphysical=True
                    ).items()
                    if key[-1] == "ELECT"
                },
                {
                    key: value
                    for key, value in aggregate_capacity(
                        generated, table, families=False, include_nonphysical=True
                    ).items()
                    if key[-1] == "ELECT"
                },
                CAPACITY_REL_TOL,
                CAPACITY_ABS_TOL,
            )
            report.warnings.extend(elect)
        report.capacity_passed = not capacity_failures
        report.failures.extend(capacity_failures)

        emission_failures = compare_aggregates(
            "OutputEmission",
            aggregate_emissions(reference),
            aggregate_emissions(generated),
            EMISSION_REL_TOL,
            EMISSION_ABS_TOL,
        )
        report.emissions_passed = not emission_failures
        report.failures.extend(emission_failures)

        cost_failures = compare_aggregates(
            "OutputCost planning-period total",
            aggregate_period_costs(reference),
            aggregate_period_costs(generated),
            COST_REL_TOL,
            COST_ABS_TOL,
        )
        reference_discounted = discounted_cost_total(reference)
        generated_discounted = discounted_cost_total(generated)
        for label, total, objective in (
            ("reference", reference_discounted, report.objective_reference),
            ("generated", generated_discounted, report.objective_generated),
        ):
            if not numbers_match(
                total,
                objective,
                relative_tolerance=COST_REL_TOL,
                absolute_tolerance=COST_ABS_TOL,
            ):
                cost_failures.append(
                    f"{label} discounted OutputCost total {total!r} does not "
                    f"match objective {objective!r}"
                )
        individual_costs = compare_aggregates(
            "OutputCost individual-unit diagnostic",
            aggregate_costs(reference, families=False),
            aggregate_costs(generated, families=False),
            COST_REL_TOL,
            COST_ABS_TOL,
        )
        report.warnings.extend(individual_costs)
        report.costs_passed = not cost_failures
        report.failures.extend(cost_failures)

        reference_generation = aggregate_generation_summary(reference)
        generated_generation = aggregate_generation_summary(generated)
        generation_failures = compare_aggregates(
            "Planning-period physical and renewable generation",
            select_metrics(
                reference_generation,
                {"physical_generation", "renewable_generation", "renewable_share"},
            ),
            select_metrics(
                generated_generation,
                {"physical_generation", "renewable_generation", "renewable_share"},
            ),
            GENERATION_REL_TOL,
            GENERATION_ABS_TOL,
        )
        generation_failures.extend(
            compare_aggregates(
                "Planning-period diesel generation",
                select_metrics(reference_generation, {"diesel_generation"}),
                select_metrics(generated_generation, {"diesel_generation"}),
                DIESEL_REL_TOL,
                DIESEL_ABS_TOL,
            )
        )
        report.generation_passed = not generation_failures
        report.failures.extend(generation_failures)

        renewable_diagnostics = compare_aggregates(
            "Renewable technology generation diagnostic",
            aggregate_renewable_technology_generation(reference),
            aggregate_renewable_technology_generation(generated),
            GENERATION_REL_TOL,
            GENERATION_ABS_TOL,
        )
        if renewable_diagnostics and report.generation_passed:
            report.warnings.append(
                "solar, wind, or hydro generation differs while total renewable "
                "generation matches; the solver returned an alternative renewable "
                "dispatch allocation, so exact technology dispatch was not reproduced"
            )

        diesel_failures = compare_aggregates(
            "Diesel fuel use",
            aggregate_diesel_fuel(reference),
            aggregate_diesel_fuel(generated),
            DIESEL_REL_TOL,
            DIESEL_ABS_TOL,
        )
        report.diesel_fuel_passed = not diesel_failures
        report.failures.extend(diesel_failures)

        storage_failures: list[str] = []
        for table, direction in (
            ("OutputFlowIn", "charging"),
            ("OutputFlowOut", "discharging"),
        ):
            storage_failures.extend(
                compare_aggregates(
                    f"Storage {direction}",
                    aggregate_storage(reference, table),
                    aggregate_storage(generated, table),
                    STORAGE_REL_TOL,
                    STORAGE_ABS_TOL,
                )
            )
        report.storage_passed = not storage_failures
        report.failures.extend(storage_failures)
        (
            report.storage_cycle_diagnostics,
            alternative_storage_cycle,
        ) = build_storage_cycle_diagnostics(reference, generated)
        if alternative_storage_cycle and report.storage_passed:
            report.warnings.append(
                "The regenerated solution contains a small alternative "
                "storage-cycling allocation."
            )

        demand_failures = compare_aggregates(
            "Demand served",
            aggregate_demand_served(reference),
            aggregate_demand_served(generated),
            DEMAND_REL_TOL,
            DEMAND_ABS_TOL,
        )
        report.demand_passed = not demand_failures
        report.failures.extend(demand_failures)

        optional_failures = compare_aggregates(
            "Curtailment or unmet demand",
            aggregate_optional_outputs(reference),
            aggregate_optional_outputs(generated),
            OPTIONAL_OUTPUT_REL_TOL,
            OPTIONAL_OUTPUT_ABS_TOL,
        )
        report.curtailment_passed = not optional_failures
        report.failures.extend(optional_failures)

        seasonal_diesel = compare_aggregates(
            "Seasonal diesel allocation diagnostic",
            aggregate_diesel_fuel(reference, include_season=True),
            aggregate_diesel_fuel(generated, include_season=True),
            DIAGNOSTIC_FLOW_REL_TOL,
            DIAGNOSTIC_FLOW_ABS_TOL,
        )
        if seasonal_diesel:
            report.warnings.append(
                f"seasonal diesel allocation differs in "
                f"{len(seasonal_diesel)} group(s); seasonal dispatch was not reproduced"
            )

        for table in ("OutputFlowIn", "OutputFlowOut"):
            hourly = compare_aggregates(
                f"{table} time-slice diagnostic",
                aggregate_flows(reference, table),
                aggregate_flows(generated, table),
                DIAGNOSTIC_FLOW_REL_TOL,
                DIAGNOSTIC_FLOW_ABS_TOL,
            )
            if hourly:
                report.warnings.append(
                    f"{table} differs in {len(hourly)} time-slice commodity "
                    "group(s); hourly dispatch was not reproduced"
                )
            ethos = compare_aggregates(
                f"{table} ethos diagnostic",
                aggregate_commodity_period(reference, table, "ethos"),
                aggregate_commodity_period(generated, table, "ethos"),
                0.0,
                DEFAULT_TOLERANCE,
            )
            if ethos:
                report.warnings.append(
                    f"{table} ethos flow differs in {len(ethos)} period group(s)"
                )
            for diagnostic, technologies in (
                ("individual diesel-unit", DIESEL_TECHNOLOGIES),
                ("ELECT", NONPHYSICAL_TECHNOLOGIES),
            ):
                technology_differences = compare_aggregates(
                    f"{table} {diagnostic} diagnostic",
                    aggregate_flow_technologies(reference, table, technologies),
                    aggregate_flow_technologies(generated, table, technologies),
                    DIAGNOSTIC_FLOW_REL_TOL,
                    DIAGNOSTIC_FLOW_ABS_TOL,
                )
                if technology_differences:
                    report.warnings.append(
                        f"{table} {diagnostic} flow differs in "
                        f"{len(technology_differences)} period group(s)"
                    )

    if report.row_differences:
        report.warnings.append(
            f"{len(report.row_differences)} strict row-level diagnostic "
            "difference(s) may reflect alternative optimal allocations"
        )
    return report


def database_path(directory: Path, slug: str) -> Path:
    """Return the solved database path for a scenario slug."""
    return directory / f"shungnak_{slug}_solved.sqlite"


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Compare generated Shungnak databases with reference results."
    )
    parser.add_argument(
        "scenario",
        nargs="?",
        type=str.upper,
        choices=tuple(SCENARIOS),
        help="optional single scenario to verify (for example, BAU or NZ_SUBSIDY)",
    )
    parser.add_argument(
        "--mode",
        choices=("scientific", "strict"),
        default="scientific",
        help="verification mode (default: scientific)",
    )
    parser.add_argument(
        "--tolerance",
        type=float,
        default=DEFAULT_TOLERANCE,
        help=(
            "absolute tolerance for strict row comparison and scientific "
            f"diagnostics (default: {DEFAULT_TOLERANCE:g})"
        ),
    )
    args = parser.parse_args()
    if args.tolerance < 0 or not math.isfinite(args.tolerance):
        parser.error("--tolerance must be a finite, nonnegative number")
    return args


def print_scientific_report(label: str, report: ScientificReport) -> None:
    """Print the required concise scientific comparison summary."""
    status = "PASS" if report.passed else "FAIL"
    print(f"[{label}] {status} - Planning-period scientific verification")
    print(
        "  objective: "
        f"absolute difference={report.objective_absolute_difference:.12g}; "
        f"relative difference={report.objective_relative_difference:.12g}; "
        f"{'PASS' if report.objective_passed else 'FAIL'}"
    )
    print(f"  physical capacity comparison: {'PASS' if report.capacity_passed else 'FAIL'}")
    print(f"  aggregate emissions comparison: {'PASS' if report.emissions_passed else 'FAIL'}")
    print(f"  aggregate cost comparison: {'PASS' if report.costs_passed else 'FAIL'}")
    print(f"  generation comparison: {'PASS' if report.generation_passed else 'FAIL'}")
    print(f"  diesel fuel comparison: {'PASS' if report.diesel_fuel_passed else 'FAIL'}")
    print(f"  storage comparison: {'PASS' if report.storage_passed else 'FAIL'}")
    for diagnostic in report.storage_cycle_diagnostics:
        print(f"  storage-cycle diagnostic: {diagnostic}")
    print(f"  demand served comparison: {'PASS' if report.demand_passed else 'FAIL'}")
    print(
        "  curtailment/unmet-demand comparison: "
        f"{'PASS' if report.curtailment_passed else 'FAIL'}"
    )
    print(f"  row-level diagnostic differences: {len(report.row_differences)}")
    for failure in report.failures:
        print(f"  FAILURE: {failure}")
    for warning in report.warnings:
        print(f"  WARNING: {warning}")


def main() -> int:
    args = parse_arguments()
    selected = (
        {args.scenario: SCENARIOS[args.scenario]} if args.scenario else SCENARIOS
    )
    failed = False

    for label, slug in selected.items():
        reference_path = database_path(REFERENCE_DIRECTORY, slug)
        generated_path = database_path(GENERATED_DIRECTORY, slug)
        missing = False
        for kind, path in (("reference", reference_path), ("generated", generated_path)):
            if not path.is_file():
                print(f"[{label}] FAIL: missing {kind} database: {path}")
                missing = True
                failed = True
        if missing:
            continue

        expected_internal_label = INTERNAL_SCENARIO_LABELS[slug]
        reference_labels = output_scenario_labels(reference_path)
        generated_labels = output_scenario_labels(generated_path)
        if reference_labels != {expected_internal_label}:
            print(
                f"[{label}] FAIL: reference internal scenario label is "
                f"{sorted(reference_labels)!r}; expected {expected_internal_label!r}"
            )
            failed = True
            continue
        if generated_labels != {expected_internal_label}:
            print(
                f"[{label}] FAIL: generated internal scenario label is "
                f"{sorted(generated_labels)!r}; expected {expected_internal_label!r}"
            )
            failed = True
            continue

        try:
            if args.mode == "strict":
                differences = compare_databases(
                    reference_path, generated_path, args.tolerance
                )
                status = "PASS" if not differences else "FAIL"
                print(f"[{label}] {status} (strict)")
                try:
                    with closing(open_read_only(reference_path)) as reference, closing(
                        open_read_only(generated_path)
                    ) as generated:
                        reference_objective = objective_value(reference)
                        generated_objective = objective_value(generated)
                    print(
                        "  objective: absolute difference="
                        f"{abs(reference_objective-generated_objective):.12g}; "
                        "relative difference="
                        f"{relative_difference(reference_objective, generated_objective):.12g}"
                    )
                except ValueError as error:
                    print(f"  objective: FAIL ({error})")
                print("  physical capacity comparison: strict row-level")
                print("  aggregate emissions comparison: strict row-level")
                print("  aggregate cost comparison: strict row-level")
                print("  aggregate flow comparison: strict row-level")
                print(f"  row-level diagnostic differences: {len(differences)}")
                for difference in differences:
                    print(f"  - {difference}")
                failed |= bool(differences)
            else:
                report = scientific_comparison(reference_path, generated_path)
                print_scientific_report(label, report)
                failed |= not report.passed
        except (sqlite3.Error, OSError, ValueError) as error:
            print(f"[{label}] FAIL: could not compare databases: {error}")
            failed = True

    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
