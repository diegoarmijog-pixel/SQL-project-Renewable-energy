/* This Query creates a table that contains only the electricity generation in TWh for each contry between 2000 and 2025 */

CREATE TABLE electricity_generation AS
    SELECT country,
        year,
        electricity_generation,
        solar_electricity,
        wind_electricity,
        hydro_electricity,
        nuclear_electricity,
        coal_electricity,
        gas_electricity,
        oil_electricity,
        biofuel_electricity,
        other_renewable_electricity
    FROM renewable_energy_share


