\c postgres

-- Drop database if exists
DROP DATABASE IF EXISTS datawarehouse WITH (FORCE);

-- Create the database
CREATE DATABASE datawarehouse;

\c datawarehouse

-- Create Schemas
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;
