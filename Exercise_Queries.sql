-- Excercises
use sql_store;

Select name,unit_price, unit_price*1.1 as 'new Price' from products;
select * from orders where order_date>='2019-01-01';
Select * from order_items where order_id=6 and unit_price*quantity>30;
Select * from customers where birth_date between '1990-01-01' and '2000-01-01';
Select * from customers where lower(address) like '%trail%' or
lower(address) like '%avenue%';
Select * from customers where phone like '%9';
Select * from customers where last_name regexp 'field$|mac';
Select * from customers where lower(first_name) regexp 'elka|ambur';
select * from customers where lower(last_name) regexp 'ey$|on$';
select * from customers where lower(last_name) regexp '^my|se';
select * from customers where lower(last_name) regexp 'b[ru]';
select order_id, product_id, quantity,unit_price from order_items where order_id=2 order by quantity*unit_price Desc;
Select * from customers order by points desc limit 3;