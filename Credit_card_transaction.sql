SELECT * FROM sql_course.Credit_card_transactions;
use sql_course;
select str_to_date(Date,'%d-%b-%y') from Credit_card_transactions;
alter table Credit_card_transactions add column new_date Date;

update Credit_card_transactions set new_date=str_to_date(Date,'%d-%b-%y');
alter table Credit_card_transactions drop column Date;
alter table Credit_card_transactions change column new_date Date Date ;
select min(Date),max(Date) from Credit_card_transactions;
select distinct card_type from Credit_card_transactions;
select distinct exp_type from Credit_card_transactions;

select exp_type, sum(amount) as total_expense from credit_card_transactions
group by exp_type
order by sum(amount);

-- 1- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends
with cte1 as 
(
select City, sum(Amount) as total_spend from Credit_card_transactions 
group by City
),
total_amount as (select sum(cast(amount as unsigned)) as total_spent from Credit_card_transactions)

select  cte1.*,(total_spend/total_spent)*100 as percentage from cte1,total_amount order by total_spend desc limit 5;

-- 2- write a query to print highest spend month and amount spent in that month for each card type
with cte2 as (
select card_type,year(date) as yt,month(date) as mt, sum(Amount) as total_spend from Credit_card_transactions 
group by card_type,year(date) ,month(date)
order by card_type,total_spend desc)
select * from (
select *, rank() over (partition by card_type order by total_spend desc) as rn from cte2) a
where rn=1
;


-- 3- write a query to print the transaction details(all columns from the table) for each card type when
-- it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)
with cte3 as (select *, sum(amount) over(partition by card_type order by date,transaction_id ) as total_spend
from Credit_card_transactions
order by card_type)
select * from 
(select *,rank()  over(partition by card_type order by total_spend asc) as rn from cte3 where total_spend>=1000000) a
where rn=1
;
-- 4- write a query to find city which had lowest percentage spend for gold card type
with cte3 as (
select  city, card_type,sum(amount) as total_spend,
sum(case when card_type='Gold' then amount end) as gold_amount from Credit_card_transactions
group by city,card_type
order by city)
select city, (sum(gold_amount)*1.0/sum(total_spend))*100 as gold_percentage from cte3
group by city
having sum(gold_amount) is not null 
order by gold_percentage
;

-- 5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)
with cte5 as (select city, exp_type, sum(amount) as spend
from Credit_card_transactions
group by city, exp_type)

select city, min(case when rk_desc=1 then exp_type end) as max_spend, min(case when rk_asc=1 then exp_type end) as min_spend
from 
(
select * ,rank() over (partition by city order by spend desc)as rk_desc,
rank() over (partition by city order by spend asc) as rk_asc from cte5
) a
group by city
;

-- 6- write a query to find percentage contribution of spends by females for each expense type

select * from Credit_card_transactions;
select exp_type, sum(amount)as total_expense from Credit_card_transactions group by exp_type;
select exp_type,sum(amount) as female_expense from Credit_card_transactions where gender='F' group by exp_type;



select exp_type,

(sum(case when gender='F' then amount else 0 end)/sum(amount))*100.0 as percentage_female_contribution
from Credit_card_transactions
group by exp_type
order by exp_type;

-- which card and expense type combination saw highest month over month growth in Jan-2014

with cte as
(
select card_type,exp_type,year(date) as yt,month(date) as mt, sum(Amount) as total_spend from Credit_card_transactions 
group by card_type,exp_type,year(date) ,month(date)
)
select * ,(total_spend-prev_month_spend)/prev_month_spend as growth from 
(select *, lag(total_spend) over (partition by card_type, exp_type order by yt,mt) as prev_month_spend
 from cte ) A
 where prev_month_spend is not null and yt=2014 and mt=1
 order by growth desc 
;


-- during weekends which city has highest total spend to total no of transcations ratio 
select city, sum(amount)/count(1) as ratio from credit_card_transactions
where dayofweek(date) in (1,7)
group by city
order by ratio
desc;



-- which city took least number of days to reach its 500th transaction after the first transaction in that city
with cte9 as (
select *, row_number() over (partition by city order by date,transaction_id) as rn from credit_card_transactions
)
select city, datediff(last_date,first_date) as days_taken from
(select city,min(date) as first_date,max(date) last_date,rn from cte9 where rn =1 || rn=500
group by city
having count(*)=2) A
order by days_taken asc

;


