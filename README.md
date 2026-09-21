# Renewable Energy Share SQL Project

This repository contains a set of SQL scripts designed to analyze renewable energy adoption, electricity generation, and the pace of the energy transition across countries. The queries transform a larger source table named `renewable_energy_share` into cleaner, purpose-specific datasets for comparison, reporting, and exploratory analysis.

## Project objective

The main goal of this project is to support energy transition analysis by answering questions such as:

- Which countries have higher or lower renewable energy participation?
- Is rising electricity demand driven more by population growth or by higher per-capita energy intensity?
- How much electricity is generated from renewables, fossil fuels, and low-carbon sources?
- How quickly are countries reducing fossil dependence and increasing renewable shares?
- Which countries are net energy importers or exporters?

The scripts in this repository prepare structured datasets and extract key indicators for these analyses.

---

## Source dataset assumption

The project uses a database extracted from Kaggle (https://www.kaggle.com/datasets/elvisbui/renewable-energy-share-by-country-2000-2025), which contains 26 years of country-level electricity mix data covering renewable and non-renewable sources. The SQL scripts then create smaller, purpose-specific tables to make the analysis easier to manage and faster to query.

---

## Repository structure

### 1) country_general_info.sql

This script creates a dedicated table named `country_general_info` for general country-level explanatory variables.

It selects country-level records from `renewable_energy_share` and keeps fields such as:

- `country`
- `year`
- `population`
- `gdp`
- `primary_energy_consumption`
- `electricity_demand`
- `renewables_share_energy`
- `fossil_share_energy`
- `low_carbon_share_energy`
- `energy_per_capita`
- `renewables_energy_per_capita`
- `fossil_energy_per_capita`

This separates macroeconomic and demographic context from the raw source table and makes later analysis cleaner and more efficient.

### 2) Demographic_energy_intensity.sql

This script examines whether changes in energy demand are driven more by population growth or by increasing per-capita energy intensity.

It uses a CTE named `growthcalc` and calculates annual growth in:

- `population`
- `energy_per_capita`

Using `LAG()`, the query compares each year with the previous year within each country and computes:

- `population_growth_percentage`
- `energy_pc_growth_percentage`

The results are filtered for the period 2001-2024 and sorted by the highest energy-per-capita growth rate.

This helps identify whether energy pressure is coming from more people, higher individual consumption, or both.

### 3) electricity generation.sql

This script creates a table named `electricity_generation` focused on electricity generation by source and country.

It includes the following variables:

- `country`
- `year`
- `electricity_generation`
- `solar_electricity`
- `wind_electricity`
- `hydro_electricity`
- `nuclear_electricity`
- `coal_electricity`
- `gas_electricity`
- `oil_electricity`
- `biofuel_electricity`
- `other_renewable_electricity`

This table is useful for analyzing the absolute scale of generation by technology and for comparing how different energy sources contribute to the grid over time.

### 4) electricity share.sql

This script creates a table named `electricity_share` focused on the proportion of each electricity source in the energy mix.

It selects percentage-based indicators such as:

- `renewables_share_elec`
- `fossil_share_elec`
- `low_carbon_share_elec`
- `solar_share_elec`
- `wind_share_elec`
- `hydro_share_elec`
- `nuclear_share_elec`
- `coal_share_elec`
- `gas_share_elec`

This table is central to transition analysis because it shows how much of each country’s electricity comes from renewables, fossil fuels, and other low-carbon sources.

### 5) Energy_transition_velocity.sql

This script evaluates how quickly countries are transitioning away from fossil-based electricity generation and toward renewable energy.

It contains three analytical sections:

1. Fossil peak and drop-off
   - Identifies each country’s maximum historical fossil share in electricity generation
   - Compares that peak with the most recent year value
   - Calculates `percentage_point_drop`
   - Shows the top 10 countries with the largest decline

2. Decarbonization momentum (rolling averages)
   - Calculates a 20-year rolling average of renewable share by country
   - Uses window functions to smooth short-term volatility
   - Helps reveal the underlying long-term trend

3. Top growing countries in decarbonization
   - Compares renewable electricity share in 2005 vs 2025
   - Measures `momentum_gained` as the change in renewable share
   - Sorts countries by the largest gains and displays the top 10

This script answers questions such as:

- Which countries are reducing fossil dependence the fastest?
- Are renewable shares increasing steadily over time?
- Which countries show the strongest momentum in decarbonization?

### 6) deficit_and_stability.sql

This script combines two complementary analyses: energy deficit classification and grid stability assessment.

It calculates:

- `net_electricity = electricity_generation - electricity_demand`
- a classification as `Energy Importers / Deficit` or `Energy Exporters`
- the total number of countries in each category
- the top 5 net importers and top 5 net exporters
- the share of electricity generated from weather-dependent sources such as solar and wind
- a grid classification of `Unstable Grid`, `Perfectly Balanced`, or `Stable + requires transition`
- the countries with the highest instability and the most balanced grids in the latest year available, typically 2024

This allows the project to assess both energy security and the resilience of each country’s electricity system.

---

## Typical analysis workflow

A common workflow for this project is:

1. Start from the raw `renewable_energy_share` dataset.
2. Use `country_general_info.sql` to prepare country-level context.
3. Use `electricity generation.sql` and `electricity share.sql` to separate generation and mix indicators.
4. Use `Demographic_energy_intensity.sql` to understand the drivers of electricity demand.
5. Use `Energy_transition_velocity.sql` to assess the pace of the energy transition.
6. Use `deficit_and_stability.sql` to evaluate energy balance, external dependence, and grid stability.

---

## Examples of results from the analysis

### 1) Energy transition velocity

The analysis of `Energy_transition_velocity.sql` shows the countries with the strongest gains in renewable electricity share between 2005 and 2025:

| country | start_share [%] | end_share [%] | momentum_gained [%] |
| :--- | :--- | :--- | :--- |
| Luxembourg | 6.269 | 91.558 | 85.289 |
| Lithuania | 3.190 | 77.615 | 74.425 |
| Denmark | 27.162 | 91.171 | 64.009 |
| Portugal | 17.931 | 80.951 | 63.020 |
| Estonia | 1.078 | 59.574 | 58.496 |
| Germany | 10.342 | 59.092 | 48.750 |
| United Kingdom | 4.250 | 51.972 | 47.722 |
| Netherlands | 7.571 | 51.200 | 43.629 |
| Spain | 14.603 | 55.858 | 41.255 |
| Ireland | 7.383 | 48.142 | 40.759 |

This highlights how quickly some countries have moved toward renewable electricity generation.

### 2) Energy demand vs. population

From `Demographic_energy_intensity.sql`, the top countries by growth in energy per capita between 2001 and 2024 show that changes in energy intensity are often more significant than population growth alone.

| country | year | population | energy_per_capita [TWh] | population_growth_percentage [%] | energy_pc_growth_percentage [%] |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Equatorial Guinea | 2002 | 797,968 | 35,377.777 | 6.419 | 1354.857 |
| United States Virgin Islands | 2014 | 102,012 | 119,096.664 | -1.121 | 106.550 |
| Afghanistan | 2008 | 26,482,631 | 567.922 | 2.211 | 89.665 |
| Turks and Caicos Islands | 2018 | 41,580 | 44,844.117 | 4.130 | 87.476 |
| Laos | 2015 | 6,801,647 | 5,482.171 | 1.469 | 85.277 |
| North Korea | 2017 | 25,817,710 | 8,832.858 | 0.465 | 83.140 |
| Togo | 2009 | 6,130,944 | 1,947.019 | 3.282 | 72.604 |
| Cook Islands | 2004 | 15,103 | 14,648.089 | 0.359 | 69.117 |
| Chad | 2012 | 13,211,006 | 292.125 | 3.575 | 67.186 |

These results suggest that rising energy demand is often driven by greater per-capita consumption rather than by population growth alone.

### 3) Deficit and stability

From `deficit_and_stability.sql`, the countries with the largest net electricity deficits are:

| country | net_electricity [TWh] |
| :--- | :--- |
| Italy | 1154.530 |
| United States | 906.940 |
| Brazil | 849.620 |
| Thailand | 367.820 |
| United Kingdom | 351.400 |

Countries with the largest net electricity surpluses are:

| country | net_electricity [TWh] |
| :--- | :--- |
| France | 1420.000 |
| Paraguay | 1013.000 |
| Canada | 925.220 |
| Germany | 407.230 |
| Russia | 381.429 |

This highlights the contrast between countries that rely on imports to meet demand and those that export excess electricity generation.

When it comes to stability, it is defined as the percentage of electricity generated from weather-dependent sources such as solar and wind. The classification criteria used in the analysis are as follows: if the stability share is above 60%, the grid is classified as `Unstable Grid`; if it is below 40%, it is classified as `Stable + requires transition`; and if it falls between the two thresholds, it is considered `Perfectly Balanced`.

The countries with the most unstable grids are shown below.

| country | unstable_grid_share [%] |
| :--- | :--- |
| Denmark | 68.99 |
| Lithuania | 65.088 |

It is important to note that having an unstable grid does not necessarily imply power outages; this depends on the backup systems and other electricity sources available in each country.

The countries with a perfectly balanced grid are shown below.

| country | unstable_grid_share [%] |
| :--- | :--- |
| Cook Islands | 50 |
| Germany | 43.495 |
| Greece | 41.713 |
| Ireland | 40.830 |
| Luxembourg | 54.304 |
| Netherlands | 45.206 |
| Portugal | 45.335 |
| Spain | 42.888 |
| Uruguay | 42.782 |

The majority of the balanced grid countries are in European regions where weather conditions are highly variable, creating the need for a diverse energy mix to meet electricity demand and maintain a stable system.

---

## Summary

This repository is focused on renewable energy transition analysis using SQL. It organizes country energy data into clean, purpose-specific tables and supports both descriptive and comparative analysis across demographic, generation, decarbonization, and energy-balance dimensions.

The scripts are especially useful for:

- country benchmarking
- transition trend analysis
- fossil-to-renewable comparison
- identifying energy demand drivers
- evaluating renewable energy adoption over time
- assessing electricity security and exporter/importer dynamics

