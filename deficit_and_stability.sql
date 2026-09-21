/*
##DEFICIT CALCULATIONS# 
The first part of this file creates a table that contains the countries and classifies them by energy exporters or energy importers/deficit and then calculates the total countries and the total of importers and exporters of energy*/



WITH deficit_clasify AS 
(
    SELECT
    country,
    SUM(electricity_generation - electricity_demand) AS net_electricity,
    CASE
        WHEN  SUM(electricity_generation - electricity_demand) < 0 THEN  'Energy Importers / Deficit'
        WHEN  SUM(electricity_generation - electricity_demand) > 0 THEN  'Energy Exporters'
        ELSE 'N/A'
    END AS deficit_case
    FROM renewable_energy_share
    WHERE electricity_generation IS NOT NULL AND electricity_demand IS NOT NULL AND (electricity_generation - electricity_demand) IS NOT NULL AND country NOT IN ('ASEAN (Ember)', 'Africa', 'Africa (EI)', 'Africa (EIA)', 'Africa (Ember)', 'Africa (Shift)', 'Asia', 'Asia (Ember)', 'Asia Pacific (EI)', 'Asia and Oceania (EIA)', 'Asia and Oceania (Shift)', 'Australia and New Zealand (EIA)', 'CIS (EI)', 'Central America (EI)', 'Central and South America (EIA)', 'Central and South America (Shift)', 'EU (Ember)', 'EU28 (Shift)', 'Eastern Africa (EI)', 'Eastern Europe and Eurasia (EIA)', 'Eurasia (EIA)', 'Eurasia (Shift)', 'Europe', 'Europe (EI)', 'Europe (EIA)', 'Europe (Ember)', 'Europe (Shift)', 'European Union (27)', 'G20 (Ember)', 'G7 (Ember)', 'High-income countries', 'Latin America and Caribbean (Ember)', 'Low-income countries', 'Lower-middle-income countries', 'Middle Africa (EI)', 'Middle East (EI)', 'Middle East (EIA)', 'Middle East (Ember)', 'Middle East (Shift)', 'Non-OECD (EI)', 'Non-OECD (EIA)', 'Non-OPEC (EI)', 'Non-OPEC (EIA)', 'North America', 'North America (EI)', 'North America (Ember)', 'North America (Shift)', 'OECD (EI)', 'OECD (EIA)', 'OECD (Ember)', 'OECD (Shift)', 'OPEC (EI)', 'OPEC (EIA)', 'OPEC (Shift)', 'Oceania', 'Oceania (Ember)', 'Other Africa (EI)', 'Other Americas (EIA)', 'Other Asia Pacific (EI)', 'Other Asia-Pacific (EIA)', 'Other CIS (EI)', 'Other Caribbean (EI)', 'Other Eastern Africa (EI)', 'Other Europe (EI)', 'Other Middle Africa (EI)', 'Other Middle East (EI)', 'Other North America (EI)', 'Other Northern Africa (EI)', 'Other South America (EI)', 'Other South and Central America (EI)', 'Other Southern Africa (EI)', 'Other Western Africa (EI)', 'Persian Gulf (EIA)', 'Persian Gulf (Shift)', 'Rest of World (EI)', 'South America', 'South and Central America (EI)', 'U.S. Pacific Islands (EIA)', 'U.S. Territories (EIA)', 'United States Pacific Islands (Shift)', 'United States Territories (Shift)', 'Upper-middle-income countries', 'Wake Island (EIA)', 'Wake Island (Shift)', 'Western Africa (EI)', 'Western Europe (EIA)', 'World')
    GROUP BY country

)

SELECT
COUNT(*) AS total_countries,
COUNT(CASE WHEN deficit_case = 'Energy Importers / Deficit' THEN 1 END) AS importers,
COUNT(CASE WHEN deficit_case = 'Energy Exporters' THEN 1 END) AS exporters
FROM deficit_clasify;

/* TOP 5 IMPORTERS OF ENERGY */

