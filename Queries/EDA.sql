-- Data Exploration

# How many orders the store have?

select count(transactions_id) as Total_order 
from retail_sales;

# How many Customer the store have?

select count(distinct customer_id) as Total_customer
from retail_sales;


-- Business Questions & Answer for Data Analysis

# Q1. Find the sales report made on 2023-02-25?

select * from retail_sales
where sale_date = '2023-02-25';

# Q2. Find all the transactions where the category is 'Electronics' and the quantity sold is more than 2 in the month of Nov-2023?

SELECT *
FROM retail_sales
WHERE category = 'Electronics'
  AND quantity > 2
  AND sale_date >= '2023-11-01'
  AND sale_date <= '2023-11-30';
  
# Q3. Find Total sales for each category:
  
select category, sum(total_sale) as Total_sales, count(*) as Total_orders
from retail_sales
group by category;
  
# Q4. Find the average age of customers who purchased items from the 'Clothing' category:
  
SELECT ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Clothing';


# Q5. Find all transactions where the total_sale is greater than 1500:

SELECT * FROM retail_sales
WHERE total_sale >= 1500;

# Q6. Find the total number of orders made by each gender in each category:

SELECT 
    category,
    gender,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 
    category,
    gender
ORDER BY 1;

# Q7. Calculate the average sale for each month. Find out best selling month in each year:

SELECT
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    MONTHNAME(sale_date) AS month_name,
    ROUND(AVG(total_sale), 2) AS avg_sales
FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date), MONTHNAME(sale_date)
ORDER BY year, month;

# highest month
WITH monthly_sales AS (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        MONTHNAME(sale_date) AS month_name,
        SUM(total_sale) AS total_sales
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date), MONTHNAME(sale_date)
),
ranked_sales AS (
    SELECT *,
           RANK() OVER (
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


# Q8.  Find the top 5 customers based on the highest total sales:

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


# Q9. Find the number of customers who purchased items from each category:

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as total_customer
FROM retail_sales
GROUP BY category;


# Q10. categorize orders into Morning, Afternoon, and Evening shifts based on the order time, and return the total number of orders in each shift:

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