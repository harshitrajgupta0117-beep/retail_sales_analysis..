--create table
create table Retail_sales
     (
      transactions_id INT PRIMARY KEY,	
	  sale_date	DATE,
	  sale_time	TIME,
	  customer_id INT,	
	  gender VARCHAR(15),
	  age INT,
	  category	VARCHAR(15),
	  quantiy  INT,
	  price_per_unit  FLOAT, 
	  cogs FLOAT,	
	  total_sale FLOAT
      );

	  SELECT * FROM retail_sales

	  select count(*) from retail_sales

	  select * from retail_sales
	  where transactions_id is null
	  
	  
	  select * from retail_sales
	  where sale_time is null

	  SELECT * FROM retail_sales
    WHERE 
    sale_date IS NULL OR 
	sale_time IS NULL OR 
	customer_id IS NULL OR 
    gender IS NULL OR
	age IS NULL OR 
	category IS NULL OR 
    quantiy IS NULL OR
	price_per_unit IS NULL OR
	cogs IS NULL;

    Delete from retail_sales
    WHERE 
    sale_date IS NULL OR
	sale_time IS NULL OR
	customer_id IS NULL OR
    gender IS NULL OR
	age IS NULL OR 
	category IS NULL OR 
    quantiy IS NULL OR
	price_per_unit IS NULL OR
	cogs IS NULL;

  select * from retail_sales

-- 3. Data Analysis & Findings
  The following SQL queries were developed to answer specific business questions:
  
--1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
      SELECT * FROM retail_sales
	  where sale_date = '2022-11-05'

2. --Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:	  
    SELECT * FROM retail_sales
	WHERE Category = 'Clothing' AND
	To_CHAR (sale_date, 'YYYY-MM') = '2022-11'
    AND 
	quantiy  >= 4

3. --Write a SQL query to calculate the total sales (total_sale) for each category.**:
    select transactions_id,  category ,sum(total_sale) as net_sales, count(*) as total_orders from retail_sales
	 group by 1

4. --Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
     
     select round(avg(age),2) as avg_age from retail_sales
	 group by category = 'Beauty'

5.--Write a SQL query to find all transactions where the total_sale is greater than 1000.**:	 
    select * from retail_sales
	where total_sale > 1000

6.--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:	
	 select category, gender, count(*) as total_trans
	 from retail_sales
	 group by category , gender
	 order by 1

7.--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:	 
     select year,month avg_sale 
	 from 
	 (
	 select 
	      extract(year from sale_date) as year,
		  extract(month from sale_date) as month,
		  avg(total_sale) as avg_total_sale,
		  rank() over(partition by extract(year from sale_date)order by avg(total_sale) desc) as rank
		from retail_sales
		group by 1,2
		) as t1
		where rank = 1 
		
8.--Write a SQL query to find the top 5 customers based on the highest total sales **:		
     select customer_id, 
	         sum(total_sale) as total_sales
	 from retail_sales
	 group by 1
	 order by 2 desc
	 limit 5

9.--Write a SQL query to find the number of unique customers who purchased items from each category.**:	 
   select category, count(distinct customer_id) as qunique_customers from retail_sales
   group by category

10. --Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
     with hourly_sale
	 as
	 (
	 select *, 
	 case
	 when extract(HOUR FROM sale_time) < 12 then 'Morning'
	 when extract (HOURS FROM sale_time) between 12 and 17  then  'Afternoon'
	 else 'evening'
end as shift 
	 from retail_sales
	)
	select
	count(*) as total_orders
	from hourly_sale
	group by shift 

-- end of project