WITH deficit_clasify AS 
(
    SELECT
    country,
    SUM(electricity_generation - electricity_demand) AS net_electricity,
    CASE
        WHEN  SUM(electricity_generation - electricity_demand) < 0 THEN  'Energy Importers / Deficit'
        WHEN  SUM(electricity_generation - electricity_demand) > 0 THEN  'Energy Exporters'
        ELSE 'N/A'
    END AS deficit_case
    FROM renewable_energy_share
    WHERE electricity_generation IS NOT NULL AND electricity_demand IS NOT NULL AND (electricity_generation - electricity_demand) IS NOT NULL AND country NOT IN ('ASEAN (Ember)', 'Africa', 'Africa (EI)', 'Africa (EIA)', 'Africa (Ember)', 'Africa (Shift)', 'Asia', 'Asia (Ember)', 'Asia Pacific (EI)', 'Asia and Oceania (EIA)', 'Asia and Oceania (Shift)', 'Australia and New Zealand (EIA)', 'CIS (EI)', 'Central America (EI)', 'Central and South America (EIA)', 'Central and South America (Shift)', 'EU (Ember)', 'EU28 (Shift)', 'Eastern Africa (EI)', 'Eastern Europe and Eurasia (EIA)', 'Eurasia (EIA)', 'Eurasia (Shift)', 'Europe', 'Europe (EI)', 'Europe (EIA)', 'Europe (Ember)', 'Europe (Shift)', 'European Union (27)', 'G20 (Ember)', 'G7 (Ember)', 'High-income countries', 'Latin America and Caribbean (Ember)', 'Low-income countries', 'Lower-middle-income countries', 'Middle Africa (EI)', 'Middle East (EI)', 'Middle East (EIA)', 'Middle East (Ember)', 'Middle East (Shift)', 'Non-OECD (EI)', 'Non-OECD (EIA)', 'Non-OPEC (EI)', 'Non-OPEC (EIA)', 'North America', 'North America (EI)', 'North America (Ember)', 'North America (Shift)', 'OECD (EI)', 'OECD (EIA)', 'OECD (Ember)', 'OECD (Shift)', 'OPEC (EI)', 'OPEC (EIA)', 'OPEC (Shift)', 'Oceania', 'Oceania (Ember)', 'Other Africa (EI)', 'Other Americas (EIA)', 'Other Asia Pacific (EI)', 'Other Asia-Pacific (EIA)', 'Other CIS (EI)', 'Other Caribbean (EI)', 'Other Eastern Africa (EI)', 'Other Europe (EI)', 'Other Middle Africa (EI)', 'Other Middle East (EI)', 'Other North America (EI)', 'Other Northern Africa (EI)', 'Other South America (EI)', 'Other South and Central America (EI)', 'Other Southern Africa (EI)', 'Other Western Africa (EI)', 'Persian Gulf (EIA)', 'Persian Gulf (Shift)', 'Rest of World (EI)', 'South America', 'South and Central America (EI)', 'U.S. Pacific Islands (EIA)', 'U.S. Territories (EIA)', 'United States Pacific Islands (Shift)', 'United States Territories (Shift)', 'Upper-middle-income countries', 'Wake Island (EIA)', 'Wake Island (Shift)', 'Western Africa (EI)', 'Western Europe (EIA)', 'World')
    GROUP BY country

)

SELECT
    country,
    net_electricity * (-1) AS net_electricity_absolute
FROM
    deficit_clasify
WHERE deficit_case = 'Energy Importers / Deficit' 
ORDER BY net_electricity * (-1) DESC
LIMIT 5;

/* TOP 5 EXPORTERS OF ENERGY */


