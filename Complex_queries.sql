use sql_store;
select * from products 
where unit_price>(
select unit_price from products where product_id=3 );
use sql_hr;
select * from employees where salary > (select avg(salary) from employees);
use sql_store;
select * from products where product_id not in (select Distinct(product_id) from order_items);
use sql_invoicing;
select * from clients where client_id not in (select distinct(client_id) from invoices);
use sql_store;
select customer_id, first_name, last_name from customers where customer_id in (select distinct(customer_id) from orders where order_id in (select order_id from order_items where product_id=3));
select distinct(c.customer_id), c.first_name, c.last_name from customers c inner join orders using (customer_id) 
inner join order_items oi using (order_id) where oi.product_id=3; 

use sql_invoicing;
select * from invoices where invoice_total>
(select max(invoice_total) from invoices where client_id=3);
-- using all
select * from invoices where invoice_total> all (
select invoice_total from invoices where client_id=3
);
-- using any 

select * from clients where client_id in (select client_id from invoices group by client_id
having count(*) >2);
select * from clients where client_id= any (select client_id from invoices group by client_id
having count(*) >2);

use sql_hr;
select * from employees;
select * from employees e where salary>
(
select avg(salary) from employees
where office_id=e.office_id 
);
use sql_invoicing;
select * from invoices i where invoice_total >
(
select avg(invoice_total) from invoices where invoices.client_id=i.client_id
);

-- exists 

select * from clients  c where exists
(
select client_id from invoices where client_id=c.client_id
);

use sql_store;

select * from products p where  not exists(select product_id from order_items oi where p.product_id=oi.product_id);

