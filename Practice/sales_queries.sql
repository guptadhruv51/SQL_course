create database Sales_Data;
use Sales_Data;
select * from sales_data_sample;

select PRODUCTCODE,
 sum(sales) as total_revenue
 from sales_data_sample
 group by (PRODUCTCODE)
 order by sum(sales) desc;
 
 select YEAR_ID,
 MONTH_ID,
 sum(sales) as monthly_revenue from 
 sales_data_sample
 group by YEAR_ID,MONTH_ID
 order by YEAR_ID,MONTH_ID;
 
 select customername, sum(sales) as total_spending
 from sales_data_sample
 group by customername
 order by total_spending
 desc;
 
 
  