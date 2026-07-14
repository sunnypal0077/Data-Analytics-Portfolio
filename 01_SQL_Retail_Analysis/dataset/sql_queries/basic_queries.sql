-- ==========================================================
-- ShopSmart Retail Analytics
-- Basic SQL Analysis
-- Author: Sunny Pal
-- ==========================================================

USE ShopSmartDB;

-- ==========================================================
-- 1. View Complete Dataset
-- ==========================================================
SELECT *
FROM retail_sales;

-- ==========================================================
-- 2. Total Orders
-- ==========================================================
SELECT COUNT(*) AS Total_Orders
FROM retail_sales;

-- ==========================================================
-- 3. Total Revenue
-- ==========================================================
SELECT ROUND(SUM(Sales),2) AS Total_Revenue
FROM retail_sales;

-- ==========================================================
-- 4. Average Order Value
-- ==========================================================
SELECT ROUND(AVG(Sales),2) AS Average_Order_Value
FROM retail_sales;

-- ==========================================================
-- 5. Highest Order Value
-- ==========================================================
SELECT MAX(Sales) AS Highest_Order
FROM retail_sales;

-- ==========================================================
-- 6. Lowest Order Value
-- ==========================================================
SELECT MIN(Sales) AS Lowest_Order
FROM retail_sales;

-- ==========================================================
-- 7. Total Quantity Sold
-- ==========================================================
SELECT SUM(Quantity) AS Total_Quantity
FROM retail_sales;

-- ==========================================================
-- 8. Number of Customers
-- ==========================================================
SELECT COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM retail_sales;

-- ==========================================================
-- 9. Number of Products
-- ==========================================================
SELECT COUNT(DISTINCT Product) AS Total_Products
FROM retail_sales;

-- ==========================================================
-- 10. Revenue by Category
-- ==========================================================
SELECT
Category,
ROUND(SUM(Sales),2) AS Revenue
FROM retail_sales
GROUP BY Category
ORDER BY Revenue DESC;

-- ==========================================================
-- 11. Top 10 Products
-- ==========================================================
SELECT
Product,
ROUND(SUM(Sales),2) AS Revenue
FROM retail_sales
GROUP BY Product
ORDER BY Revenue DESC
LIMIT 10;

-- ==========================================================
-- 12. Top 10 Customers
-- ==========================================================
SELECT
Customer_Name,
ROUND(SUM(Sales),2) AS Revenue
FROM retail_sales
GROUP BY Customer_Name
ORDER BY Revenue DESC
LIMIT 10;

-- ==========================================================
-- 13. Category Wise Orders
-- ==========================================================
SELECT
Category,
COUNT(*) AS Orders
FROM retail_sales
GROUP BY Category
ORDER BY Orders DESC;

-- ==========================================================
-- 14. Average Quantity Sold Per Product
-- ==========================================================
SELECT
Product,
ROUND(AVG(Quantity),2) AS Avg_Quantity
FROM retail_sales
GROUP BY Product
ORDER BY Avg_Quantity DESC;

-- ==========================================================
-- 15. Monthly Sales Trend
-- ==========================================================
SELECT
MONTH(Order_Date) AS Month,
ROUND(SUM(Sales),2) AS Revenue
FROM retail_sales
GROUP BY MONTH(Order_Date)
ORDER BY Month;

-- ==========================================================
-- 16. Daily Sales
-- ==========================================================
SELECT
Order_Date,
ROUND(SUM(Sales),2) AS Revenue
FROM retail_sales
GROUP BY Order_Date
ORDER BY Order_Date;

-- ==========================================================
-- 17. Orders Per Customer
-- ==========================================================
SELECT
Customer_Name,
COUNT(*) AS Orders
FROM retail_sales
GROUP BY Customer_Name
ORDER BY Orders DESC;

-- ==========================================================
-- 18. Average Product Price
-- ==========================================================
SELECT
ROUND(AVG(Unit_Price),2) AS Average_Product_Price
FROM retail_sales;

-- ==========================================================
-- 19. Products Sold Above Average Price
-- ==========================================================
SELECT *
FROM retail_sales
WHERE Unit_Price >
(
SELECT AVG(Unit_Price)
FROM retail_sales
);

-- ==========================================================
-- 20. Top 5 Highest Value Orders
-- ==========================================================
SELECT
Order_ID,
Customer_Name,
Product,
Sales
FROM retail_sales
ORDER BY Sales DESC
LIMIT 5;
