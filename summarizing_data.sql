use sql_invoicing;
Select Max(invoice_total) as highest,
 min(invoice_total), avg(invoice_total),
 sum(invoice_total)from invoices;
 
 (Select 'First half of 2019' as date_range,
 Sum(invoice_total) as total_sales,
 sum(payment_total) as total_payment,
 sum(invoice_total-payment_total) as what_we_expect
 from invoices where invoice_date between '2019-01-01' and '2019-06-30')
 Union
 (Select 'second half of 2019' as date_range,
 Sum(invoice_total) as total_sales,
 sum(payment_total) as total_payment,
 sum(invoice_total-payment_total) as what_we_expect
 from invoices where invoice_date between '2019-07-01' and '2019-12-31')
 union 
 (Select 'total' as date_range,
 Sum(invoice_total) as total_sales,
 sum(payment_total) as total_payment,
 sum(invoice_total-payment_total) as what_we_expect
 from invoices where invoice_date between '2019-01-01' and '2019-12-31');
 
 Select client_id,sum(invoice_total) as total_sales
 from invoices 
 group by client_id having client_id in (1,2,3);
 
  Select state,city,sum(invoice_total) as total_sales
 from invoices i join clients using (client_id)
 group by state, city ;
 
 select date, name, sum(amount)
 from payments p join payment_methods pi
 on p.payment_method=pi.payment_method_id
 group by date,name order by date;
 
use sql_store;
select c.customer_id,
c.first_name,c.last_name,
sum(oi.quantity*oi.unit_price) as total_sales from customers c
join orders o using (customer_id) join order_items oi
using (order_id) 
where lower(state)='va'
group by c.customer_id, c.first_name,c.last_name
having total_sales>100; 

use sql_invoicing;
select state,city, sum(invoice_total) as total_sales
from invoices i  join clients c 
group by state,city 
with rollup;

select pi.name as payment_method, sum(p.amount)
from payment_methods pi join payments p 
on pi.payment_method_id=p.payment_method
group by pi.name 
with rollup;

 
