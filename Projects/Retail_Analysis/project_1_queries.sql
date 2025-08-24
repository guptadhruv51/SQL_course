use sql_projects;
SELECT transactions_id, COUNT(*) 
FROM `sql_projects`.`SQL`
GROUP BY transactions_id
HAVING COUNT(*) > 1;
select * from Retail_transactions limit 100;
select count(*) from Retail_transactions;
select * from Retail_transactions where transactions_id is null;
select * from Retail_transactions where sale_date is null;
select * from Retail_transactions where sale_time is null;
select * from Retail_transactions where customer_id is null;
select * from Retail_transactions where gender is null;
select * from Retail_transactions where age is null;
select * from Retail_transactions where category is null;
select * from Retail_transactions where quantiy is null;
select * from Retail_transactions where price_per_unit is null;
select * from Retail_transactions where cogs is null;
select * from Retail_transactions where total_sale is null;

select * from Retail_transactions where transactions_id is null
or
sale_date is null 
or 
sale_time is null
or
customer_id is null
or 
gender is null
or
age is null
or 
category is null
or
quantiy is null
or
price_per_unit is null
or cogs is null
or total_sale is null;


delete from Retail_transactions where transactions_id is null
or
sale_date is null 
or 
sale_time is null
or
customer_id is null
or 
gender is null
or
age is null
or 
category is null
or
quantiy is null
or
price_per_unit is null
or cogs is null
or total_sale is null;
select * from Retail_transactions where transactions_id is null
or
sale_date is null 
or 
sale_time is null
or
customer_id is null
or 
gender is null
or
age is null
or 
category is null
or
quantiy is null
or
price_per_unit is null
or cogs is null
or total_sale is null;

-- Data Exploration
select count(*) from Retail_transactions;

-- unique customers
select count(distinct customer_id) from Retail_transactions;

-- 
select count(distinct category) from Retail_transactions;

select distinct category from Retail_transactions;

-- Data Analysis & Business Key Problems & answers

select * from Retail_transactions where sale_date = "2022-11-05";


select *  from Retail_transactions where category='Clothing' and DATE_FORMAT(sale_date, '%Y-%m') = '2022-11' having quantiy>=4;

select * from Retail_transactions where category='Clothing' and quantity=10 and month(sale_date)='';


select category, sum(total_sale),count(*) as total_sales from Retail_transactions group by category;

select avg(age) from Retail_transactions where category='Beauty';

select * from Retail_transactions where total_sale>1000;

select category,gender,count(transactions_id)  as no_transactions from Retail_transactions group by category,gender; 

with cte as (SELECT 
    
    year(sale_date) as year,
    MONTH(sale_date) AS sale_month,
    round(avg(total_sale),2) as average_sale,
    rank() over(partition by year(sale_date) order by round(avg(total_sale),2) desc) as rn
FROM Retail_transactions
group by 1,2
order by 1,3 desc)
select * from cte where rn=1;



select customer_id,sum(total_sale) as sum_sales from Retail_transactions group by customer_id order by sum(total_sale) limit 5;

select count(distinct customer_id),category from Retail_transactions group by category;


with cte2 as (select *, 
case 
when hour(sale_time)<12 then 'Morning'
when hour(sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as Shift
from Retail_transactions)
select count(*),Shift as number_of_orders from cte2 group by Shift; 

-- End of Project 
