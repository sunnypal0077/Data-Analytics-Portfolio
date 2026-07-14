-- ==========================================================
-- ShopSmart Retail Analytics
-- Advanced SQL Queries
-- Author: Sunny Pal
-- ==========================================================

USE ShopSmartDB;

-- ==========================================================
-- 1. Rank Products by Revenue
-- ==========================================================

SELECT
    Product,
    SUM(Sales) AS Revenue,
    RANK() OVER(ORDER BY SUM(Sales) DESC) AS Product_Rank
FROM retail_sales
GROUP BY Product;

-- ==========================================================
-- 2. Dense Rank Products
-- ==========================================================

SELECT
    Product,
    SUM(Sales) AS Revenue,
    DENSE_RANK() OVER(ORDER BY SUM(Sales) DESC) AS Dense_Rank
FROM retail_sales
GROUP BY Product;

-- ==========================================================
-- 3. Row Number for Customers
-- ==========================================================

SELECT
    Customer_Name,
    SUM(Sales) AS Revenue,
    ROW_NUMBER() OVER(ORDER BY SUM(Sales) DESC) AS Row_Num
FROM retail_sales
GROUP BY Customer_Name;

-- ==========================================================
-- 4. Running Total of Sales
-- ==========================================================

SELECT
    Order_Date,
    Sales,
    SUM(Sales)
    OVER(
        ORDER BY Order_Date
    ) AS Running_Total
FROM retail_sales;

-- ==========================================================
-- 5. Cumulative Revenue by Month
-- ==========================================================

SELECT
    MONTH(Order_Date) Month_No,
    MONTHNAME(Order_Date) Month_Name,
    SUM(Sales) Revenue,
    SUM(SUM(Sales))
    OVER(
        ORDER BY MONTH(Order_Date)
    ) AS Cumulative_Revenue
FROM retail_sales
GROUP BY MONTH(Order_Date),MONTHNAME(Order_Date);

-- ==========================================================
-- 6. Top Customer Using CTE
-- ==========================================================

WITH CustomerRevenue AS
(
SELECT
Customer_Name,
SUM(Sales) Revenue
FROM retail_sales
GROUP BY Customer_Name
)

SELECT *
FROM CustomerRevenue
ORDER BY Revenue DESC
LIMIT 10;

-- ==========================================================
-- 7. Products Above Average Revenue
-- ==========================================================

SELECT
Product,
SUM(Sales) Revenue
FROM retail_sales
GROUP BY Product
HAVING SUM(Sales) >
(
SELECT AVG(ProductRevenue)
FROM
(
SELECT SUM(Sales) ProductRevenue
FROM retail_sales
GROUP BY Product
) x
);

-- ==========================================================
-- 8. Monthly Growth
-- ==========================================================

WITH MonthlySales AS
(
SELECT
MONTH(Order_Date) Month_No,
SUM(Sales) Revenue
FROM retail_sales
GROUP BY MONTH(Order_Date)
)

SELECT
Month_No,
Revenue,
Revenue-
LAG(Revenue)
OVER(
ORDER BY Month_No
) Growth
FROM MonthlySales;

-- ==========================================================
-- 9. Previous Order Comparison
-- ==========================================================

SELECT
Order_ID,
Order_Date,
Sales,

LAG(Sales)
OVER(
ORDER BY Order_Date
) Previous_Order,

Sales-
LAG(Sales)
OVER(
ORDER BY Order_Date
) Difference

FROM retail_sales;

-- ==========================================================
-- 10. Next Order Comparison
-- ==========================================================

SELECT
Order_ID,
Order_Date,
Sales,

LEAD(Sales)
OVER(
ORDER BY Order_Date
) Next_Order

FROM retail_sales;

-- ==========================================================
-- 11. Top 20 Percent Customers
-- ==========================================================

SELECT *

FROM

(

SELECT

Customer_Name,

SUM(Sales) Revenue,

NTILE(5)

OVER(

ORDER BY SUM(Sales) DESC

) Customer_Group

FROM retail_sales

GROUP BY Customer_Name

) x

WHERE Customer_Group=1;

-- ==========================================================
-- 12. Revenue Share by Product
-- ==========================================================

SELECT

Product,

SUM(Sales) Revenue,

ROUND(

SUM(Sales)*100/

(SUM(SUM(Sales))

OVER()),2)

AS Revenue_Share

FROM retail_sales

GROUP BY Product

ORDER BY Revenue DESC;

-- ==========================================================
-- 13. Customer Lifetime Value
-- ==========================================================

SELECT

Customer_Name,

COUNT(*) Orders,

SUM(Sales) Lifetime_Value

FROM retail_sales

GROUP BY Customer_Name

ORDER BY Lifetime_Value DESC;

-- ==========================================================
-- 14. Best Selling Product in Each Category
-- ==========================================================

WITH ProductRevenue AS

(

SELECT

Category,

Product,

SUM(Sales) Revenue,

RANK()

OVER(

PARTITION BY Category

ORDER BY SUM(Sales) DESC

) rk

FROM retail_sales

GROUP BY Category,Product

)

SELECT *

FROM ProductRevenue

WHERE rk=1;

-- ==========================================================
-- 15. Revenue Contribution by Customer
-- ==========================================================

SELECT

Customer_Name,

SUM(Sales) Revenue,

ROUND(

SUM(Sales)*100/

(SUM(SUM(Sales))

OVER()),2)

Contribution_Percentage

FROM retail_sales

GROUP BY Customer_Name

ORDER BY Revenue DESC;
