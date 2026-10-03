# Shungnak Temoa Scenario Definitions

## 1. Purpose

This repository contains six Temoa planning scenarios designed to examine how technology access, delivered diesel prices, carbon pricing, diesel retention requirements, and capital support affect the modeled Shungnak energy system.

The scenarios are comparative planning cases rather than forecasts. They do not represent probabilities or predictions of future policy. Each scenario changes a limited set of model inputs while retaining a common representation of demand, existing assets, renewable resource profiles, technology performance, planning periods, and most technology costs.

The version controlled SQL files under `model_inputs/sql/` are the authoritative scenario definitions. The descriptions below summarize the differences encoded in those files.

## 2. Assumptions shared across scenarios

Unless stated otherwise, all six scenarios use the same:

| Category | Common assumption |
|---|---|
| Region | Shungnak |
| Planning horizon | 2025 through 2045 |
| Investment periods | 2030, 2035, 2040, and 2045 |
| Demand growth | 1% annually |
| Planning reserve margin | 50% |
| Existing diesel capacity | Two 505 kW units and one 363 kW unit |
| Existing solar capacity | 186.3 kW |
| Existing battery capacity | 250 kW |
| Solar total capacity ceiling | 1,000 kW |
| Solar maximum new capacity | 250 kW per period |
| Wind total capacity ceiling | 500 kW |
| Wind maximum new capacity when available | 200 kW per period |
| Hydropower capacity ceiling | 144 kW |
| Hydropower maximum new capacity when available | 144 kW |
| Battery maximum new capacity | 250 kW per period |
| Renewable resource profiles | Common across all scenarios |
| Technology lifetimes | Common across all scenarios |
| Operational emissions factors | Common across all scenarios |

Detailed common assumptions are documented in `docs/model_documentation.md`.

## 3. Scenario label mapping

