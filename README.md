# 🛒 Retail Sales Analysis Using SQL

## 📌 Project Overview

This project demonstrates SQL-based data analysis on a retail sales dataset using MySQL.

The objective is to answer common business questions through SQL queries and extract meaningful insights from sales transactions. The project covers data exploration, customer analysis, category performance, monthly sales trends, top customers, and sales shift analysis.

---

## 📂 Dataset

**Table:** `retail_sales`

The dataset contains retail transaction records with information such as:

- Transaction ID
- Sale Date
- Sale Time
- Customer ID
- Gender
- Age
- Category
- Quantity
- Price per Unit
- Cost of Goods Sold (COGS)
- Total Sale

---

## 🛠 Tools Used

- MySQL
- SQL
- MySQL Workbench

---

# Data Exploration

## 1. Total Number of Orders

Determine how many transactions exist in the dataset.

```sql
SELECT COUNT(transactions_id) AS Total_order
FROM retail_sales;
```

---

## 2. Total Number of Customers

Find the total number of unique customers.

```sql
SELECT COUNT(DISTINCT customer_id) AS Total_customer
FROM retail_sales;
```

---

# Business Questions & SQL Solutions

## Q1. Find all sales made on 25-Feb-2023

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2023-02-25';
```

---

## Q2. Find all Electronics transactions where quantity sold is greater than 2 during November 2023

```sql
SELECT *
FROM retail_sales
WHERE category = 'Electronics'
AND quantity > 2
AND sale_date >= '2023-11-01'
AND sale_date <= '2023-11-30';
```

---

## Q3. Calculate total sales for each product category

```sql
SELECT
    category,
    SUM(total_sale) AS Total_sales,
    COUNT(*) AS Total_orders
FROM retail_sales
GROUP BY category;
```

---

## Q4. Find the average age of customers who purchased Clothing

```sql
SELECT
    ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category='Clothing';
```

---

## Q5. Find all transactions where total sales exceeded 1500

```sql
SELECT *
FROM retail_sales
WHERE total_sale >=1500;
```

---

## Q6. Count total orders by gender within each category

```sql
SELECT
    category,
    gender,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

---

## Q7. Calculate the average monthly sales and identify the best-selling month of each year

### Average Monthly Sales

```sql
SELECT
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    MONTHNAME(sale_date) AS month_name,
    ROUND(AVG(total_sale),2) AS avg_sales
FROM retail_sales
GROUP BY
    YEAR(sale_date),
    MONTH(sale_date),
    MONTHNAME(sale_date)
ORDER BY
    year,
    month;
```

### Best Selling Month Each Year

```sql
WITH monthly_sales AS (

SELECT
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    MONTHNAME(sale_date) AS month_name,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY
    YEAR(sale_date),
    MONTH(sale_date),
    MONTHNAME(sale_date)

),

ranked_sales AS (

SELECT *,
RANK() OVER(
PARTITION BY year
ORDER BY total_sales DESC
) AS rnk
FROM monthly_sales

)

SELECT
    year,
    month_name,
    total_sales
FROM ranked_sales
WHERE rnk = 1;
```

---

## Q8. Find the Top 5 customers based on total sales

```sql
SELECT
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

---

## Q9. Count unique customers in each category

```sql
SELECT
    category,
    COUNT(DISTINCT customer_id) AS total_customer
FROM retail_sales
GROUP BY category;
```

---

## Q10. Categorize orders into Morning, Afternoon and Evening shifts

```sql
SELECT

CASE
WHEN sale_time < '12:00:00' THEN 'Morning'
WHEN sale_time <= '17:00:00' THEN 'Afternoon'
ELSE 'Evening'
END AS shift,

COUNT(*) AS total_orders

FROM retail_sales

GROUP BY shift

ORDER BY

CASE shift
WHEN 'Morning' THEN 1
WHEN 'Afternoon' THEN 2
WHEN 'Evening' THEN 3
END;
```

---

# Key SQL Concepts Used

- SELECT
- WHERE
- GROUP BY
- ORDER BY
- COUNT()
- SUM()
- AVG()
- ROUND()
- DISTINCT
- Aggregate Functions
- Common Table Expressions (CTEs)
- Window Functions (`RANK()`)
- CASE Statements
- Date Functions
- Filtering
- Sorting

---

# Business Insights

This project demonstrates how SQL can be used to answer real business questions such as:

- Customer purchasing behavior
- Category-wise sales performance
- Monthly sales trends
- Best-performing months
- High-value transactions
- Customer segmentation
- Sales by gender
- Top spending customers
- Category popularity
- Order distribution across different times of the day

---

# Project Structure

```
Retail-Sales-SQL-Project/
│
├── retail_sales_analysis.sql
├── README.md
└── dataset/
    └── retail_sales.csv
```

---

# Learning Outcomes

Through this project, I practiced:

- SQL Data Exploration
- Business Problem Solving with SQL
- Aggregate Functions
- Window Functions
- Common Table Expressions (CTEs)
- Date & Time Analysis
- Customer Analytics
- Sales Performance Analysis

---

## Author

**Adnan Bin Abdul Khaleque**

---

⭐ If you found this project helpful, consider giving it a star.
