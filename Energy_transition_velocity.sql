/* 
ENERGY TRANSITION VELOCITY

*Fossil Peak and Drop-Off
This query identifies the absolute maximum historical fossil fuel share for each country and calculates the total percentage point drop to the most recent year. */


WITH PeakFossil AS (
    SELECT
        country,
        MAX(fossil_share_elec) AS max_fossil_share
    FROM electricity_share
    GROUP BY country
)

SELECT
    e.country,
    e.year,
    e.fossil_share_elec,
    p.max_fossil_share,
    (p.max_fossil_share - e.fossil_share_elec) AS percentage_point_drop
    FROM electricity_share e
    JOIN PeakFossil p ON e.country = p.country
    WHERE e.year = 2025
    /* for the top 10 with the largest drop*/
    ORDER BY percentage_point_drop DESC
    LIMIT 10;



/*
*Decarbonization Momentum (Rolling Averages)
This query calculates a 20-year rolling average of the renewable share to show the true underlying growth trend.
*/

SELECT
    country,
    year,
    renewables_share_elec,
    AVG(renewables_share_elec) OVER (
        PARTITION BY country
        ORDER BY year
        ROWS BETWEEN 19 PRECEDING AND CURRENT ROW
    ) AS rolling_renewable_share
FROM
    electricity_share;

    
/* for the top 10 growing countrys in decarbonization between 2000 and 2024 */
With startyear AS (
    SELECT country, renewables_share_elec AS start_share
    FROM electricity_share
    WHERE year = 2005 AND renewables_share_elec IS NOT NULL
),
endyear AS (
    SELECT country,renewables_share_elec AS end_share
    FROM electricity_share
    WHERE year = 2025 AND renewables_share_elec IS NOT NULL
)
SELECT
    startyear.country,
    startyear.start_share,
    endyear.end_share,
    (endyear.end_share - startyear.start_share) AS momentum_gained
FROM startyear
JOIN endyear ON startyear.country=endyear.country
ORDER BY momentum_gained DESC
LIMIT 10;