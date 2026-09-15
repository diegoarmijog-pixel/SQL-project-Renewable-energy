/* this query separates general information about countries (population, GDP, per capita indicators, etc) from the main country table and stores it in a separate table for better organization and performance. */

CREATE TABLE country_general_info AS
SELECT country,
    year,
    population,
    gdp,
    primary_energy_consumption,
    electricity_demand,
    renewables_share_energy,
    fossil_share_energy,
    low_carbon_share_energy,
    energy_per_capita,
    renewables_energy_per_capita,
    fossil_energy_per_capita
FROM 
    renewable_energy_share


SELECT*
FROM country_general_info