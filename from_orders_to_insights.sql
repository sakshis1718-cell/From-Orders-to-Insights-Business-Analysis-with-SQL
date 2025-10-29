---------------------------------------------------------
-- PROJECT: From Orders to Insights: Business Analysis with SQL
-- AUTHOR: Sakshi Singh
-- DESCRIPTION:
-- This SQL project analyzes business data to derive insights 
-- like top-performing products, category revenue and trends.
---------------------------------------------------------
USE Superstore;
SELECT* FROM  `order_info`;
SELECT* FROM  `customer_info`;
SELECT* FROM  `product_info`;

-- BASIC QUOTIENTS 
-- Q1.Retrieve the total number of orders placed.
SELECT COUNT(`Order ID`) as Total_orders FROM `order_info`;
---------------------------------------------------------------------------
-- Q2.Calculate the total revenue generated from Superstore’s sales.
SELECT ROUND(SUM(Sales), 2) AS Total_Revenue FROM order_info;
---------------------------------------------------------------------------
-- Q3. Average order value (average Sales per order)
SELECT ROUND(AVG(sales),2) AS Avg_order_value FROM order_info;
---------------------------------------------------------------------------
-- Q4. Top 5 orders by Sales
SELECT `Order ID`, `Order Date`, Sales, Profit
FROM `order_info`
ORDER BY Sales DESC
LIMIT 5;
---------------------------------------------------------------------------
-- Q5. Total sales and average profit by Ship Mode
SELECT `ship mode`,
ROUND(SUM(sales),2) AS Total_sales,
ROUND(AVG(profit),2) AS Avg_profit 
FROM `order_info`
GROUP BY `Ship mode` ORDER BY Total_sales DESC;
---------------------------------------------------------------------------
-- INTERMEDIATE QUOTIENTS 
-- Q6. Number of orders per year
SELECT
YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Order_Year,
COUNT(`Order ID`) AS Orders_Count
FROM `order_info`
GROUP BY Order_Year
ORDER BY Order_Year;
---------------------------------------------------------------------------
-- Q7. Profit margin percentage per order and summary
 -- (NULLIF prevents division-by-zero if Sales = 0)
 SELECT 
 `Order ID`,
 Sales,
 Profit,
 ROUND((Profit/ NULLIF (Sales, 0)) * 100,2) AS profit_margin_percentage
 FROM `order_info`
 ORDER BY profit_margin_percentage DESC
 LIMIT 10;
---------------------------------------------------------------------------
-- Q8. Total number of customers
SELECT COUNT(`Customer ID`) AS total_customers FROM `customer_info`;
 ---------------------------------------------------------------------------
 -- Q9. Number of customers per Region
SELECT `Region`, COUNT(`customer ID`) AS Customer_count
FROM `customer_info`
GROUP BY `Region`
ORDER BY `Customer_count` DESC;
---------------------------------------------------------------------------
-- Q10.Rank orders by Sales using a window function
-- Shows row number, Sales and Profit for each order (top 10)
SELECT `row id`,
sales,
profit,
ROW_NUMBER( ) OVER(ORDER BY SALES DESC) AS Orders_rank 
FROM `order_info`
LIMIT 10;
---------------------------------------------------------------------------
-- ADVANCED QUOTIENTS 
-- Q11.Calculate the average order value for each day.
SELECT
`Order Date`,
ROUND(AVG(Sales), 2) AS Avg_Daily_Order
FROM `order_info`
GROUP BY `Order Date`
ORDER BY STR_TO_DATE(`Order Date`, '%m/%d/%Y');
---------------------------------------------------------------------------
 -- Q12.Show what percentage each order contributes to total revenue.
SELECT
`Order ID`,
Sales,
ROUND((Sales / (SELECT SUM(Sales) FROM `order_info`)) * 100, 2) AS Revenue_Percentage
FROM `order_info`
ORDER BY Revenue_Percentage DESC
LIMIT 5;
---------------------------------------------------------------------------
-- Q13. Analyze cumulative revenue generated over time
-- (Shows how revenue builds up by order date)
SELECT 
`Order Date`,
ROUND(SUM(Sales), 2) AS Daily_Revenue,
ROUND(SUM(SUM(Sales)) OVER (ORDER BY `Order Date`), 2) AS Cumulative_Revenue
FROM `order_info`
GROUP BY `Order Date`
ORDER BY `Order Date`;


