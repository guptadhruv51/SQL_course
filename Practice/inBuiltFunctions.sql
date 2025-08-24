select round(5.73);
select truncate (5.7456,2);
select ceiling(5.4555);
select floor(5.99);
select abs(-5.3);
select rand();
-- String
select length('Sky');
select upper("sky");
select lower("SKY");
select ltrim(" Sky");
select rtrim("Sky  ");
select trim(" Sky. ");
select left("avdbfbujefn",2);
select right("wbbfe",2);
select substring("heuwenzu",2,3);
select locate("n","bhjbjnbh3b3");
Select Now(),curdate(),curtime();
select year(now());
select month(now());
select dayname(now());
select extract(day from now());
select date_format(now(),'%d/%m/%y');
select time_format(now(),'%H:%i%p');

use sql_store;
select order_id,ifnull(shipper_id,'Not assigned') as shipper from orders;

-- coalesce
select order_id,coalesce(shipper_id,comments,'Not assigned') as shipper from orders;

select concat(first_name," ",last_name), ifnull(phone,'Unknown') as phone from customers;

-- if without using union 
select order_id, order_date ,
if(year(order_date)='2019','Active',
'Archive') as category
from orders ;
select p.product_id, p.name,count(p.product_id), if(count(p.product_id)>1,"Many Times",'Once') as frequency from products p join  order_items using(product_id) group by (product_id);



-- Case
Select concat(first_name," ",last_name) , points, 
case
when points>=3000 then "Gold"
When points>=2000 and points<3000 then "Silver"
else "Bronze"
end as category
from customers order by points desc;




