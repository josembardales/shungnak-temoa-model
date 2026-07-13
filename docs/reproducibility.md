# Reproducing the Shungnak Temoa Model

## 1. Scope

This document explains how to rebuild, solve, verify, and inspect the Shungnak Temoa capacity expansion model contained in this repository.

The associated study uses two modeling layers:

1. Temoa for long term capacity expansion and investment planning.
2. A separate rolling horizon unit commitment model for hourly operational screening.

This repository contains the Temoa planning component. The workflow described here does not reproduce the rolling horizon unit commitment analysis, hourly commitment schedules, or operational results from that separate model.

The reproducible Temoa workflow includes:

- rebuilding six SQLite input databases from version controlled SQL files;
- solving all six planning scenarios with Temoa;
- comparing newly generated results with archived reference results;
- running repository tests; and
- exporting archived result tables to CSV.

The authoritative editable model inputs are stored under:

`model_inputs/sql/`

The common model assumptions are documented in:

`docs/model_documentation.md`

The exact scenario differences are documented in:

`docs/scenario_definitions.md`

## 2. Validated software environment

The following environment was used to rebuild, solve, and verify all six scenarios.

| Component | Version or requirement |
|---|---|
| Temoa | 3.0 |
| Temoa database schema | 3.0 |
| Python | 3.12.10 used for validation |
| Minimum Python version | 3.11 |
| Pyomo | 6.8.0 |
| CBC | 2.10.12 |
| pytest | 8.3.2 |

Temoa is an external dependency and is not included in this repository. A researcher must obtain a working Temoa 3.0 source checkout separately.

The Temoa source root supplied to the runner must contain at least:

```text
main.py
definitions.py
temoa/
temoa/version_information.py
temoa/temoa_model/
