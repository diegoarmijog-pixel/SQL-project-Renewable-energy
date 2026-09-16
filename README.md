# Renewable Energy Share SQL Project

This repository contains a set of SQL scripts designed to analyze renewable energy adoption, electricity generation, and the pace of energy transition across countries. The queries organize and transform a larger source table named `renewable_energy_share` into cleaner tables and analytical views for comparison and reporting.

## Project purpose

The main goal of this project is to support energy transition analysis by answering questions such as:

- Which countries have higher or lower renewable energy participation?
- Is rising electricity demand driven more by population growth or by higher per-capita energy intensity?
- How much electricity is generated from renewables, fossil fuels, and low-carbon sources?
- How quickly are countries reducing fossil dependence and increasing renewable shares?

The SQL scripts in this repository prepare structured datasets and extract key indicators for these analyses.

---

## Source dataset assumption

These scripts assume the existence of a base table called `renewable_energy_share`, which contains country-level energy and electricity data across years. The queries then create smaller, purpose-specific tables from this source so the analysis is easier to manage and faster to query.

---

## Files in this repository

### 1) country_general_info.sql

Purpose:
This script creates a dedicated table named `country_general_info` for general country-level explanatory variables.

What it does:
- Selects country-level records from `renewable_energy_share`
- Keeps fields such as:
  - country
  - year
  - population
  - gdp
  - primary_energy_consumption
  - electricity_demand
  - renewables_share_energy
  - fossil_share_energy
  - low_carbon_share_energy
  - energy_per_capita
  - renewables_energy_per_capita
  - fossil_energy_per_capita
- Saves the result into a new table for cleaner separation from raw source data

Why this matters:
This makes demographic and macroeconomic analysis easier and prevents the main dataset from being overloaded with information not directly needed for every query.

---

### 2) Demographic_energy_intensity.sql

Purpose:
This script analyzes whether changes in energy demand are more closely related to population growth or to rising per-capita energy intensity.

What it does:
- Uses a CTE called `growthcalc`
- Calculates year-over-year growth in:
  - population
  - energy_per_capita
- Uses window functions with `LAG()` to compare each year to the previous year within each country
- Computes:
  - population_growth_percentage
  - energy_pc_growth_percentage
- Filters data between 2001 and 2024
- Sorts results by energy per-capita growth in descending order

Why this matters:
This helps identify whether energy pressure is coming from more people, from higher individual consumption, or from both. It is useful for understanding the drivers behind electricity demand and carbon intensity.

---

### 3) electricity generation.sql

Purpose:
This script builds a table focused on electricity generation volumes by source and country.

What it does:
- Creates a new table called `electricity_generation`
- Extracts electricity generation data for each country and year, including:
  - electricity_generation
  - solar_electricity
  - wind_electricity
  - hydro_electricity
  - nuclear_electricity
  - coal_electricity
  - gas_electricity
  - oil_electricity
  - biofuel_electricity
  - other_renewable_electricity

Why this matters:
This dataset is useful for analyzing the absolute scale of generation by technology and for comparing how different energy sources contribute to the grid over time.

---

### 4) electricity share.sql

Purpose:
This script creates a table focused on the proportional share of each electricity source in the energy mix.

What it does:
- Creates a table called `electricity_share`
- Selects percentage-based indicators such as:
  - renewables_share_elec
  - fossil_share_elec
  - low_carbon_share_elec
  - solar_share_elec
  - wind_share_elec
  - hydro_share_elec
  - nuclear_share_elec
  - coal_share_elec
  - gas_share_elec

Why this matters:
This is one of the most important tables for transition analysis because it shows how much of each country’s electricity comes from renewables, fossil fuels, and other low-carbon sources. It is used to compare energy mixes and track decarbonization progress.

---

### 5) Energy_transition_velocity.sql

Purpose:
This script evaluates how quickly countries are transitioning away from fossil-based electricity generation and toward renewable energy.

What it does:
This file contains three main analyses:

1. Fossil Peak and Drop-Off
   - Finds each country’s maximum historical fossil share in electricity generation
   - Compares this peak to the most recent year value
   - Calculates `percentage_point_drop`
   - Selects the latest year (2025) and orders countries by largest reduction
   - Shows the top 10 countries with the strongest fossil share decline

2. Decarbonization Momentum (Rolling Averages)
   - Calculates a 20-year rolling average of renewable share per country
   - Uses `AVG(renewables_share_elec) OVER (...)`
   - Helps identify underlying long-term trend while smoothing short-term volatility

3. Top Growing Countries in Decarbonization
   - Compares renewable share in 2005 vs 2025
   - Measures `momentum_gained` as the increase in renewable electricity share
   - Sorts countries by largest gains and shows the top 10

Why this matters:
This script is designed for transition-speed analysis. It helps answer questions like:
- Which countries are reducing fossil dependence the fastest?
- Are renewable shares rising steadily over time?
- Which countries show the strongest momentum in decarbonization?

---

## Typical analysis flow

A common workflow for this project would be:

1. Start with the original `renewable_energy_share` dataset
2. Use `country_general_info.sql` to prepare country-level context
3. Use `electricity generation.sql` and `electricity share.sql` to separate generation and mix data
4. Use `Demographic_energy_intensity.sql` to understand demand drivers
5. Use `Energy_transition_velocity.sql` to evaluate the pace of transition

---

## Summary

This repository is focused on renewable energy transition analysis using SQL. It organizes country energy data into clean, purpose-specific tables and supports both descriptive and comparative analysis across demographic, generation, and decarbonization dimensions.

The scripts are especially useful for:
- country benchmarking
- transition trend analysis
- fossil-to-renewable comparison
- identifying energy demand drivers
- evaluating renewable energy adoption over time
