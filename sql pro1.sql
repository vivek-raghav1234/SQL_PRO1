create database SQL_project_p1;

create table retail_sales 
(
   transactions_id INT PRIMARY KEY,
   sale_date DATE,
   sale_time TIME,
   customer_id INT,
   gender VARCHAR(15),
   age    INT,
   category VARCHAR(15),
   quantiy INT,
   price_per_unit FLOAT,
   cogs FLOAT,
   total_sale FLOAT
);

SELECT * FROM retail_sales
limit 10

 SELECT COUNT(*) FROM retail_sales

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
where 
      transactions_id is null
	  OR
	  sale_date is null
	  OR 
	  sale_time is null
	  OR
	  customer_id is null
	  OR
	  gender is null
	  OR
	  age is null
	  OR
	  category is null
	  OR
	  quantiy is null
	  OR
	  price_per_unit is null
	  OR 
	  cogs is null
	  or
	  total_sale is null;


DELETE from retail_sales
where 
      transactions_id is null
	  OR
	  sale_date is null
	  OR 
	  sale_time is null
	  OR
	  customer_id is null
	  OR
	  gender is null
	  OR
	  age is null
	  OR
	  category is null
	  OR
	  quantiy is null
	  OR
	  price_per_unit is null
	  OR 
	  cogs is null
	  or
	  total_sale is null;
-- data expolaration 
--how many sales we have?
select count(*) as total_sale from retail_sales

-- how many UNIQUE customer we have ??

select count(DISTINCT customer_id) as total_sale from retail_sales
 

select DISTINCT category  from retail_sales


--DATA ANALSYS KEY PROBLENS
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

	  
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05	  


SELECT * 
FROM retail_sales 
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
 
SELECT * 
FROM retail_sales 
WHERE category = 'Clothing' 
AND quantiy >=4 
AND to_char(sale_date,'YYYY-MM') = '2022-11'

-- another answer

SELECT * 
FROM retail_sales 
WHERE category = 'Clothing' 
AND quantiy >= 4 
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
 ROUND (AVG(age),2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT 
  *
FROM
  retail_sales
where 
 total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

 SELECT gender, category, COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY gender, category
ORDER BY gender, category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT
EXTRACT (YEAR FROM sale_date) as year,
EXTRACT (MONTH FROM sale_date) as month,
AVG(total_sale)  as avg_sale
FROM retail_sales
group by 1,2
order by 1,3 desc

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category
ORDER BY unique_customers DESC;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT 
    CASE 
        WHEN sale_time <= '12:00:00' THEN 'Morning'
        WHEN sale_time > '12:00:00' AND sale_time <= '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(transactions_id) AS number_of_orders
FROM retail_sales
GROUP BY shift
ORDER BY number_of_orders DESC;

-- END PROJECT
