-- DDL Exercises
use sql_store;
Insert into customers values 
(Default,"Dhruv","Gupta",NULL,Null,"51/101, Hennesey Street","Canberr","AC",default);
Select* from customers;
Insert into customers 
(first_name,last_name,birth_date,address,city,state)
values ("ABC","XYZ","1990-01-01","K-3/10, Model Town-2","Delhi","ND");
Select* from customers;
Insert into shippers (name) values ("Shipper1"),("Shipper2"),("Shipper3");
Select * from shippers;
Insert into products (name,quantity_in_stock,unit_price) values ("Product2",100,2.55),("Product 3",120,2.65);
Select * from products;
Insert into orders (customer_id,order_date,status) values (1,'2019-01-02',1);
Insert into order_items values(last_insert_id(),1,1,2.95),
(last_insert_id(),2,1,2.95);
-- Select last_insert_id();
select * from order_items;

create table orders_archive as 
select * from orders;
-- mysql ignores th primary key and autoincrement constraints 

Select * from orders where order_date <'2019-01-01';
Insert into orders_archive 
Select * from orders where order_date <'2019-01-01';

use sql_invoicing;

create table invoices_archived as 
select i.invoice_id,i.invoice_total, i.payment_total, c.name 
from invoices i inner join clients c on i.client_id=c.client_id where i.payment_date is not null;
select * from invoices_archived;

select * from invoices;
update invoices 
set payment_total=10, payment_date='2024-06-14'
where invoice_id=1;
select * from invoices;
update invoices 
set payment_total=invoice_total*0.5,
payment_date=due_date
where client_id=3