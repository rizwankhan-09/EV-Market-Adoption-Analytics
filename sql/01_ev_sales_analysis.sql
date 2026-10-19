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


-- Q6. EV Sales by Vehicle Class
-- Business Question: Which vehicle classes have the highest recorded EV sales quantity?
SELECT
    Vehicle_Class,
    SUM(EV_Sales_Quantity) AS total_ev_sales
FROM ev_sales
GROUP BY Vehicle_Class
ORDER BY total_ev_sales DESC;


-- Q7. EV Sales by State and Year
-- Business Question: How do recorded EV sales vary across states and years?
SELECT
    State,
    Year,
    SUM(EV_Sales_Quantity) AS total_ev_sales
FROM ev_sales
GROUP BY State, Year
ORDER BY State, Year;


-- Q8. Top 10 States by EV Sales in 2024
-- Business Question: Which states had the highest recorded EV sales quantity in 2024?
SELECT
    State,
    SUM(EV_Sales_Quantity) AS total_ev_sales
FROM ev_sales
WHERE Year = 2024
GROUP BY State
ORDER BY total_ev_sales DESC
LIMIT 10;

-- Q9. EV Sales by Vehicle Category and Year
-- Business Question: How has recorded EV sales quantity changed across categories over the years?
SELECT
    Year,
    Vehicle_Category,
    SUM(EV_Sales_Quantity) AS total_ev_sales
FROM ev_sales
GROUP BY Year, Vehicle_Category
ORDER BY Year, total_ev_sales DESC;

-- Q10. Year-over-Year EV Sales Growth
-- Business Question: How much did EV sales increase or decrease compared to the previous year?
SELECT
    Year,
    SUM(EV_Sales_Quantity) AS total_ev_sales,
    SUM(EV_Sales_Quantity)
        - LAG(SUM(EV_Sales_Quantity)) OVER (ORDER BY Year)
        AS sales_change
FROM ev_sales
GROUP BY Year
ORDER BY Year;

-- Q11. EV Sales Contribution by Vehicle Category
-- Business Question: What percentage of total recorded EV sales comes from each vehicle category?
SELECT
    Vehicle_Category,
    SUM(EV_Sales_Quantity) AS total_ev_sales,
    ROUND(
        SUM(EV_Sales_Quantity) * 100.0 /
        (SELECT SUM(EV_Sales_Quantity) FROM ev_sales),
        2
    ) AS sales_percentage
FROM ev_sales
GROUP BY Vehicle_Category
ORDER BY total_ev_sales DESC;

-- Q12. State-wise EV Sales Contribution (%)
-- Business Question: What percentage of total recorded EV sales comes from each state?
SELECT
    State,
    SUM(EV_Sales_Quantity) AS total_ev_sales,
    ROUND(
        SUM(EV_Sales_Quantity) * 100.0 /
        (SELECT SUM(EV_Sales_Quantity)
         FROM ev_sales),
        2
    ) AS sales_percentage
FROM ev_sales
GROUP BY State
ORDER BY total_ev_sales DESC;

