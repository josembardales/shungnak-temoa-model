"""Run the six reproducible Shungnak scenarios with Temoa 3.0 source."""

from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
import tomllib
from dataclasses import dataclass
from pathlib import Path
from typing import TextIO


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
CONFIG_DIRECTORY = REPOSITORY_ROOT / "configs"
INPUT_DIRECTORY = REPOSITORY_ROOT / "build" / "input_databases"
OUTPUT_DIRECTORY = REPOSITORY_ROOT / "results" / "generated" / "databases"
SCENARIO_OUTPUT_DIRECTORY = REPOSITORY_ROOT / "results" / "generated" / "outputs"
LOG_DIRECTORY = REPOSITORY_ROOT / "results" / "generated" / "logs"


@dataclass(frozen=True)
class Scenario:
    """Paths and identifiers associated with one TEMOA scenario."""

    label: str
    slug: str
    internal_label: str

    @property
    def config_path(self) -> Path:
        return CONFIG_DIRECTORY / f"config_shungnak_{self.slug}.toml"

    @property
    def input_path(self) -> Path:
        return INPUT_DIRECTORY / f"shungnak_{self.slug}.sqlite"

    @property
    def output_path(self) -> Path:
        return OUTPUT_DIRECTORY / f"shungnak_{self.slug}_solved.sqlite"

    @property
    def log_path(self) -> Path:
        return LOG_DIRECTORY / f"{self.slug}_runner.log"

    @property
    def scenario_output_path(self) -> Path:
        return SCENARIO_OUTPUT_DIRECTORY / self.slug


SCENARIOS = (
    Scenario("BAU", "bau", "BAU"),
    Scenario("BAU_UR", "bau_ur", "BAU_UR"),
    Scenario("CP_MID", "cp_mid", "CP_MID"),
    Scenario("HDP", "hdp", "HDP"),
    Scenario("NZ", "nz", "NZ"),
    Scenario("NZ_SUBSIDY", "nz_subsidy", "SUBSIDY"),
)
SCENARIOS_BY_LABEL = {scenario.label: scenario for scenario in SCENARIOS}


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Run Shungnak scenarios with the Temoa 3.0 source interface."
    )
    parser.add_argument(
        "scenario",
        nargs="?",
        type=str.upper,
        choices=tuple(SCENARIOS_BY_LABEL),
        help="optional single scenario to run (for example, BAU or NZ_SUBSIDY)",
    )
    parser.add_argument(
        "--temoa-root",
        type=Path,
        default=os.environ.get("TEMOA_ROOT"),
        help=(
            "Temoa 3.0 source directory containing main.py (defaults to the "
            "TEMOA_ROOT environment variable)"
        ),
    )
    return parser.parse_args()


def relative(path: Path) -> Path:
    """Return a repository-relative path for readable messages."""
    return path.relative_to(REPOSITORY_ROOT)


def run_command(command: list[str], log: TextIO) -> None:
    """Run Temoa, capturing its console output in the scenario runner log."""
    rendered_command = subprocess.list2cmdline(command)
    log.write(f"\n$ {rendered_command}\n")
    log.flush()

    try:
        completed = subprocess.run(
            command,
            cwd=REPOSITORY_ROOT,
            stdout=log,
            stderr=subprocess.STDOUT,
            text=True,
            check=False,
        )
    except OSError as error:
        raise RuntimeError(f"could not launch Temoa: {error}") from error

    if completed.returncode != 0:
        raise RuntimeError(
            f"command failed with exit code {completed.returncode}: {rendered_command}"
        )


