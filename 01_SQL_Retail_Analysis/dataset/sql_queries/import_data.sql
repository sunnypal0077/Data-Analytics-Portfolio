USE ShopSmartDB;

LOAD DATA LOCAL INFILE 'retail_sales.csv'
INTO TABLE retail_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
Order_ID,
Order_Date,
Customer_ID,
Customer_Name,
Category,
Product,
Quantity,
Unit_Price,
Sales
);
