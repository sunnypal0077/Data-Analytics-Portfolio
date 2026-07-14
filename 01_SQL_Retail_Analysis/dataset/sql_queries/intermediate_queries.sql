-- ==========================================================
-- ShopSmart Retail Analytics
-- Intermediate SQL Queries
-- ==========================================================

USE ShopSmartDB;

-- ==========================================================
-- 1. Revenue by Month
-- ==========================================================
SELECT
    MONTHNAME(Order_Date) AS Month,
    ROUND(SUM(Sales),2) AS Revenue
FROM retail_sales
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY MONTH(Order_Date);

-- ==========================================================
-- 2. Revenue by Category
-- ==========================================================
SELECT
    Category,
    ROUND(SUM(Sales),2) AS Revenue,
    COUNT(*) AS Orders
FROM retail_sales
GROUP BY Category
ORDER BY Revenue DESC;

-- ==========================================================
-- 3. Top 5 Customers by Spending
-- ==========================================================
SELECT
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Sales),2) AS Total_Spent
FROM retail_sales
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Spent DESC
LIMIT 5;

-- ==========================================================
-- 4. Top 5 Products by Revenue
-- ==========================================================
SELECT
    Product,
    ROUND(SUM(Sales),2) AS Revenue
FROM retail_sales
GROUP BY Product
ORDER BY Revenue DESC
LIMIT 5;

-- ==========================================================
-- 5. Average Sales by Category
-- ==========================================================
SELECT
    Category,
    ROUND(AVG(Sales),2) AS Avg_Sales
FROM retail_sales
GROUP BY Category
ORDER BY Avg_Sales DESC;

-- ==========================================================
-- 6. Highest Revenue Day
-- ==========================================================
SELECT
    Order_Date,
    ROUND(SUM(Sales),2) AS Revenue
FROM retail_sales
GROUP BY Order_Date
ORDER BY Revenue DESC
LIMIT 1;

-- ==========================================================
-- 7. Customer Purchase Frequency
-- ==========================================================
SELECT
    Customer_ID,
    Customer_Name,
    COUNT(*) AS Total_Orders
FROM retail_sales
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Orders DESC;

-- ==========================================================
-- 8. Revenue Contribution (%)
-- ==========================================================
SELECT
    Category,
    ROUND(
        SUM(Sales) * 100 /
        (SELECT SUM(Sales) FROM retail_sales),2
    ) AS Revenue_Percentage
FROM retail_sales
GROUP BY Category
ORDER BY Revenue_Percentage DESC;

-- ==========================================================
-- 9. Monthly Order Count
-- ==========================================================
SELECT
    MONTHNAME(Order_Date) AS Month,
    COUNT(*) AS Orders
FROM retail_sales
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY MONTH(Order_Date);

-- ==========================================================
-- 10. Products Sold More Than Average Quantity
-- ==========================================================
SELECT
    Product,
    SUM(Quantity) AS Total_Qty
FROM retail_sales
GROUP BY Product
HAVING SUM(Quantity) >
(
    SELECT AVG(total_qty)
    FROM
    (
        SELECT SUM(Quantity) AS total_qty
        FROM retail_sales
        GROUP BY Product
    ) t
);

-- ==========================================================
-- 11. Revenue by Customer
-- ==========================================================
SELECT
    Customer_Name,
    ROUND(SUM(Sales),2) AS Revenue
FROM retail_sales
GROUP BY Customer_Name
ORDER BY Revenue DESC;

-- ==========================================================
-- 12. Category-wise Quantity Sold
-- ==========================================================
SELECT
    Category,
    SUM(Quantity) AS Quantity_Sold
FROM retail_sales
GROUP BY Category
ORDER BY Quantity_Sold DESC;

-- ==========================================================
-- 13. Average Order Value per Customer
-- ==========================================================
SELECT
    Customer_Name,
    ROUND(AVG(Sales),2) AS Avg_Order_Value
FROM retail_sales
GROUP BY Customer_Name
ORDER BY Avg_Order_Value DESC;

-- ==========================================================
-- 14. Highest Selling Category
-- ==========================================================
SELECT
    Category,
    SUM(Sales) AS Revenue
FROM retail_sales
GROUP BY Category
ORDER BY Revenue DESC
LIMIT 1;

-- ==========================================================
-- 15. Products Ordered More Than 20 Times
-- ==========================================================
SELECT
    Product,
    COUNT(*) AS Orders
FROM retail_sales
GROUP BY Product
HAVING COUNT(*) > 20
ORDER BY Orders DESC;
