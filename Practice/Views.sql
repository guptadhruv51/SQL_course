use sql_invoicing;

create view  client_balance as 
Select c.client_id,c.name,
sum(invoice_total- payment_total) as balance
from clients c 
join invoices i using (client_id)
group by client_id,name ;
select * from client_balance;

drop view client_balance;
create  or replace view client_balance as 
Select c.client_id,c.name,
sum(invoice_total- payment_total) as balance
from clients c 
join invoices i using (client_id)
group by client_id,name ;
select * from client_balance;


-- with check option : prevents update or select statements to exclude rows from views
create or replace view invoice_balance as 
select invoice_id,number,
client_id, invoice_total,
payment_total, invoice_total-payment_total as balance,
invoice_date,due_date,payment_date
from invoices where (invoice_total-payment_total)>0 
with check option ;
