update orders set city=null where order_id in ('CA-2020-161389','US-2021-156909');
select * from orders where city is null;

select category, sum(profit) as total_profit,max(order_date) as latest_order,min(order_date) as first_order from orders group by (category);
select sub_category from orders group by(sub_category) having avg(profit)>max(profit);
create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

select sub_category,sum(quantity) as total_quantity from orders where region="west" group by(sub_category) order by total_quantity desc limit 5;

select region,ship_mode,sum(sales)as total_sales from orders where order_date>='2020-01-01' group by region,ship_mode;

select * from returns;

select region, count(*) from orders o
inner join returns r on o.order_id=r.Order_id
group by region; 

select category, sum(sales) from orders o
left join returns r on o.order_id=r.Order_id where Return_reason is null
group by category;

select sub_category  from orders o
left join returns r on o.order_id=r.Order_id where Return_reason is not null
group by sub_category
having count(distinct(r.Return_reason))=3;

SELECT 
    city, SUM(sales)
FROM
    orders o
        LEFT JOIN
    returns r ON o.order_id = r.Order_id
GROUP BY city
HAVING COUNT(r.Order_id) = 0;



create table employee(
    emp_id int,
    emp_name varchar(20),
    dept_id int,
    salary int,
    manager_id int,
    emp_age int
);


insert into employee values(1,'Ankit',100,10000,4,39);
insert into employee values(2,'Mohit',100,15000,5,48);
insert into employee values(3,'Vikas',100,10000,4,37);
insert into employee values(4,'Rohit',100,5000,2,16);
insert into employee values(5,'Mudit',200,12000,6,55);
insert into employee values(6,'Agam',200,12000,2,14);
insert into employee values(7,'Sanjay',200,9000,2,13);
insert into employee values(8,'Ashish',200,5000,2,12);
insert into employee values(9,'Mukesh',300,6000,6,51);
insert into employee values(10,'Rakesh',500,7000,6,50);
select * from employee;

create table dept(
    dep_id int,
    dep_name varchar(20)
);
insert into dept values(100,'Analytics');
insert into dept values(200,'IT');
insert into dept values(300,'HR');
insert into dept values(400,'Text Analytics');
select * from dept;

select * from employee;


SELECT 
    emp1.emp_name AS employee_name,emp1.emp_age,
    emp2.emp_name AS manager_name,
    emp2.emp_age
FROM
    employee emp1
        INNER JOIN
    employee emp2 ON emp1.manager_id=emp2.emp_id
    where emp1.emp_age>emp2.emp_age;


select * from orders where city is null;
select * from returns;
select o.sub_category,count(1) from orders o left join returns r on o.order_id=r.order_id where Return_reason is null and month(order_date)=11 group by o.sub_category;

select order_id from orders group by (order_id) having count(order_id)=1;

SELECT 
   
    emp2.emp_name AS manager_name,group_concat(emp1.emp_name order by emp1.salary desc ,',')
FROM
    employee emp1
        INNER JOIN
    employee emp2 ON emp1.manager_id=emp2.emp_id
    group by (emp2.emp_name);

select * from orders where city is null;

select city, avg(datediff(ship_date,order_date)) as avg_days from orders where region='West' group by(city) order by avg_days desc limit 5;
drop table icc_world_cup;
create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');
select * from icc_world_cup;

select customer_name from orders;
select customer_name , trim(SUBSTRING(customer_name,1,CHARINDEX(' ',customer_name))) as first_name
, SUBSTRING(customer_name,CHARINDEX(' ',customer_name)+1,len(customer_name)-CHARINDEX(' ',customer_name)+1) as second_name
from orders;


create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');
select * from drivers;

select * from icc_world_cup;


select team_name,count(*) as matches_played, sum(win_flag) as matches_won, count(team_name)-sum(win_flag) as lost_matches from 
(select Team_1 as team_name, case when Winner=Team_1 then 1 else 0 end as win_flag
 from icc_world_cup
union all
select Team_2 as team_name, case when Winner=Team_2 then 1 else 0 end as win_flag
from icc_world_cup) A
group by (team_name);



select * from orders;

select avg(total_sales) from (select sum(sales) as total_sales from orders group by (order_id)) A;




select customer_name from orders group by (customer_name) having count(1) >
(select avg(orders_total) from (select count(1) as orders_total from orders group by (customer_name))A);


select * from employee;



select emp.emp_name,emp.salary,B.avg_salary from employee emp inner join  (select dept_id, avg(salary) as avg_salary from employee group by (dept_id)) B
on emp.dept_id=B.dept_id
where emp.salary>B.avg_salary;


select * from employee where emp_age > (select avg(emp_age) from employee);

select emp.* from employee emp inner join (select dept_id,max(salary) as max_salary from employee group by dept_id) B
on emp.dept_id=B.dept_id
where emp.salary=B.max_salary;

select *, row_number() over (order by salary asc) as rn
from employee;
select * from 
(select *, row_number() over (partition by dept_id order by salary asc) as rn
from employee) B where B.rn in (1,2);
select * from orders;




with cat_sales as(
select category,product_id, sum(sales) as category_sales from orders group by category,product_id
),
rnk_sales as (
select *,rank() over (partition by category order by category_sales desc) as rn from cat_sales) 
select * from rnk_sales where rn<=3
;
-- row_number() over(partition by product_name,category order by sum(sales) desc ) from orders;




select * from employee;
select *, dense_rank() over(partition by dept_id order by salary desc , emp_age asc ) as rn from employee;

select * from orders;
with region_sales as (
select region,product_id,sum(sales) as sales from orders group by region,product_id),
rnk as(select *, rank() over (partition by region order by sales desc ) as drnk, rank() over (partition by region order by sales asc ) as arnk
from region_sales)
select region,product_id, sales,
case when drnk<=3 then 'Top-3' else 'Bottom-3' END as Top_Bottom
 from rnk where drnk<=3 or arnk<=3;
 



select sub_category, format(order_date,'yyyyMM') as month_year ,sum(sales) from orders group by sub_category,format(order_date,'yyyyMM') ;
select sub_category,order_date,lag(sales) over(partition by  sub_category order by format(order_date,'yyyyMM')) from orders;


select *,avg(salary) over(partition by dept_id) as avg_salary, count((salary)) over(partition by dept_id) as count_max  from employee;

select * from orders;
select *, sum(sales),rank()  over(partition by sub_category order by sum(sales)) as rnk from orders ;

