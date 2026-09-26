\set ON_ERROR_STOP on

-- LOCAL DATABASE SETUP (run separately, once per computer):
-- From a terminal, create the database with: createdb renewable_energy_share
-- Or connect to PostgreSQL and run: CREATE DATABASE renewable_energy_share;
-- The commands above are examples only; this script does not create the database.

\connect renewable_energy_share

CREATE TABLE IF NOT EXISTS renewable_energy_share (
    country TEXT,
    year INTEGER,
    iso_code TEXT,
    population NUMERIC,
    gdp NUMERIC,
    primary_energy_consumption NUMERIC,
    electricity_generation NUMERIC,
    electricity_demand NUMERIC,
    renewables_share_energy NUMERIC,
    renewables_share_elec NUMERIC,
    fossil_share_energy NUMERIC,
    fossil_share_elec NUMERIC,
    low_carbon_share_energy NUMERIC,
    low_carbon_share_elec NUMERIC,
    solar_electricity NUMERIC,
    wind_electricity NUMERIC,
    hydro_electricity NUMERIC,
    nuclear_electricity NUMERIC,
    coal_electricity NUMERIC,
    gas_electricity NUMERIC,
    oil_electricity NUMERIC,
    biofuel_electricity NUMERIC,
    other_renewable_electricity NUMERIC,
    solar_share_elec NUMERIC,
    wind_share_elec NUMERIC,
    hydro_share_elec NUMERIC,
    nuclear_share_elec NUMERIC,
    coal_share_elec NUMERIC,
    gas_share_elec NUMERIC,
    energy_per_capita NUMERIC,
    renewables_energy_per_capita NUMERIC,
    fossil_energy_per_capita NUMERIC,
    renewables_cons_change_twh NUMERIC
);

BEGIN;

TRUNCATE TABLE renewable_energy_share;

\copy renewable_energy_share FROM 'renewable_energy_share_2000_2025.csv' WITH (FORMAT csv, HEADER true, NULL '')

COMMIT;

SELECT COUNT(*) AS rows_loaded
FROM renewable_energy_share;