WITH deficit_clasify AS 
(
    SELECT
    country,
    SUM(electricity_generation - electricity_demand) AS net_electricity,
    CASE
        WHEN  SUM(electricity_generation - electricity_demand) < 0 THEN  'Energy Importers / Deficit'
        WHEN  SUM(electricity_generation - electricity_demand) > 0 THEN  'Energy Exporters'
        ELSE 'N/A'
    END AS deficit_case
    FROM renewable_energy_share
    WHERE electricity_generation IS NOT NULL AND electricity_demand IS NOT NULL AND (electricity_generation - electricity_demand) IS NOT NULL AND country NOT IN ('ASEAN (Ember)', 'Africa', 'Africa (EI)', 'Africa (EIA)', 'Africa (Ember)', 'Africa (Shift)', 'Asia', 'Asia (Ember)', 'Asia Pacific (EI)', 'Asia and Oceania (EIA)', 'Asia and Oceania (Shift)', 'Australia and New Zealand (EIA)', 'CIS (EI)', 'Central America (EI)', 'Central and South America (EIA)', 'Central and South America (Shift)', 'EU (Ember)', 'EU28 (Shift)', 'Eastern Africa (EI)', 'Eastern Europe and Eurasia (EIA)', 'Eurasia (EIA)', 'Eurasia (Shift)', 'Europe', 'Europe (EI)', 'Europe (EIA)', 'Europe (Ember)', 'Europe (Shift)', 'European Union (27)', 'G20 (Ember)', 'G7 (Ember)', 'High-income countries', 'Latin America and Caribbean (Ember)', 'Low-income countries', 'Lower-middle-income countries', 'Middle Africa (EI)', 'Middle East (EI)', 'Middle East (EIA)', 'Middle East (Ember)', 'Middle East (Shift)', 'Non-OECD (EI)', 'Non-OECD (EIA)', 'Non-OPEC (EI)', 'Non-OPEC (EIA)', 'North America', 'North America (EI)', 'North America (Ember)', 'North America (Shift)', 'OECD (EI)', 'OECD (EIA)', 'OECD (Ember)', 'OECD (Shift)', 'OPEC (EI)', 'OPEC (EIA)', 'OPEC (Shift)', 'Oceania', 'Oceania (Ember)', 'Other Africa (EI)', 'Other Americas (EIA)', 'Other Asia Pacific (EI)', 'Other Asia-Pacific (EIA)', 'Other CIS (EI)', 'Other Caribbean (EI)', 'Other Eastern Africa (EI)', 'Other Europe (EI)', 'Other Middle Africa (EI)', 'Other Middle East (EI)', 'Other North America (EI)', 'Other Northern Africa (EI)', 'Other South America (EI)', 'Other South and Central America (EI)', 'Other Southern Africa (EI)', 'Other Western Africa (EI)', 'Persian Gulf (EIA)', 'Persian Gulf (Shift)', 'Rest of World (EI)', 'South America', 'South and Central America (EI)', 'U.S. Pacific Islands (EIA)', 'U.S. Territories (EIA)', 'United States Pacific Islands (Shift)', 'United States Territories (Shift)', 'Upper-middle-income countries', 'Wake Island (EIA)', 'Wake Island (Shift)', 'Western Africa (EI)', 'Western Europe (EIA)', 'World')
    GROUP BY country

)

SELECT
    country,
    net_electricity
FROM
    deficit_clasify
WHERE deficit_case = 'Energy Exporters' 
ORDER BY net_electricity DESC
LIMIT 5;


/*
##STABILITY CALCULATIONS##
The second part of this file calculates the percentages of energy generated by sources that are dependant of weather conditions and climate (Solar and Wind), this allows to calculate the stability of the electricity grid of each country.
For this analysis, the year 2024 is selected in order to obtain the most recent data available that it is representative*/


WITH stability_clasify AS 
(
    SELECT
    year,
    country,
    (solar_electricity + wind_electricity) / NULLIF(electricity_generation, 0) * 100 AS unstable_grid_share,
    CASE
        WHEN  (solar_electricity + wind_electricity) / NULLIF(electricity_generation, 0) * 100 > 60 THEN  'Unstable Grid'
        WHEN  (solar_electricity + wind_electricity) / NULLIF(electricity_generation, 0) * 100 < 40 THEN  'Stable + requires transition'
        ELSE 'Perfectly Balanced'
    END AS stability_case
    FROM electricity_generation
    WHERE electricity_generation IS NOT NULL AND country NOT IN ('ASEAN (Ember)', 'Africa', 'Africa (EI)', 'Africa (EIA)', 'Africa (Ember)', 'Africa (Shift)', 'Asia', 'Asia (Ember)', 'Asia Pacific (EI)', 'Asia and Oceania (EIA)', 'Asia and Oceania (Shift)', 'Australia and New Zealand (EIA)', 'CIS (EI)', 'Central America (EI)', 'Central and South America (EIA)', 'Central and South America (Shift)', 'EU (Ember)', 'EU28 (Shift)', 'Eastern Africa (EI)', 'Eastern Europe and Eurasia (EIA)', 'Eurasia (EIA)', 'Eurasia (Shift)', 'Europe', 'Europe (EI)', 'Europe (EIA)', 'Europe (Ember)', 'Europe (Shift)', 'European Union (27)', 'G20 (Ember)', 'G7 (Ember)', 'High-income countries', 'Latin America and Caribbean (Ember)', 'Low-income countries', 'Lower-middle-income countries', 'Middle Africa (EI)', 'Middle East (EI)', 'Middle East (EIA)', 'Middle East (Ember)', 'Middle East (Shift)', 'Non-OECD (EI)', 'Non-OECD (EIA)', 'Non-OPEC (EI)', 'Non-OPEC (EIA)', 'North America', 'North America (EI)', 'North America (Ember)', 'North America (Shift)', 'OECD (EI)', 'OECD (EIA)', 'OECD (Ember)', 'OECD (Shift)', 'OPEC (EI)', 'OPEC (EIA)', 'OPEC (Shift)', 'Oceania', 'Oceania (Ember)', 'Other Africa (EI)', 'Other Americas (EIA)', 'Other Asia Pacific (EI)', 'Other Asia-Pacific (EIA)', 'Other CIS (EI)', 'Other Caribbean (EI)', 'Other Eastern Africa (EI)', 'Other Europe (EI)', 'Other Middle Africa (EI)', 'Other Middle East (EI)', 'Other North America (EI)', 'Other Northern Africa (EI)', 'Other South America (EI)', 'Other South and Central America (EI)', 'Other Southern Africa (EI)', 'Other Western Africa (EI)', 'Persian Gulf (EIA)', 'Persian Gulf (Shift)', 'Rest of World (EI)', 'South America', 'South and Central America (EI)', 'U.S. Pacific Islands (EIA)', 'U.S. Territories (EIA)', 'United States Pacific Islands (Shift)', 'United States Territories (Shift)', 'Upper-middle-income countries', 'Wake Island (EIA)', 'Wake Island (Shift)', 'Western Africa (EI)', 'Western Europe (EIA)', 'World')
)

