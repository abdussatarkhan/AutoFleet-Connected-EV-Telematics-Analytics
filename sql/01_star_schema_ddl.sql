-- ============================================================================
-- AutoFleet: Connected Electric Vehicle Fleet Telematics & Battery Health Analytics
-- Star Schema DDL (PostgreSQL 16 Enterprise Spec)
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS autofleet_dw;
SET search_path TO autofleet_dw, public;

-- Date Dimension
CREATE TABLE IF NOT EXISTS dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day_name VARCHAR(12) NOT NULL,
    is_weekend BOOLEAN NOT NULL,
    month INT NOT NULL,
    quarter INT NOT NULL,
    year INT NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_vehicles_ev (
    vehicles_ev_key SERIAL PRIMARY KEY,
    vehicles_ev_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dim_battery_packs (
    battery_packs_key SERIAL PRIMARY KEY,
    battery_packs_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dim_charging_stations (
    charging_stations_key SERIAL PRIMARY KEY,
    charging_stations_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dim_routes_fleet (
    routes_fleet_key SERIAL PRIMARY KEY,
    routes_fleet_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_telemetry_trips (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_battery_degradation (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_charging_sessions (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_maintenance_events (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