-- Q13. Zero-Sales Record Analysis by Year
-- Question: Find the number of zero-sales and non-zero-sales records for each year, along with the percentage of zero-sales records.
SELECT
    Year,
    COUNT(*) AS total_records,
    SUM(CASE WHEN EV_Sales_Quantity = 0 THEN 1 ELSE 0 END) AS zero_sales_records,
    SUM(CASE WHEN EV_Sales_Quantity > 0 THEN 1 ELSE 0 END) AS non_zero_sales_records,
    ROUND(
        SUM(CASE WHEN EV_Sales_Quantity = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS zero_sales_percentage
FROM ev_sales
GROUP BY Year
ORDER BY Year;

-- Q14. State-wise EV Sales Growth from 2022 to 2023
-- Question: Find the EV sales and absolute sales change for each state between 2022 and 2023. Display the states with the highest sales growth first.
SELECT
    State,
    SUM(CASE
        WHEN Year = 2022 THEN EV_Sales_Quantity
        ELSE 0
    END) AS sales_2022,
    SUM(CASE
        WHEN Year = 2023 THEN EV_Sales_Quantity
        ELSE 0
    END) AS sales_2023,
    SUM(CASE
        WHEN Year = 2023 THEN EV_Sales_Quantity
        ELSE 0
    END) -
    SUM(CASE
        WHEN Year = 2022 THEN EV_Sales_Quantity
        ELSE 0
    END) AS sales_change
FROM ev_sales
WHERE Year IN (2022, 2023)
GROUP BY State
ORDER BY sales_change DESC;

-- Q15. Vehicle Category-wise Average Annual EV Sales
-- Question: Calculate the average annual EV sales for each vehicle category and rank the categories from highest to lowest average sales.
SELECT
    Vehicle_Category,
    ROUND(AVG(yearly_sales), 2) AS avg_annual_sales
FROM (
    SELECT
        Vehicle_Category,
        Year,
        SUM(EV_Sales_Quantity) AS yearly_sales
    FROM ev_sales
    GROUP BY Vehicle_Category, Year
) AS yearly_category_sales
GROUP BY Vehicle_Category
ORDER BY avg_annual_sales DESC;

-- Q16. Year-wise EV Sales Growth Rate (%)
-- Question: Calculate the year-over-year percentage growth in total EV sales for each year.
WITH yearly_sales AS (
    SELECT
        Year,
        SUM(EV_Sales_Quantity) AS total_ev_sales
    FROM ev_sales
    GROUP BY Year
),
sales_growth AS (
    SELECT
        Year,
        total_ev_sales,
        LAG(total_ev_sales) OVER (ORDER BY Year) AS previous_year_sales
    FROM yearly_sales
)
SELECT
    Year,
    total_ev_sales,
    previous_year_sales,
    ROUND(
        (total_ev_sales - previous_year_sales) * 100.0
        / NULLIF(previous_year_sales, 0),
        2
    ) AS growth_percentage
FROM sales_growth
ORDER BY Year;

-- Q17. Vehicle Category-wise Year-over-Year Growth
-- Question: Calculate the year-over-year EV sales growth percentage for each vehicle category.
WITH category_yearly_sales AS (
    SELECT
        Vehicle_Category,
        Year,
        SUM(EV_Sales_Quantity) AS total_sales
    FROM ev_sales
    GROUP BY Vehicle_Category, Year
),
category_growth AS (
    SELECT
        Vehicle_Category,
        Year,
        total_sales,
        LAG(total_sales) OVER (
            PARTITION BY Vehicle_Category
            ORDER BY Year
        ) AS previous_year_sales
    FROM category_yearly_sales
)
SELECT
    Vehicle_Category,
    Year,
    total_sales,
    previous_year_sales,
    ROUND(
        (total_sales - previous_year_sales) * 100.0
        / NULLIF(previous_year_sales, 0),
        2
    ) AS growth_percentage
FROM category_growth
ORDER BY Vehicle_Category, Year;

-- Q18. Top 5 States by EV Sales Growth Rate (2022–2023)
-- Question: Identify the top 5 states with the highest percentage growth in EV sales from 2022 to 2023.
WITH state_yearly_sales AS (
    SELECT
        State,
        Year,
        SUM(EV_Sales_Quantity) AS total_sales
    FROM ev_sales
    WHERE Year IN (2022, 2023)
    GROUP BY State, Year
),
state_growth AS (
    SELECT
        State,
        SUM(CASE WHEN Year = 2022 THEN total_sales ELSE 0 END) AS sales_2022,
        SUM(CASE WHEN Year = 2023 THEN total_sales ELSE 0 END) AS sales_2023
    FROM state_yearly_sales
    GROUP BY State
)
SELECT
    State,
    sales_2022,
    sales_2023,
    ROUND(
        (sales_2023 - sales_2022) * 100.0
        / NULLIF(sales_2022, 0),
        2
    ) AS growth_percentage
FROM state_growth
WHERE sales_2022 > 0
ORDER BY growth_percentage DESC
LIMIT 5;

-- Q19. EV Sales Seasonality by Quarter
-- Question: Calculate total EV sales for each quarter across all recorded years and identify which quarter has the highest sales.
SELECT
    q.sales_quarter,
    CASE q.sales_quarter
        WHEN 1 THEN 'Q1 (Jan-Mar)'
        WHEN 2 THEN 'Q2 (Apr-Jun)'
        WHEN 3 THEN 'Q3 (Jul-Sep)'
        WHEN 4 THEN 'Q4 (Oct-Dec)'
    END AS quarter_name,
    q.total_ev_sales
FROM (
    SELECT
        QUARTER(Date) AS sales_quarter,
        SUM(EV_Sales_Quantity) AS total_ev_sales
    FROM ev_sales
    GROUP BY QUARTER(Date)
) AS q
ORDER BY q.total_ev_sales DESC;

-- Q20. State-wise EV Sales by Vehicle Category
-- Business Question: Which vehicle categories contribute the most to EV sales within each state?
SELECT
    State,
    Vehicle_Category,
    SUM(EV_Sales_Quantity) AS total_ev_sales
FROM ev_sales
GROUP BY
    State,
    Vehicle_Category
ORDER BY
    State,
    total_ev_sales DESC;