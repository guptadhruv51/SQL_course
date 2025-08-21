use sql_course;
select * from athlete_events;
select * from athletes;

-- 1 which team has won the maximum gold medals over the years.

select a.team as countries,count(distinct event) as gold_medals from athlete_events ae inner join athletes a 
on ae.athlete_id=a.id
where medal='Gold'
group by a.team
order by gold_medals desc;

-- 2 for each team print total silver medals and year in which they won maximum silver medal..output 3 columns
-- team,total_silver_medals, year_of_max_silver
with cte as (select a.team as countries,ae.year,count(distinct event) as silver_medals, rank() over (partition by team order by count(distinct event) desc) as rn from athlete_events ae left join athletes a 
on ae.athlete_id=a.id
where medal='Silver'
group by a.team, ae.year)
select countries,sum(silver_medals), max(case when rn=1 then year end) as year_of_max_silver from cte group by countries;

-- 3 which player has won maximum gold medals  amongst the players 
-- which have won only gold medal (never won silver or bronze) over the years

with cte_2 as (select name,medal from athlete_events ae inner join athletes a on ae.athlete_id=a.id)
select name,count(1) as no_of_gold_medals from cte_2 where name not in (select distinct name from cte_2 where medal in ('Silver','Bronze'))
and medal='Gold'
group by name 
order by no_of_gold_medals desc limit 1
;
SET GLOBAL net_read_timeout = 600;
SET GLOBAL net_write_timeout = 600;




SELECT a.name,
       COUNT(*) AS no_of_gold_medals
FROM athlete_events ae
JOIN athletes a 
  ON ae.athlete_id = a.id
GROUP BY a.name
HAVING SUM(medal = 'Gold') = COUNT(*)   -- all medals are gold
ORDER BY no_of_gold_medals DESC
LIMIT 1;

-- 4 in each year which player has won maximum gold medal . Write a query to print year,player name 
-- and no of golds won in that year . In case of a tie print comma separated player names.

with cte3 as (select a.name,count(*) as no_of_gold_medals,ae.year
from athlete_events as ae
join athletes a on 
  ae.athlete_id = a.id
  where medal='Gold'
GROUP BY a.name,ae.year
order by year asc)
select year,no_of_gold_medals, GROUP_CONCAT(name,',') as names from 
(select year,name,no_of_gold_medals, rank() over(partition by year order by no_of_gold_medals desc) as rn from cte3) a
where rn=1
group by year,no_of_gold_medals
;


-- 5 in which event and year India has won its first gold medal,first silver medal and first bronze medal
-- print 3 columns medal,year,sport
with cte5 as (select a.name,ae.medal,ae.year,ae.sport
from athlete_events as ae
join athletes a on 
  ae.athlete_id = a.id
  where a.team='India' and ae.medal in ('Gold','Silver','Bronze')
  order by year)
  select distinct * from (select medal,year,sport,dense_rank() over(partition by medal order by year asc) as rn from cte5) a where rn=1;
























 

