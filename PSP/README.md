
ETL Project - PSP Data Processing
Overview
This project is an ETL (Extract, Transform, Load) pipeline designed to process PSP dataset. The goal is to extract data from the source CSV, transform it according to business rules, and load it into a structured format for analysis.

Features

*Extracts data from CSV files.
*Cleans and transforms raw data (handling missing values, formatting columns, splitting genres, etc.).
*Loads processed data into PostgreSQL database or a new CSV for further analysis.
*Provides simple summary statistics for quick insights.

Tools & Technologies
*Python 3.x – main programming language for ETL scripts
*Pandas – data manipulation and cleaning
*PostgreSQL – database for storing transformed data
*SQLAlchemy (optional) – connecting Python to PostgreSQL
