CREATE DATABASE retail_business;
USE retail_business;
CREATE TABLE retail_sales (
    Transaction_ID INT PRIMARY KEY,
    Date DATE,
    Customer_ID VARCHAR(50),
    Gender VARCHAR(10),
    Age INT,
    Product_Category VARCHAR(50),
    Quantity INT,
    Price_per_Unit DECIMAL(10,2),
    Total_Amount DECIMAL(10,2)
);
SELECT * FROM retail_sales;

-- Data Cleaning
-- Check for Duplicate value
SELECT Transaction_ID, COUNT(*) 
FROM retail_sales
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;



-- check for missing Null values
SELECT *
FROM retail_sales
WHERE 
    Transaction_ID IS NULL OR
    Date IS NULL OR
    Customer_ID IS NULL OR
    Gender IS NULL OR
    Age IS NULL OR
    Product_Category IS NULL OR
    Quantity IS NULL OR
    Price_per_Unit IS NULL OR
    Total_Amount IS NULL;


-- Total sales overview
SELECT 
    COUNT(Transaction_ID) AS total_transactions,
    SUM(Total_Amount) AS total_sales,
    AVG(Total_Amount) AS avg_transaction_value
FROM retail_sales;

-- Sales by Gender

SELECT 
    Gender,
    COUNT(Transaction_ID) AS total_transactions,
    SUM(Total_Amount) AS total_sales,
    ROUND(AVG(Total_Amount),2) AS avg_spent_per_transaction
FROM retail_sales
GROUP BY Gender
ORDER BY total_sales DESC;


-- Sales by age Group

SELECT 
    CASE
        WHEN Age BETWEEN 10 AND 20 THEN 'Teen (10–20)'
        WHEN Age BETWEEN 21 AND 30 THEN 'Young Adult (21–30)'
        WHEN Age BETWEEN 31 AND 45 THEN 'Adult (31–45)'
        WHEN Age BETWEEN 46 AND 60 THEN 'Middle Age (46–60)'
        ELSE 'Senior (60+)'
    END AS age_group,
    COUNT(Transaction_ID) AS total_transactions,
    SUM(Total_Amount) AS total_sales,
    ROUND(AVG(Total_Amount),2) AS avg_spent
FROM retail_sales
GROUP BY age_group
ORDER BY total_sales DESC;


-- Top-Selling Product Categories

SELECT 
    Product_Category,
    COUNT(Transaction_ID) AS total_transactions,
    SUM(Quantity) AS total_quantity_sold,
    SUM(Total_Amount) AS total_sales,
    ROUND(AVG(Total_Amount),2) AS avg_sale_value
FROM retail_sales
GROUP BY Product_Category
ORDER BY total_sales DESC;


-- Average Quantity per Order by Category

SELECT 
    Product_Category,
    ROUND(AVG(Quantity),2) AS avg_quantity_per_order
FROM retail_sales
GROUP BY Product_Category
ORDER BY avg_quantity_per_order DESC;


-- Average Spending by Gender and Age Group

SELECT 
    Gender,
    CASE
        WHEN Age BETWEEN 10 AND 20 THEN 'Teen'
        WHEN Age BETWEEN 21 AND 30 THEN 'Young Adult'
        WHEN Age BETWEEN 31 AND 45 THEN 'Adult'
        WHEN Age BETWEEN 46 AND 60 THEN 'Middle Age'
        ELSE 'Senior'
    END AS age_group,
    ROUND(AVG(Total_Amount),2) AS avg_spent
FROM retail_sales
GROUP BY Gender, age_group
ORDER BY Gender, avg_spent DESC;
