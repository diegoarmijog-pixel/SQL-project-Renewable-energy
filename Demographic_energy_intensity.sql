/* DEMOGRAPHIC ENERGY INTENSITY
*Per Capita Demand Drivers
This query tracks population against per-capita energy usage to determine if grid strain is driven by more people or by higher individual consumption. */

WITH growthcalc AS (
    SELECT 
        country,
        year,
        population,
        energy_per_capita,
        (population - LAG(population) OVER (PARTITION BY country ORDER BY year)) / NULLIF(LAG(population) OVER (PARTITION BY country ORDER BY year), 0) * 100 AS population_growth_percentage,
        (energy_per_capita - LAG(energy_per_capita) OVER (PARTITION BY country ORDER BY year)) / NULLIF(LAG(energy_per_capita) OVER (PARTITION BY country ORDER BY year), 0) * 100 AS energy_pc_growth_percentage
    FROM country_general_info
    WHERE population IS NOT NULL 
      AND energy_per_capita IS NOT NULL
)
SELECT 
    country,
    year,
    population,
    energy_per_capita,
    population_growth_percentage,
    energy_pc_growth_percentage
FROM growthcalc
WHERE year BETWEEN 2001 AND 2024
  AND energy_pc_growth_percentage IS NOT NULL
ORDER BY energy_pc_growth_percentage DESC;