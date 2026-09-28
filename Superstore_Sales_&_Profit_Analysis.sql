/* Superstore Sales & Profit Analyses*/

-- Analyses by Bulelwa Bisholo


-- 1. Data Familiarisation
SELECT *
FROM orders;

-- This is to understand the data structure 
SELECT COUNT(*) AS total_rows
FROM orders;

-- Checking of unique orders 

SELECT COUNT(DISTINCT order_id) AS unique_orders
FROM orders;
-- I started by understanding the structure and size of the dataset. The dataset contains 9,692 rows and 4,931 unique orders.


-- 2. Overall Business Performance 
-- This establishes the overall performance of the business before looking at individual areas.
SELECT
    COUNT(*) AS total_orders,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity,
    AVG(discount) * 100 AS average_discount
FROM orders;
/* I first looked at the overall performance of the business by measuring total sales, profit, quantity and average discount. 
This gave me a baseline before moving into the more detailed analysis */ 


-- 3. Profitability and Loss Making 
-- How much of the business is loss-making?
SELECT COUNT(*) as loss_making_rows
FROM orders
WHERE profit < 0;

SELECT 
    COUNT(DISTINCT order_id) AS loss_making_orders
FROM orders
WHERE profit < 0;

SELECT 
    SUM(PROFIT) AS tota_loss
FROM orders
WHERE profit < 0;

-- Category-level loss analysis
SELECT
    category,
    SUM(profit) AS total_loss
FROM orders
WHERE profit < 0
GROUP BY category
ORDER BY total_loss ASC;


-- Sub-category-level loss analysis
SELECT sub_category,
       SUM(profit) AS total_loss
FROM orders
WHERE profit < 0
GROUP BY sub_category
ORDER BY total_loss;

/* This is  where I was investigating about where the business was losing money. 
I looked at loss-making records, loss-making orders, and which categories and sub-categories contributed to the losses */

SELECT
    sub_category,
    COUNT(*) AS total_rows,
    SUM(quantity) AS total_quantity,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    AVG(discount) * 100 AS average_discount
FROM orders
WHERE sub_category = 'Binders'
GROUP BY sub_category;

SELECT
    discount,
    COUNT(*) AS total_rows,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
WHERE sub_category = 'Binders'
GROUP BY discount
ORDER BY discount;



-- 4.Discount & Profitability Analysis

SELECT 
    discount,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(*) AS total_orders
FROM orders
GROUP BY discount
ORDER BY discount;


-- Identifying loss-making discount levels
SELECT 
    discount,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    AVG(profit) AS avg_profit
FROM orders
GROUP BY discount
HAVING SUM(profit) < 0
ORDER BY total_profit;
/* One of my key findings was the relationship between discounting and profitability. 
The highest profit came from orders with no discount, while discounts from 30% to 80% resulted in negative profit. 
This suggests that deeper discounts can negatively affect profitability.*/


-- 5. Customer Segment Analysis
-- Which customer segment generates the highest sales and profit?

SELECT segment,
SUM(sales) as total_sales,
SUM(profit) as total_profit,
COUNT(*) AS total_orders
FROM orders 
GROUP BY segment
ORDER BY total_sales DESC;
/* When I compared the customer segments, Consumer was the strongest-performing segment, generating both the highest sales and the highest profit.*/

-- 6. Product Category Analysis
-- Which product category generates the highest sales and profit?
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_sales DESC;
/* Technology was the strongest-performing product category, leading in both sales and profitability.*/

-- 7. Regional Performance
-- Which region generates the highest sales and profit?

SELECT region,
SUM(sales) AS total_sales,
SUM(profit) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_sales DESC;
/* From a regional perspective, the West performed the strongest, generating both the highest sales and highest profit.*/

-- 8. Top Products
-- Which products generate the highest sales?

SELECT product_name, SUM(sales) AS total_sales
FROM orders
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;
/* I also identified the top 10 products by sales to understand which individual products contributed most to revenue.*/

-- 9. Customer Performance
-- Which customers generate the highest sales?
SELECT CUSTOMER_NAME, 
SUM(SALES) AS TOTAL_SALES,
SUM(PROFIT) AS TOTAL_PROFIT
FROM ORDERS 
GROUP BY CUSTOMER_NAME
ORDER BY TOTAL_SALES DESC;

/*One interesting finding was that the customer with the highest sales was not necessarily profitable.
 Sean Miller generated the highest sales, but his total profit was negative. 
 I would investigate this further by looking at his discounts and product mix.*/

-- 10. Sales & Profit Trend
-- How do sales and profit change over time?

SELECT
    YEAR(STR_TO_DATE(order_date, '%m/%d/%Y')) AS order_year,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
GROUP BY YEAR(STR_TO_DATE(order_date, '%m/%d/%Y'))
ORDER BY order_year;

/* Finally, I looked at performance over time. 
Both sales and profit generally increased across the period, with 2017 recording the highest sales and profit.*/