The repository, Temoa output databases, and [published article](https://doi.org/10.1016/j.jclepro.2026.149361) use slightly different naming conventions for some scenarios.

| Repository label | Internal Temoa label | Published article label |
|---|---|---|
| `BAU` | `BAU` | BAU |
| `BAU_UR` | `BAU_UR` | BAU UR or Unrestrained Reference |
| `CP_MID` | `CP_MID` | CP mid or Moderate Carbon Price |
| `HDP` | `HDP` | HDP or High Diesel Price |
| `NZ` | `NZ` | NZ or Net Zero |
| `NZ_SUBSIDY` | `SUBSIDY` | Policy Support, SUBSIDY, or NZ Subsidy |

`NZ_SUBSIDY` is the public repository name used by the build, run, and verification scripts. Inside the solved Temoa database, the same scenario is labeled `SUBSIDY`.

## 4. Scenario comparison

### 4.1 Carbon prices

Carbon prices are applied to modeled operational carbon dioxide emissions.

| Scenario | 2030 | 2035 | 2040 | 2045 |
|---|---:|---:|---:|---:|
| `BAU` | 0 | 0 | 0 | 0 |
| `BAU_UR` | 0 | 0 | 0 | 0 |
| `CP_MID` | 60 | 105 | 150 | 195 |
| `HDP` | 0 | 0 | 0 | 0 |
| `NZ` | 150 | 275 | 400 | 500 |
| `NZ_SUBSIDY` | 150 | 275 | 400 | 500 |

Values are expressed in USD per metric ton of carbon dioxide.

### 4.2 Diesel import costs

The base diesel cost schedule is used in every scenario except `HDP`.

| Period | Base schedule | HDP schedule |
|---:|---:|---:|
| 2030 | 0.6300 | 0.9450 |
| 2035 | 0.6426 | 0.9639 |
| 2040 | 0.6554 | 0.9831 |
| 2045 | 0.6685 | 1.0028 |

Values are expressed in USD per kWh of diesel energy input.

The HDP values are 50% above the base schedule and correspond to an assumed delivered diesel price of approximately 12.75 USD per gallon rather than approximately 8.50 USD per gallon.

### 4.3 Technology access

| Scenario | New solar | New battery | New wind | New hydropower |
|---|---|---|---|---|
| `BAU` | Available | Available | Disabled | Disabled |
| `BAU_UR` | Available | Available | Available | Available |
| `CP_MID` | Available | Available | Available | Available |
| `HDP` | Available | Available | Available | Available |
| `NZ` | Available | Available | Available | Available |
| `NZ_SUBSIDY` | Available | Available | Available | Available |

When wind and hydropower are available, wind additions are limited to 200 kW per period and hydropower additions are limited to 144 kW. The total wind capacity ceiling is 500 kW and the hydropower capacity ceiling is 144 kW.

The term Unrestrained Reference means that the BAU exclusion of wind and hydropower is relaxed. It does not mean that all technology deployment limits are removed.

### 4.4 Investment costs

All scenarios use the standard technology investment costs except `NZ_SUBSIDY`.

`NZ_SUBSIDY` applies a 30% reduction to the investment costs of:

| Technology |
|---|
| Solar photovoltaic generation |
| Distributed wind |
| Run of river hydropower |
| Battery storage |

Diesel generator investment costs are not reduced.

The 30% reduction is a generic capital support sensitivity. It does not represent one specific grant, tax credit, or funding program.

### 4.5 Diesel minimum capacity conditions

The model uses minimum capacity requirements to retain diesel capacity during selected planning periods.

| Scenario | 505 kW units, `GDSL_01` and `GDSL_03` | 363 kW unit, `GDSL_02` |
|---|---|---|
| `BAU` | Required through 2035; retirement permitted from 2040 | Retained through 2045 |
| `BAU_UR` | Required through 2035; retirement permitted from 2040 | Retained through 2045 |
| `CP_MID` | Minimum requirement removed in 2035; earlier retirement permitted | Retained through 2045 |
| `HDP` | Required through 2035; retirement permitted from 2040 | Retained through 2045 |
| `NZ` | Required through 2035; retirement permitted from 2040 | Retained through 2045 |
| `NZ_SUBSIDY` | Required through 2035; retirement permitted from 2040 | Retained through 2045 |

Removing a minimum capacity requirement permits retirement but does not by itself force retirement. The optimizer may retain or retire capacity depending on technology lifetime rules, costs, demand, and the other scenario inputs.

Within the repository SQL files, `NZ` does not add a separate forced diesel retirement constraint beyond the schedule shown above.

## 5. Individual scenario descriptions

### 5.1 BAU

`BAU` is the constrained Business as Usual Reference scenario.

It uses:

1. No carbon price.
2. The base diesel cost schedule.
3. Standard investment costs.
4. Solar and battery additions only.
5. No new wind or hydropower capacity.
6. The standard diesel minimum capacity schedule.

This scenario represents a pathway limited to renewable and storage technologies already present in the community. It is intended to show the consequences of continued reliance on solar, batteries, and diesel without access to wind or hydropower development.

### 5.2 BAU UR

`BAU_UR` is the Unrestrained Reference scenario.

It retains the BAU economic assumptions:

1. No carbon price.
2. The base diesel cost schedule.
3. Standard investment costs.
4. The standard diesel minimum capacity schedule.

Unlike BAU, it allows investment in wind and hydropower in addition to solar and battery storage.

This scenario isolates the effect of expanding technology access while retaining the same fuel and carbon price assumptions as BAU.

The scenario remains subject to the wind, hydropower, solar, and battery deployment limits documented above.

### 5.3 CP MID

`CP_MID` is the Moderate Carbon Price scenario.

It uses:

1. The base diesel cost schedule.
2. Standard investment costs.
3. Wind and hydropower access.
4. Carbon prices of 60, 105, 150, and 195 USD per metric ton of carbon dioxide in 2030, 2035, 2040, and 2045.
5. Earlier retirement permission for the two 505 kW diesel generators beginning in 2035.
6. Continued retention of the 363 kW diesel generator through 2045.

The earlier removal of the large diesel unit minimum capacity requirements permits the optimizer to retire those units sooner than in most other scenarios. It does not require their retirement if continued capacity remains economically selected.

### 5.4 HDP

`HDP` is the High Diesel Price scenario.

It uses the same technology access, investment costs, carbon price, and diesel minimum capacity conditions as BAU UR. Its defining change is a 50% increase in the diesel import cost schedule.

This scenario evaluates how exposure to higher delivered fuel prices affects the least cost portfolio.

Within the repository implementation, HDP does not remove the documented wind, hydropower, solar, or battery build limits. It differs from BAU UR through the diesel cost schedule.

### 5.5 NZ

`NZ` is the Net Zero policy pathway.

It uses:

1. The base diesel cost schedule.
2. Standard investment costs.
3. Wind and hydropower access.
4. Carbon prices of 150, 275, 400, and 500 USD per metric ton of carbon dioxide in 2030, 2035, 2040, and 2045.
5. The same diesel minimum capacity schedule used in BAU UR.

The high carbon price trajectory increases the economic cost of diesel generation and encourages low carbon investment and operation.

The repository does not encode an additional NZ specific forced retirement requirement for the two 505 kW diesel generators. Their minimum capacity requirements remain in place through 2035 and are removed from 2040 onward. Retirement after that point may be selected by the optimizer.

### 5.6 NZ Subsidy

`NZ_SUBSIDY` combines the NZ assumptions with capital support.

It uses:

1. The NZ carbon price trajectory.
2. The base diesel cost schedule.
3. Wind and hydropower access.
4. The same diesel minimum capacity schedule as NZ.
5. A 30% investment cost reduction for solar, wind, hydropower, and battery storage.

The scenario evaluates whether external capital support can reduce the cost of the modeled decarbonization pathway.

The repository uses `NZ_SUBSIDY` as the public name, while Temoa stores the internal scenario label as `SUBSIDY`.

## 6. Interpretation

The six scenarios are designed as policy relevant bounding cases. They are not a complete factorial experiment in which every input is varied independently.

Several scenarios change more than one planning condition. For example, CP MID changes both carbon prices and the timing at which the two larger diesel units may retire. Differences between scenarios should therefore be interpreted as the combined effect of the assumptions encoded in each case.

The scenario results are conditional on the common Shungnak demand profile, resource profiles, technology costs, Arctic uplift assumptions, capacity limits, diesel performance, and hydropower proxy described in `docs/model_documentation.md`.

Exact database values can be inspected in the corresponding SQL files under `model_inputs/sql/`.

## 7. Related documentation

`docs/model_documentation.md` describes the common model structure and assumptions.

`docs/reproducibility.md` explains how to build, solve, verify, and export the scenarios.

`provenance/data_sources.csv` provides the parameter source inventory.
