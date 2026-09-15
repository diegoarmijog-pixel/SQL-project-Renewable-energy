/* This Query creates a table that contains only the electricity generation share (%) for each contry between 2000 and 2025 */

CREATE TABLE electricity_share AS
    SELECT country,
        year,
        renewables_share_elec,
        fossil_share_elec,
        low_carbon_share_elec,
        solar_share_elec,
        wind_share_elec,
        hydro_share_elec,
        nuclear_share_elec,
        coal_share_elec,
        gas_share_elec
    FROM renewable_energy_share




