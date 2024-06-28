-- Triggers 
use sql_invoicing;
delimiter $$
drop trigger if exists payments_after_insert;
create trigger payments_after_insert 
after insert on payments 
for each row 
begin 
		update invoices set payment_total=payment_total+new.amount
        where invoice_id=new.invoice_id;
end$$
delimiter ;

delimiter $$
drop trigger if exists payments_after_delete;
create trigger payments_after_delete
after delete on payments
for each row
begin 
update invoice set payment_totaal=payment_total-old.amount
where invoice_id=old.invoice_id;
end $$
delimiter ;
-- viewing triggers
show triggers;
-- dropping 
-- triggers for auditing 
delimiter $$
drop trigger if exists payments_after_insert;
create trigger payments_after_insert 
after insert on payments 
for each row 
begin 
		update invoices set payment_total=payment_total+new.amount
        where invoice_id=new.invoice_id;
        insert into payments_audit values(new.client_id,new.date,new.amount,'Insert',NOW());
end$$
delimiter ;
delimiter $$
drop trigger if exists payments_after_delete;
create trigger payments_after_delete
after delete on payments
for each row
begin 
update invoice set payment_totaal=payment_total-old.amount
where invoice_id=old.invoice_id;
insert into payments_audit values(old.client_id,old.date,old.amount,'Delete',NOW());
end $$
delimiter ;


-- Events 
-- automation of database related tasks

show variables like 'event%';
set global event_scheduler=on;

delimiter $$
drop event if exists yearly_delete_stale_audit_rows $$
create event yearly_delete_stale_audit_rows
on schedule 
every 1 year starts '2019-01-01' ends '2029-01-01'
Do begin
	delete from payments_audit where 
    action_date< NOW() - Interval 1 Year;
end $$
delimiter ;
show events;
alter event yearly_delete_stale_audit_rows disable;
-- Or enable
