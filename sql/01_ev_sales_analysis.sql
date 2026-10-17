CREATE DATABASE ev_market_analytics;

USE ev_market_analytics;

CREATE TABLE ev_sales (
    Year INT,
    Month_Name VARCHAR(20),
    Date DATE,
    State VARCHAR(100),
    Vehicle_Class VARCHAR(100),
    Vehicle_Category VARCHAR(100),
    Vehicle_Type VARCHAR(100),
    EV_Sales_Quantity INT
);


SELECT *
FROM ev_sales
LIMIT 10;

-- Q1. Year-wise EV Sales Trend
-- Business Question: How has EV sales quantity changed over the years?
SELECT
    Year,
    SUM(EV_Sales_Quantity) AS total_ev_sales
FROM ev_sales
GROUP BY Year
ORDER BY Year;

-- Q2. Top 10 States by EV Sales
-- Business Question: Which states have the highest EV sales quantity?
SELECT
    State,
    SUM(EV_Sales_Quantity) AS total_ev_sales
FROM ev_sales
GROUP BY State
ORDER BY total_ev_sales DESC
LIMIT 10;

-- Q3. Monthly EV Sales Trend
-- Business Question: Which months have the highest recorded EV sales quantity?
SELECT
    MONTH(Date) AS month_number,
    Month_Name,
    SUM(EV_Sales_Quantity) AS total_ev_sales
FROM ev_sales
GROUP BY MONTH(Date), Month_Name
ORDER BY month_number;

-- Q4. Top 10 Vehicle Types by EV Sales
-- Business Question: Which vehicle types have the highest recorded EV sales quantity?

SELECT
    Vehicle_Type,
    SUM(EV_Sales_Quantity) AS total_ev_sales
FROM ev_sales
GROUP BY Vehicle_Type
ORDER BY total_ev_sales DESC
LIMIT 10;

-- Q5. EV Sales by Vehicle Category
-- Business Question: Which vehicle categories have the highest recorded EV sales quantity?

SELECT
    Vehicle_Category,
    SUM(EV_Sales_Quantity) AS total_ev_sales
FROM ev_sales
GROUP BY Vehicle_Category
ORDER BY total_ev_sales DESC;



