-- ============================================
-- ShopSmart Retail Analytics Database Schema
-- ============================================

DROP DATABASE IF EXISTS ShopSmartDB;

CREATE DATABASE ShopSmartDB;

USE ShopSmartDB;

CREATE TABLE retail_sales (

    Order_ID INT PRIMARY KEY,

    Order_Date DATE NOT NULL,

    Customer_ID VARCHAR(20) NOT NULL,

    Customer_Name VARCHAR(100) NOT NULL,

    Category VARCHAR(50) NOT NULL,

    Product VARCHAR(100) NOT NULL,

    Quantity INT NOT NULL,

    Unit_Price DECIMAL(10,2) NOT NULL,

    Sales DECIMAL(12,2) NOT NULL

);

-- Check table structure
DESCRIBE retail_sales;
