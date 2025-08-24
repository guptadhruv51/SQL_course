use sql_course;
CREATE TABLE employee_backup AS
SELECT * FROM employee;
CREATE TABLE dept_backup AS
SELECT * FROM dept;
select * from employee;
update employee set salary=salary*1.1 where dept_id in (select dep_id from dept where dep_name="HR");

alter table employee add dep_name varchar(20);

-- update employee set dep_name=d.dep_name
-- from employee e 
-- inner join dept d 
-- on e.dept_id=d.dep_id;
UPDATE employee e
JOIN dept d ON e.dept_id = d.dep_id
SET e.dep_name = d.dep_name;

delete e
from employee e 
inner join dept d on e.dept_id=d.dept_id
where d.dep_name='HR';


-- exists/ not exists

-- checks for every value in employee table so makes it a bit slower 
select * from employee_backup e
where exists
(select 1 from dept_backup d where e.dept_id=d.dep_id); 




-- ddl: data definition langauge create, drop, alter
-- dml: insert, update, delete
-- dql: select
-- dcl: control language -- grant, revoke 
create role role_sales;
grant select on employee to role_sales;

create table emp_index
(
emp_id int primary key ,
emp_name varchar(20),
salary int
);

insert into emp_index values(1,'Ankit',10000)
,(3,'rahul',10000),(2,'manish',10000),(4,'pushkar',10000);

select * from emp_index;

create  index idx_name on emp_index(emp_name desc) ;

-- execute sp_helpindex emp_index;

select max(rn) from orders_index;
drop index idx_rn on orders_index;

select * from orders_index where rn=100;

select  row_number() over(order by a.row_id) as rn, a.* into orders_index 
from orders a, (select top 100 * from orders) b ;

select rn,customer_id from orders_index where rn=100;


CREATE INDEX idx_rn ON orders_index(rn, customer_id);

create  index idx_cust on orders_index(customer_id asc,customer_name desc) ;

create index idx_cust_sales on orders_index(customer_id asc,sales asc) ;

-- name like 'Ank%'

select  customer_id,customer_name from orders_index 
where customer_id like 'DB%' and sales > 100;

create table emp_dup1
(
emp_id int,
emp_name varchar(20)
);
insert into emp_dup
values(1,'Ankit',getdate());

select * from emp_dup;

delete emp_dup 
from emp_dup e
LEFT join (select emp_id,max(create_time) as create_time  from emp_dup group by emp_id ) d
on e.emp_id=d.emp_id and e.create_time=d.create_time
where d.emp_id is null
;

select distinct * into emp_dup1_back  from emp_dup1;

select * from emp_dup1
_back;

truncate table emp_dup1;

insert into emp_dup1 select * from emp_dup1_back;

select * from emp_dup;






























