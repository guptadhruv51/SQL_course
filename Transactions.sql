use sql_store;
start transaction;
insert into orders (customer_id,order_date, status) values(1,'2019-01-01',1);
insert into order_items
values(last_insert_id(),1,1,1);
commit;

-- concurrency and locking (default locking from sql)
use sql_store;
start transaction;
update customers 
set points=points+10
where customer_id=1;
commit; 
-- problems with concurrency
-- Lost updates
-- Dirty reads
-- Non repeating reads
-- Phantom reads

/*
Transaction isolation levels
read uncommitted: Doesn't really do anything, because the transactions can see each others uncommitted data.
read committed: Prevents dirty read
repeatable read: Prevents lost updates, dirty reads, non repeating reads (default in sql)
serializable: repeatable reads+ phantom reads
*/
show variables like 'transaction_isolation';
set session transaction isolation level serializable;
set transaction isolation level read uncommitted;