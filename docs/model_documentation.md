# Shungnak Temoa Model Documentation

## 1. Model scope

This repository contains the Temoa capacity expansion model developed for the Shungnak community energy system in rural Alaska. The model evaluates long term investment pathways for diesel generation, solar photovoltaic generation, distributed wind, small hydropower, and battery storage.

Temoa identifies the least cost combination of existing and new technologies that satisfies electricity demand under the technical, resource, economic, and policy assumptions defined for each scenario. The model is formulated as a linear program in Pyomo and was solved with the CBC solver.

The [published study](https://doi.org/10.1016/j.jclepro.2026.149361) also uses a separate rolling horizon unit commitment model to screen selected portfolios under chronological operating constraints. That operational model is outside the scope of this repository. The files here reproduce the Temoa planning component and its archived planning results.

The authoritative editable model inputs are the SQL files under:

`model_inputs/sql/`

Scenario specific differences are documented in:

`docs/scenario_definitions.md`

## 2. Planning structure

The model represents one region, identified as `shungnak`, and uses a planning horizon from 2025 through 2045.

| Item | Model representation |
|---|---|
| Baseline period | 2025 |
| Investment periods | 2030, 2035, 2040, and 2045 |
| Period spacing | Five years |
| Terminal boundary | 2050 |
| Modeled region | `shungnak` |
| Seasons | Spring, summer, fall, and winter |
| Intraday resolution | 24 hourly time slices per representative day |
| Planning reserve margin | 50% |
| Global discount rate | 10% |
| Default loan rate | 5% |

Each investment period is represented by four seasonal representative days with 24 hourly time slices. This structure captures seasonal and intraday variation while keeping the multi period optimization computationally manageable.

Temoa assumes perfect foresight within each scenario. Demand growth, technology costs, fuel prices, resource availability, and policy conditions are treated as known over the planning horizon.

## 3. Electricity demand

The demand trajectory is based on community load information provided through the Alaska Village Electric Cooperative and the Alaska Native Tribal Health Consortium.

The published article reports a 2025 baseline demand of approximately 1,657.4 MWh. The SQL demand table contains the following future period values, based on 1% annual growth:

| Period | Annual electricity demand |
|---:|---:|
| 2030 | 1,741.98 MWh |
| 2035 | 1,830.84 MWh |
| 2040 | 1,924.24 MWh |
| 2045 | 2,022.39 MWh |

Demand is distributed across four seasonal representative days derived from the 2023 load profile:

| Season | Representative date |
|---|---|
| Winter | 2023-01-05 |
| Spring | 2023-03-24 |
| Summer | 2023-07-20 |
| Fall | 2023-10-05 |

The raw AVEC hourly demand records are confidential and are not redistributed in this repository. The SQL files contain the aggregated annual demand and seasonal time slice distributions required by the Temoa model.

## 4. Existing assets

The baseline system contains three diesel generators, one solar photovoltaic installation, and one battery energy storage system.

| Technology code | Asset | Existing capacity |
|---|---|---:|
| `GDSL_01` | CAT 3456 diesel generator | 505 kW |
| `GDSL_02` | CAT 3406B diesel generator | 363 kW |
| `GDSL_03` | CAT 3456 diesel generator | 505 kW |
| `GSOL_01` | Existing solar photovoltaic array | 186.3 kW |
| `EBATT_01` | Existing battery power capacity | 250 kW |

The physical battery installation is described as a 250 kW and 384 kWh lithium ion system.

No existing wind or hydropower capacity is represented. Wind and hydropower enter the model as candidate planning technologies where permitted by the scenario.

Diesel retention and retirement conditions vary by scenario and are described in `docs/scenario_definitions.md`.

## 5. Candidate technologies and deployment limits

The model can consider new solar photovoltaic generation, distributed wind, run of river hydropower, battery storage, and diesel capacity subject to the scenario constraints.

| Technology | Total capacity limit | Maximum new capacity per period | Lifetime |
|---|---:|---:|---:|
| Solar photovoltaic | 1,000 kW | 250 kW | 30 years |
| Distributed wind | 500 kW | 200 kW | 20 years |
| Run of river hydropower | 144 kW | 144 kW | 100 years |
| Battery storage | No separate total ceiling documented | 250 kW | 15 years |
| Diesel generators | Governed by unit and scenario constraints | Scenario dependent | 20 years |

The solar and battery build limits represent staged construction in a remote community. The wind ceiling represents a village scale distributed wind deployment.

Hydropower is represented as one planning option with a maximum capacity of 144 kW. This value is based on a historical Cosmos Creek concept reported in regional energy planning material. It is a planning assumption and does not establish that a 144 kW hydropower project is technically, environmentally, financially, or legally developable.

The BAU scenario disables new wind and hydropower capacity. The other scenarios allow those technologies subject to the limits above.

## 6. Renewable resource representation

Resource availability is represented using technology specific capacity factors for every season and hour.

| Technology | Source used for the model profile | Range in the SQL inputs |
|---|---|---:|
| Solar photovoltaic | NREL PVWatts profile for Shungnak | 0.0000 to 0.5072 |
| Distributed wind | NREL WTK LED profile at 40 m | 0.0343 to 0.3314 |
| Hydropower | Normalized seasonal Dahl Creek streamflow proxy | 0.0770 to 0.8260 |
| Diesel generators | Dispatchable availability assumption | 1.0000 |
| Battery storage | Power availability convention | 1.0000 |

The model uses all 96 season and hour values for each represented technology rather than one annual average capacity factor.

Solar availability is strongly seasonal and is limited during winter. Wind is represented using a more persistent modeled resource profile. Hydropower uses a normalized streamflow proxy rather than site specific hydrological and engineering data for a confirmed Shungnak project.

## 7. Technology costs

Renewable generation and storage costs are based primarily on the 2024 NREL Annual Technology Baseline using the closest available technology class. Assumed uplift factors were applied to represent higher procurement, transportation, construction, enclosure, and support costs in remote Arctic conditions.

The principal final model inputs for 2030 through 2045 are summarized below. Exact period and vintage values remain available in the SQL files.

| Technology | Investment cost range | Fixed operating cost range |
|---|---:|---:|
| Diesel generators | 4,100 USD/kW | 82 USD/kW per year |
| Solar photovoltaic | 2,864 to 1,658 USD/kW | 39.6 to 29.7 USD/kW per year |
| Distributed wind | 5,913 to 3,381 USD/kW | 68.4 to 65.2 USD/kW per year |
| Run of river hydropower | 12,210 to 11,396 USD/kW | 75 USD/kW per year |
| Battery storage | 2,322 to 1,596 USD/kW | 39 to 30 USD/kW per year |

The diesel investment assumption is based on an inflation adjusted Alaska Energy Authority rural installation benchmark. Diesel fixed operating costs are informed by an Alaska energy system study. Diesel fuel is represented separately as a variable resource cost and is not included in the fixed operating cost shown above.

The Arctic uplift factors and future cost trajectories are scenario inputs rather than observed project quotations. Cost results should therefore be interpreted as conditional on these assumptions.

## 8. Diesel fuel and emissions

The baseline delivered diesel price is approximately 8.50 USD per gallon. The High Diesel Price scenario increases this value by 50% to approximately 12.75 USD per gallon.

The corresponding diesel import cost schedule entered in the model is:

| Period | Base scenarios | High Diesel Price scenario |
|---:|---:|---:|
| 2030 | 0.6300 USD/kWh of fuel | 0.9450 USD/kWh of fuel |
| 2035 | 0.6426 USD/kWh of fuel | 0.9639 USD/kWh of fuel |
| 2040 | 0.6554 USD/kWh of fuel | 0.9831 USD/kWh of fuel |
| 2045 | 0.6685 USD/kWh of fuel | 1.0028 USD/kWh of fuel |

Diesel generation uses a fleet average electrical efficiency of 0.34.

Operational carbon dioxide emissions are represented using:

`0.0007421 tCO2 per kWh of diesel electricity generation`

This is equivalent to approximately 0.742 kg CO2 per kWh. The factor is based on the diesel combustion factor in EPA 40 CFR Part 98, Table C 1, together with the assumed electrical efficiency.

Solar, wind, hydropower, and battery operation are assigned zero direct operational carbon dioxide emissions. The model does not include lifecycle emissions from manufacturing, transportation, construction, replacement, decommissioning, or disposal.

Carbon prices vary by scenario. Their exact values are documented in `docs/scenario_definitions.md`.

## 9. Battery storage representation

The existing physical battery system is reported as:

- 250 kW power capacity
- 384 kWh energy capacity

The Temoa SQL inputs represent `EBATT_01` using:

| Parameter | Temoa value |
|---|---:|
| Existing power capacity | 250 kW |
| Storage duration | 4 hours |
| Efficiency | 0.85 |
| Technology lifetime | 15 years |
| Maximum new capacity | 250 kW per period |

The 4 hour model duration does not equal the physical ratio of 384 kWh divided by 250 kW. It should therefore be interpreted as the storage duration convention used in the Temoa planning representation and for candidate additions, rather than as an exact reconstruction of the existing equipment energy rating.

For reproduction of this repository, the authoritative Temoa efficiency value is 0.85. The 0.95 round trip efficiency reported in the published article does not match the current Temoa SQL inputs and should not be substituted into this repository without creating a different model case.

The Temoa representation does not include battery degradation, temperature dependent performance, detailed charge and discharge power curves, or chronological state of charge continuity across the full year. The separate operational model used in the associated study addresses additional chronological storage behavior but is not included here.

## 10. Technology and commodity codes

The following codes are useful when inspecting the SQLite databases and exported CSV results.

| Code | Meaning |
|---|---|
| `GDSL_01` | 505 kW diesel generator |
| `GDSL_02` | 363 kW diesel generator |
| `GDSL_03` | 505 kW diesel generator |
| `GSOL_01` | Solar photovoltaic generation |
| `GWND_01` | Distributed wind generation |
| `GHYD_01` | Run of river hydropower |
| `EBATT_01` | Battery storage |
| `IMP_DSL` | Imported diesel resource |
| `IMP_SOL` | Solar resource supply |
| `IMP_WND` | Wind resource supply |
| `IMP_HYD` | Hydropower resource supply |
| `ELECT` | Electricity routing and accounting technology |
| `ELC` | Electricity commodity |
| `ELECD` | Delivered electricity demand |
| `co2` | Operational carbon dioxide emissions |
| `ethos` | Dummy source commodity used by the model structure |

`ELECT` and `ethos` are accounting elements rather than physical generating assets. Their capacity or flow values should not be interpreted as installed community infrastructure.

## 11. Scenario structure

The repository contains six scenarios:

- `BAU`
- `BAU_UR`
- `CP_MID`
- `HDP`
- `NZ`
- `NZ_SUBSIDY`

The scenarios share the same region, demand trajectory, existing assets, resource profiles, technology definitions, and most cost assumptions. They differ in technology access, diesel price, carbon price, diesel minimum capacity conditions, and renewable and storage investment support.

The exact input differences and the mapping between repository scenario names and internal Temoa labels are documented in:

`docs/scenario_definitions.md`

## 12. Data provenance and access

A structured inventory of parameter sources is provided in:

`provenance/data_sources.csv`

Principal source categories include:

- AVEC and ANTHC information for electricity demand
- Northwest Arctic Borough material for existing community assets
- NREL PVWatts for solar availability
- NREL WTK LED for wind availability
- USGS Dahl Creek records for the hydropower proxy
- NREL ATB 2024 for renewable and storage technology costs
- Alaska Energy Authority material for diesel cost assumptions
- EPA 40 CFR Part 98 for diesel carbon dioxide emissions
- Regional energy plans for technology deployment assumptions

Some underlying third party data remain subject to their original providers' access and reuse conditions. In particular, the raw AVEC hourly demand records are confidential and are not redistributed.

Users should consult the cited providers before redistributing third party data or using the input assumptions for a different community.

## 13. Modeling limitations

The model should be interpreted as a comparative long term planning analysis rather than a forecast of one expected future.

Important limitations include:

- The analysis represents one community and one modeled region.
- The model assumes perfect foresight within each scenario.
- Seasonal representative days do not preserve full year chronology.
- Renewable profiles are modeled estimates or proxies rather than complete site measurements.
- The hydropower option does not represent a confirmed engineered project.
- Arctic cost uplift factors and future cost reductions are uncertain assumptions.
- The 50% planning reserve margin is an input assumption rather than a detailed reliability assessment.
- The model does not represent distribution network power flows.
- It does not model frequency, voltage, inertia, protection coordination, contingency response, or grid forming inverter behavior.
- Battery operation is simplified in the capacity expansion formulation.
- Emissions include operational diesel carbon dioxide only and exclude lifecycle impacts.
- Exact technology dispatch can be nonunique when multiple solutions have the same or nearly the same objective value.

The numerical results are specific to the Shungnak demand profile, resource assumptions, existing infrastructure, technology costs, deployment limits, fuel prices, and policy scenarios encoded in the repository. Application to another isolated community requires calibration using local demand, renewable resource, infrastructure, cost, and operating information.

## 14. Related documentation

- `docs/scenario_definitions.md` describes the exact differences among the six scenarios.
- `docs/reproducibility.md` explains how to build the databases, run Temoa, verify results, and export outputs.
- `provenance/data_sources.csv` provides the parameter level source inventory.