SELECT
    country,
    unstable_grid_share,
    stability_case
FROM
    stability_clasify
WHERE year = 2024 AND unstable_grid_share IS NOT NULL

/* COUNTRIES WITH HIGHEST UNSTABILITY */

WITH stability_clasify AS 
(
    SELECT
    year,
    country,
    (solar_electricity + wind_electricity) / NULLIF(electricity_generation, 0) * 100 AS unstable_grid_share,
    CASE
        WHEN  (solar_electricity + wind_electricity) / NULLIF(electricity_generation, 0) * 100 > 60 THEN  'Unstable Grid'
        WHEN  (solar_electricity + wind_electricity) / NULLIF(electricity_generation, 0) * 100 < 40 THEN  'Stable + requires transition'
        ELSE 'Perfectly Balanced'
    END AS stability_case
    FROM electricity_generation
    WHERE electricity_generation IS NOT NULL AND country NOT IN ('ASEAN (Ember)', 'Africa', 'Africa (EI)', 'Africa (EIA)', 'Africa (Ember)', 'Africa (Shift)', 'Asia', 'Asia (Ember)', 'Asia Pacific (EI)', 'Asia and Oceania (EIA)', 'Asia and Oceania (Shift)', 'Australia and New Zealand (EIA)', 'CIS (EI)', 'Central America (EI)', 'Central and South America (EIA)', 'Central and South America (Shift)', 'EU (Ember)', 'EU28 (Shift)', 'Eastern Africa (EI)', 'Eastern Europe and Eurasia (EIA)', 'Eurasia (EIA)', 'Eurasia (Shift)', 'Europe', 'Europe (EI)', 'Europe (EIA)', 'Europe (Ember)', 'Europe (Shift)', 'European Union (27)', 'G20 (Ember)', 'G7 (Ember)', 'High-income countries', 'Latin America and Caribbean (Ember)', 'Low-income countries', 'Lower-middle-income countries', 'Middle Africa (EI)', 'Middle East (EI)', 'Middle East (EIA)', 'Middle East (Ember)', 'Middle East (Shift)', 'Non-OECD (EI)', 'Non-OECD (EIA)', 'Non-OPEC (EI)', 'Non-OPEC (EIA)', 'North America', 'North America (EI)', 'North America (Ember)', 'North America (Shift)', 'OECD (EI)', 'OECD (EIA)', 'OECD (Ember)', 'OECD (Shift)', 'OPEC (EI)', 'OPEC (EIA)', 'OPEC (Shift)', 'Oceania', 'Oceania (Ember)', 'Other Africa (EI)', 'Other Americas (EIA)', 'Other Asia Pacific (EI)', 'Other Asia-Pacific (EIA)', 'Other CIS (EI)', 'Other Caribbean (EI)', 'Other Eastern Africa (EI)', 'Other Europe (EI)', 'Other Middle Africa (EI)', 'Other Middle East (EI)', 'Other North America (EI)', 'Other Northern Africa (EI)', 'Other South America (EI)', 'Other South and Central America (EI)', 'Other Southern Africa (EI)', 'Other Western Africa (EI)', 'Persian Gulf (EIA)', 'Persian Gulf (Shift)', 'Rest of World (EI)', 'South America', 'South and Central America (EI)', 'U.S. Pacific Islands (EIA)', 'U.S. Territories (EIA)', 'United States Pacific Islands (Shift)', 'United States Territories (Shift)', 'Upper-middle-income countries', 'Wake Island (EIA)', 'Wake Island (Shift)', 'Western Africa (EI)', 'Western Europe (EIA)', 'World')
)

