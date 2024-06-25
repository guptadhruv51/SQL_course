use sql_invoicing;

delimiter $$
Create Procedure get_clients()
begin
select * from clients; 
end $$
delimiter ;
call get_clients();

delimiter $$
create  procedure  get_invoices() 
begin
select * from invoices 
where invoice_total-payment_total>0;
end $$
delimiter ;
call get_invoices();

-- dropping aprocedure  drop procedure get_clients;
drop procedure if exists get_clients_by_state;

delimiter $$
create procedure get_client_by_state(state varchar(2)) 
begin 
select * from clients c
where c.state=state;
end $$
 
 delimiter ;
call get_client_by_state('CA');

delimiter $$
create procedure get_invoices_by_client(id int(11))
begin
select * from invoices where client_id=id;
end $$

delimiter ;
call get_invoices_by_client(1);


-- default parameters 
drop procedure if exists get_client_by_state;

delimiter $$
create procedure get_client_by_state(state varchar(2)) 
begin 
if state is null then 
set state='CA';
end if;
select * from clients c
where c.state=state;
end $$

delimiter ;
drop procedure if exists get_client_by_state;

delimiter $$
create procedure get_client_by_state(state varchar(2)) 
begin 
if state is null then 
select * from clients;
else
select * from clients c
where c.state=state;
end if;
end $$


delimiter ;
drop procedure if exists get_client_by_state;

delimiter $$
create procedure get_client_by_state(state varchar(2)) 
begin 

select * from clients c where c.state=ifnull(state,c.state);

end $$


create procedure get_payments(
client_id INT,
payment_method_id TINYINT
)
Begin
select * from payments p where
p.client_id=ifnull(client_id,p.client_id)
and
p.payment_method=ifnull(payment_method_id,p.payment_method); 
end $$

-- parameter validation 
delimiter ;
drop procedure if exists make_payment;
delimiter $$
create procedure make_payment
(
invoice_id INT,
payment_amount Decimal(9,2),
payment_date date
)

begin 
if payment_amount<=0
then
signal SQLSTATE '22003' set message_text='Invalid payment amount';
end if;
update invoices i set
i.payment_total=payment_amount,
i.payment_date=payment_date
where i.invoice_id=invoice_id;
end $$



-- output parameters 
create procedure unpaid_invoices
(
client_id int,
out invoices_count int,
out invoices_total decimal(9,2)
)
begin 
select count(*), sum(invoice_total)
into invoices_count, invoices_total
from invoices i 
where i.client_id=client_id
and payment_total=0;
end $$
delimiter ;
-- user or session variables 
set @invoice_count=0;
delimiter $$
drop procedure if exists get_risk_factor $$
create procedure get_risk_factor()
begin
declare risk_factor decimal(9,2) default 0;
declare invoice_total decimal (9,2);
declare invoices_count int;
select count(*),
sum(invoice_total)
into invoices_count, invoice_total
from invoices;
set risk_factor=invoice_total/invoices_count*5;
select risk_factor;
end $$


call get_risk_factor();

delimiter ;



-- functions: will return single value unlike stored procedure





