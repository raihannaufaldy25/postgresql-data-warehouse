# Data Warehouse and Analytics Project Using PostgreSQL

## Overview

This project demonstrates the design and implementation of a modern data warehouse using PostgreSQL. It simulates a real-world analytics scenario where sales data from multiple source systems is consolidated into a centralized, analytics-ready data model. The goal of this project is to transform raw operational data into clean, structured datasets that support reporting, analysis, and data-driven decision-making.
This repository is intended as a professional portfolio project for data engineering and analytics roles.

---

## Data Architecture

The solution follows the Medallion Architecture, which separates data processing into three layers to improve data quality, scalability, and analytical performance.


### Bronze Layer
- Stores raw data ingested from source systems
- Data is loaded from CSV files into PostgreSQL without transformation
- Serves as the raw source of truth

### Silver Layer
- Performs data cleaning and transformation
- Applies validation, standardization, and type casting
- Produces consistent and reliable datasets for analysis

### Gold Layer
- Contains business-ready data modeled using a star schema
- Includes fact and dimension tables optimized for analytics
- Used directly for reporting and analytical queries




