# Shungnak Community Energy System Model for TEMOA 3.0

Public research repository supporting **Optimal sizing of hybrid renewable energy systems in rural Alaska**, published in the *Journal of Cleaner Production*.

## Publication

Bardales, J. M., Le, H. V., Kaminsky, J., & de Queiroz, A. R. (2026). *Optimal sizing of hybrid renewable energy systems in rural Alaska*. Journal of Cleaner Production, 576, 149361. https://doi.org/10.1016/j.jclepro.2026.149361

**[Published article (DOI)](https://doi.org/10.1016/j.jclepro.2026.149361)**

## Research overview

This repository contains a scenario based capacity expansion model of the Shungnak community energy system using TEMOA 3.0. It represents electricity demand, diesel generation, solar photovoltaic generation, distributed wind, small hydropower, and battery storage.

The model evaluates long term planning pathways from 2025 through 2045 under alternative economic, technology, and policy assumptions. The repository includes version controlled model inputs, scenario configurations, archived reference results, provenance information, and scripts for rebuilding, solving, exporting, and verifying the model.

The scenarios are intended for comparative planning analysis rather than prediction of a single future.

## Repository scope

This repository reproduces the TEMOA capacity expansion component of the published study, including its model inputs, scenario configurations, automation scripts, documentation, and archived planning results.

The study also uses a separate rolling horizon unit commitment model to screen selected portfolios under chronological operating constraints. That operational model, its hourly dispatch outputs, and its unit commitment results are not reproduced by this repository.

## Reproducibility status

All six TEMOA scenarios have been rebuilt from the version controlled SQL inputs, solved with TEMOA 3.0 and CBC, and verified against archived aggregate planning results. The repository test suite was also run successfully.

Small differences in generator level, technology specific, seasonal, or time slice allocations may occur when the model contains alternative optimal solutions. Scientific verification focuses on the aggregate planning quantities used to support the main TEMOA findings. See [Reproducibility](docs/reproducibility.md) for the validation scope, tolerances, and interpretation.

## Quick start

TEMOA 3.0 and CBC must be installed separately. Run the workflow using a Python environment that already contains TEMOA, Pyomo, and their required dependencies.

`requirements-dev.txt` installs pytest only. It does not install TEMOA, Pyomo, or CBC.

```bash
git clone https://github.com/josembardales/shungnak-temoa-model.git
cd shungnak-temoa-model

python -m pip install -r requirements-dev.txt
python scripts/build_databases.py
python scripts/run_scenarios.py --temoa-root <TEMOA_ROOT>
python scripts/verify_results.py --mode scientific
python -m pytest
```

Run all commands from the repository root. Replace `<TEMOA_ROOT>` with the root of a TEMOA 3.0 source checkout.

## Scenarios

| Scenario | Description |
|---|---|
| `BAU` | Business as usual reference with no carbon price and no new wind or hydropower capacity. |
| `BAU_UR` | Unrestrained reference with BAU economic assumptions and access to wind and hydropower, subject to the documented deployment limits. |
| `CP_MID` | Moderate carbon price pathway of 60, 105, 150, and 195 USD/tCO₂ in 2030 through 2045, with earlier retirement permitted for two diesel units. |
| `HDP` | High diesel price sensitivity with diesel import costs 50% above the base schedule. |
| `NZ` | Net zero policy pathway with carbon prices of 150, 275, 400, and 500 USD/tCO₂ in 2030 through 2045. |
| `NZ_SUBSIDY` | NZ assumptions plus a 30% reduction in solar, wind, hydropower, and battery investment costs. |

The scenarios represent alternative planning assumptions and policy pathways rather than forecasts. Their exact input differences are documented in [Scenario definitions](docs/scenario_definitions.md).

## Repository contents

```text
configs/                                    TEMOA scenario configuration files
docs/                                       Model, scenario, and reproducibility documentation
model_inputs/sql/                           Authoritative editable model inputs
provenance/data_sources.csv                 Concise parameter source inventory
results/reference/databases/                Archived solved benchmark databases
results/reference/csv/                      Reference result exports
results/reference/xlsx/                     Archived Excel result exports
results/reference/pyam/                     Archived pyam-format Excel exports
results/reference/logs/                     Archived TEMOA run logs
results/reference/verification_summary.csv  Archived verification summary
results/diagnostics/commodity_networks/     HTML commodity network diagrams
scripts/                                    Build, run, export, and verification tools
tests/                                      Repository tests
requirements-dev.txt                        Testing dependency
CITATION.cff                                Citation metadata
LICENSE                                     Repository license and scope notice

build/input_databases/                      Locally generated input databases
results/generated/                          Locally generated TEMOA results and logs
```

The SQL files under `model_inputs/sql/` are the authoritative editable inputs. The SQLite files under `build/input_databases/` are derived from those SQL files.

Archived reference databases remain version controlled under `results/reference/databases/`. Newly solved databases and logs are written under `results/generated/`, which is ignored by Git.

## Reproducing the model

### Software requirements

The validated environment used:

- Python 3.12.10
- TEMOA 3.0
- TEMOA database schema 3.0
- Pyomo 6.8.0
- CBC 2.10.12
- pytest 8.3.2

Python 3.11 or later is required by TEMOA 3.0.

Later compatible software versions may work, but changes in optimization software can affect exact allocations when several solutions have the same or nearly the same objective value. See [Reproducibility](docs/reproducibility.md) for environment and workflow details.

### Build the input databases

```bash
python scripts/build_databases.py
```

This creates clean SQLite input databases under `build/input_databases/`.

### Run the scenarios

Run all six scenarios:

```bash
python scripts/run_scenarios.py --temoa-root <TEMOA_ROOT>
```

Run one scenario:

```bash
python scripts/run_scenarios.py NZ_SUBSIDY --temoa-root <TEMOA_ROOT>
```

The TEMOA source location can also be provided through the `TEMOA_ROOT` environment variable.

Bash:

```bash
export TEMOA_ROOT=<TEMOA_ROOT>
python scripts/run_scenarios.py
```

PowerShell:

```powershell
$env:TEMOA_ROOT = "<TEMOA_ROOT>"
python scripts/run_scenarios.py
```

New solved databases, logs, and related outputs are written under `results/generated/`.

### Verify the results

Run scientific verification for all scenarios:

```bash
python scripts/verify_results.py --mode scientific
```

Scientific mode compares aggregate planning results such as objective values, capacities, costs, emissions, diesel generation, total renewable generation, storage totals, and demand served.

Strict mode compares complete output rows and is intended for diagnostics:

```bash
python scripts/verify_results.py BAU --mode strict
```

Strict mode may report differences when the solver returns an alternative optimal allocation. A scientific pass does not guarantee identical technology specific or time slice level activity.

The verifier applies only to the TEMOA planning results in this repository. It does not verify rolling horizon unit commitment results.

### Export the archived reference results

```bash
python scripts/export_results.py
```

The exporter reads the archived databases under `results/reference/databases/` and writes selected CSV tables under `results/reference/csv/`.

## Data provenance and limitations

The concise parameter source inventory is available in [provenance/data_sources.csv](provenance/data_sources.csv). Additional interpretation is provided in [Model documentation](docs/model_documentation.md).

The raw AVEC hourly demand records used to construct the load representation are confidential and are not redistributed. Some third party data and publications remain subject to their original providers' access and reuse terms.

Important modeling limitations include:

- one modeled community and region;
- perfect foresight within each scenario;
- four seasonal representative days rather than full year chronology;
- modeled or proxy renewable resource profiles;
- a planning level hydropower representation rather than a confirmed engineered project;
- simplified battery behavior in the capacity expansion model;
- operational diesel carbon dioxide emissions only;
- no distribution network, voltage, frequency, inertia, protection, or contingency analysis; and
- possible alternative optimal allocations among technologies and time slices.

Results should therefore be interpreted as conditional planning outcomes for the assumptions encoded in the repository, not as a detailed operational forecast or a complete engineering feasibility assessment.

## Documentation

- [Model documentation](docs/model_documentation.md): model structure, demand, technologies, costs, emissions, storage assumptions, data access, and limitations.
- [Scenario definitions](docs/scenario_definitions.md): confirmed differences among the six scenario input files.
- [Reproducibility](docs/reproducibility.md): software environment, database construction, scenario execution, testing, exporting, and verification.

## Citation

If you use this repository or the models/data associated with this work, please cite:

Bardales, J. M., Le, H. V., Kaminsky, J., & de Queiroz, A. R. (2026). Optimal sizing of hybrid renewable energy systems in rural Alaska. *Journal of Cleaner Production, 576*, 149361. https://doi.org/10.1016/j.jclepro.2026.149361

```bibtex
@article{bardales2026optimal,
  title={Optimal sizing of hybrid renewable energy systems in rural {Alaska}},
  author={Bardales, Jos{\'e} M. and Le, Hai Van and Kaminsky, Jessica and de Queiroz, Anderson R.},
  journal={Journal of Cleaner Production},
  volume={576},
  pages={149361},
  year={2026},
  publisher={Elsevier},
  doi={10.1016/j.jclepro.2026.149361}
}
```

[CITATION.cff](CITATION.cff) provides machine-readable repository metadata with the published article as the preferred citation. To identify the exact inputs and scripts used in your analysis, also record the repository URL and commit hash.

## License

The repository's original scripts and supporting code are available under the [MIT License](LICENSE). TEMOA remains an external dependency under its own license.

Third party datasets and publications remain subject to their original terms. The MIT License does not grant rights to externally owned materials.

## Contact

For questions, documentation corrections, or reproducibility issues, please [open a GitHub issue](https://github.com/josembardales/shungnak-temoa-model/issues).
