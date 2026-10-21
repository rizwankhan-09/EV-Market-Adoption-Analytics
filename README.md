# Electric Vehicle Market & Adoption Analytics — India

## Project Overview

This project explores electric vehicle (EV) sales patterns across Indian states, years, vehicle categories, and vehicle types using Python, Pandas, MySQL, and Power BI.

The goal is to transform raw data into meaningful insights through data cleaning, SQL analysis, and interactive visualizations.

## Project Objectives

- Analyze EV sales trends over time.
- Compare reported EV sales quantities across Indian states.
- Understand sales distribution across vehicle categories and types.
- Inspect, clean, and validate data using Python Pandas.
- Use SQL queries to answer business questions.
- Build an interactive Power BI dashboard for data exploration.

## Tools & Technologies

- Python
- Pandas
- MySQL
- Power BI
- Git and GitHub

## Project Workflow

1. **Data Inspection:** Examined dataset structure, columns, missing values, duplicates, and sales patterns.
2. **Data Cleaning:** Standardized data types, parsed dates, validated sales quantities, and exported the cleaned dataset.
3. **SQL Analysis:** Queried EV sales by year, state, vehicle category, and vehicle type.
4. **Power BI Dashboard:** Created KPI cards, slicers, trend charts, and sales comparison visuals.
5. **Documentation:** Recorded the workflow, tools, and limitations of the analysis.

## Dashboard Preview

![India EV Market & Adoption Analytics Dashboard](powerbi/ev_dashboard.png)

## Project Progress

- [x] Dataset inspection
- [x] Data cleaning and validation using Python Pandas
- [x] SQL analysis with 20 business-focused queries
- [x] Interactive Power BI dashboard
- [x] Dashboard screenshot uploaded to GitHub
- [x] Final business insights and conclusions

## Project Status

Core analysis, data cleaning, SQL queries, Power BI dashboard, and project documentation are complete. The project is ready for portfolio review.

## Dataset

The dataset contains reported electric vehicle sales information across Indian states, vehicle categories, and vehicle types from 2014 to 2024.

Raw and cleaned CSV files are stored locally and excluded from GitHub while redistribution permissions are being verified.

**Note:** The available 2024 data may be incomplete. Comparisons involving 2024 should therefore be interpreted cautiously.

## Key Analysis Areas

- Annual EV sales trends
- State-wise EV sales comparison
- Vehicle category sales distribution
- Top vehicle types by reported sales
- Monthly sales patterns
- Total reported EV sales and dataset coverage

## Key Business Insights

- The dataset contains approximately 4 million recorded EV sales across 34 states and union territories.
- Uttar Pradesh records the highest EV sales, followed by Maharashtra.
- Two-wheelers represent the largest share of recorded EV sales.
- Annual sales show substantial growth in recent years, particularly between 2022 and 2023.
- Monthly analysis indicates variations in recorded EV sales throughout the year.
- The apparent decline in 2024 should be interpreted cautiously because the available data may be incomplete.

## Limitations

- The analysis is based on the available dataset and its reported sales quantities.
- The 2024 data may be incomplete, affecting year-over-year comparisons.
- The findings describe patterns in the dataset and should not automatically be interpreted as explanations of market behaviour.

## Project Structure

```text
EV_Market_Analytics/
├── scripts/
│   ├── 01_data_inspection.py
│   └── 02_data_cleaning.py
├── sql/
│   └── 01_ev_sales_analysis.sql
├── powerbi/
│   ├── India_EV_Market_Adoption_Analytics.pbix
│   └── ev_dashboard.png
├── data/
│   ├── raw/
│   └── processed/
├── notebooks/
├── .gitignore
└── README.md