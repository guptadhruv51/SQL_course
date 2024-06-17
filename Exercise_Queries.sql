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
Select o.order_id, c.first_name,c.last_name,o.customer_id from orders o
  join customers c on o.customer_id=c.customer_id;
Select order_id,o.product_id,p.name,o.unit_price,o.quantity from order_items o 
join products p on o.product_id=p.product_id;
use sql_hr;
select * from employees;

select e1.employee_id,e1.first_name,e2.first_name as manager_name from employees e1 
join employees e2 on e1.reports_to=e2.employee_id;
use sql_store;

select o1.order_id,c1.first_name,c1.last_name,o1.order_date,o2.name as status from  ((orders o1 join order_statuses o2 on o1.status=o2.order_status_id)
inner join customers c1 on o1.customer_id=c1.customer_id) order by c1.first_name;

use sql_invoicing;
select clients.name,address,payment_methods.name as payment_method,payments.date,payments.invoice_id,payments.amount from payments join 
clients on payments.client_id=clients.client_id join 
payment_methods on payment_methods.payment_method_id=payments.payment_id;

use sql_store;
select c.customer_id,
c.first_name,
o.order_id from customers c
left Join orders o on c.customer_id=o.customer_id
order by c.customer_id; 

select p.product_id,p.name,o1.quantity from products p left join order_items o1 
on p.product_id=o1.product_id;
select o.order_id,
c.first_name  from orders o
join customers c using(customer_id);

use sql_invoicing;
select p.date,
c.name as client,
p.amount,
pm.name as method
from payments p join 
clients c using (client_id)
join payment_methods pm
on p.payment_method=pm.payment_method_id;