def run_scenario(scenario: Scenario, temoa_root: Path) -> None:
    """Copy and solve one scenario, recording a dedicated runner log."""
    scenario.scenario_output_path.mkdir(parents=True, exist_ok=True)

    with scenario.log_path.open("w", encoding="utf-8", newline="\n") as log:
        log.write(f"Scenario: {scenario.label}\n")
        log.write(f"Temoa scenario label: {scenario.internal_label}\n")
        log.write(f"Configuration: {relative(scenario.config_path)}\n")
        log.write(f"Clean input: {relative(scenario.input_path)}\n")
        log.write(f"Solve output: {relative(scenario.output_path)}\n")
        log.write(f"Temoa source: {temoa_root}\n")
        log.write(f"Temoa output folder: {relative(scenario.scenario_output_path)}\n")
        log.flush()

        try:
            shutil.copy2(scenario.input_path, scenario.output_path)
            log.write("Copied clean input database to solve output.\n")
            log.flush()

            command = [
                sys.executable,
                str(temoa_root / "main.py"),
                "--config",
                str(scenario.config_path.resolve()),
                "--silent",
                "--output_path",
                str(scenario.scenario_output_path.resolve()),
            ]
            run_command(command, log)
        except (OSError, RuntimeError) as error:
            log.write(f"\nFAILURE: {error}\n")
            raise

        log.write("\nSUCCESS: Temoa run completed.\n")


def main() -> int:
    args = parse_arguments()
    if args.temoa_root is None:
        print(
            "ERROR: Temoa source directory is required; use --temoa-root or set TEMOA_ROOT.",
            file=sys.stderr,
        )
        return 1

    temoa_root = args.temoa_root.expanduser().resolve()
    selected = (
        (SCENARIOS_BY_LABEL[args.scenario],) if args.scenario else SCENARIOS
    )

    # Perform every preflight check before creating directories or copying data.
    required_temoa_paths = (
        temoa_root / "main.py",
        temoa_root / "temoa" / "version_information.py",
    )
    missing_temoa_paths = [
        path for path in required_temoa_paths if not path.exists()
    ]
    missing_inputs = [
        scenario.input_path
        for scenario in selected
        if not scenario.input_path.is_file()
    ]
    missing_configs = [
        scenario.config_path
        for scenario in selected
        if not scenario.config_path.is_file()
    ]
    config_label_errors: list[str] = []
    for scenario in selected:
        if not scenario.config_path.is_file():
            continue
        try:
            with scenario.config_path.open("rb") as config_file:
                configured_label = tomllib.load(config_file).get("scenario")
        except (OSError, tomllib.TOMLDecodeError) as error:
            config_label_errors.append(f"{relative(scenario.config_path)}: {error}")
            continue
        if configured_label != scenario.internal_label:
            config_label_errors.append(
                f"{relative(scenario.config_path)}: expected scenario "
                f"{scenario.internal_label!r}, found {configured_label!r}"
            )
    if missing_temoa_paths or missing_inputs or missing_configs or config_label_errors:
        for path in missing_temoa_paths:
            print(
                f"ERROR: required Temoa source path does not exist: {path}",
                file=sys.stderr,
            )
        for path in missing_inputs:
            print(f"ERROR: input database does not exist: {relative(path)}", file=sys.stderr)
        for path in missing_configs:
            print(f"ERROR: configuration does not exist: {relative(path)}", file=sys.stderr)
        for error in config_label_errors:
            print(f"ERROR: configuration scenario-label mismatch: {error}", file=sys.stderr)
        return 1

    OUTPUT_DIRECTORY.mkdir(parents=True, exist_ok=True)
    SCENARIO_OUTPUT_DIRECTORY.mkdir(parents=True, exist_ok=True)
    LOG_DIRECTORY.mkdir(parents=True, exist_ok=True)

    for scenario in selected:
        print(f"[{scenario.label}] Copying clean input database...")
        try:
            run_scenario(scenario, temoa_root)
        except (OSError, RuntimeError) as error:
            print(f"[{scenario.label}] FAILURE: {error}", file=sys.stderr)
            print(f"See log: {relative(scenario.log_path)}", file=sys.stderr)
            return 1
        print(f"[{scenario.label}] SUCCESS: Temoa run completed.")
        print(f"Log: {relative(scenario.log_path)}")

    print(f"Completed {len(selected)} scenario(s) successfully.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