SELECT
    country,
    unstable_grid_share,
    stability_case
FROM
    stability_clasify
WHERE year = 2024 AND unstable_grid_share IS NOT NULL AND stability_case = 'Unstable Grid'
ORDER BY unstable_grid_share DESC;


/* COUNTRIES THAT ARE PERFECTLY BALANCED */

WITH stability_clasify AS 
(
    SELECT
    year,
    country,
    (solar_electricity + wind_electricity) / NULLIF(electricity_generation, 0) * 100 AS unstable_grid_share,
    CASE
        WHEN  (solar_electricity + wind_electricity) / NULLIF(electricity_generation, 0) * 100 > 60 THEN  'Unstable Grid'
        WHEN  (solar_electricity + wind_electricity) / NULLIF(electricity_generation, 0) * 100 < 40 THEN  'Stable + requires transition'
        ELSE 'Perfectly Balanced'
    END AS stability_case
    FROM electricity_generation
    WHERE electricity_generation IS NOT NULL AND country NOT IN ('ASEAN (Ember)', 'Africa', 'Africa (EI)', 'Africa (EIA)', 'Africa (Ember)', 'Africa (Shift)', 'Asia', 'Asia (Ember)', 'Asia Pacific (EI)', 'Asia and Oceania (EIA)', 'Asia and Oceania (Shift)', 'Australia and New Zealand (EIA)', 'CIS (EI)', 'Central America (EI)', 'Central and South America (EIA)', 'Central and South America (Shift)', 'EU (Ember)', 'EU28 (Shift)', 'Eastern Africa (EI)', 'Eastern Europe and Eurasia (EIA)', 'Eurasia (EIA)', 'Eurasia (Shift)', 'Europe', 'Europe (EI)', 'Europe (EIA)', 'Europe (Ember)', 'Europe (Shift)', 'European Union (27)', 'G20 (Ember)', 'G7 (Ember)', 'High-income countries', 'Latin America and Caribbean (Ember)', 'Low-income countries', 'Lower-middle-income countries', 'Middle Africa (EI)', 'Middle East (EI)', 'Middle East (EIA)', 'Middle East (Ember)', 'Middle East (Shift)', 'Non-OECD (EI)', 'Non-OECD (EIA)', 'Non-OPEC (EI)', 'Non-OPEC (EIA)', 'North America', 'North America (EI)', 'North America (Ember)', 'North America (Shift)', 'OECD (EI)', 'OECD (EIA)', 'OECD (Ember)', 'OECD (Shift)', 'OPEC (EI)', 'OPEC (EIA)', 'OPEC (Shift)', 'Oceania', 'Oceania (Ember)', 'Other Africa (EI)', 'Other Americas (EIA)', 'Other Asia Pacific (EI)', 'Other Asia-Pacific (EIA)', 'Other CIS (EI)', 'Other Caribbean (EI)', 'Other Eastern Africa (EI)', 'Other Europe (EI)', 'Other Middle Africa (EI)', 'Other Middle East (EI)', 'Other North America (EI)', 'Other Northern Africa (EI)', 'Other South America (EI)', 'Other South and Central America (EI)', 'Other Southern Africa (EI)', 'Other Western Africa (EI)', 'Persian Gulf (EIA)', 'Persian Gulf (Shift)', 'Rest of World (EI)', 'South America', 'South and Central America (EI)', 'U.S. Pacific Islands (EIA)', 'U.S. Territories (EIA)', 'United States Pacific Islands (Shift)', 'United States Territories (Shift)', 'Upper-middle-income countries', 'Wake Island (EIA)', 'Wake Island (Shift)', 'Western Africa (EI)', 'Western Europe (EIA)', 'World')
)

SELECT
    country,
    unstable_grid_share,
    stability_case
FROM
    stability_clasify
WHERE year = 2024 AND unstable_grid_share IS NOT NULL AND stability_case = 'Perfectly Balanced'
