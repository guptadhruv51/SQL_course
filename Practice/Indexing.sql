use sql_store;
select customer_id from customers where state="CA";
explain select customer_id from customers where state="CA";
create index idx_state on customers (state);


explain select customer_id from customers where points>1000;
create index idx_points on customers (points);

show indexes in customers;
-- prefix index
create index id_lastname on customers (last_name(20));


-- full text indexes

use sql_blog;
create fulltext index idx_title_body on posts(title,body);
select * from posts where match (title,body) against ('react redux');
select * from posts where match (title,body) against ('react -redux' in boolean mode);

-- composite indexes

use sql_store;
show indexes in customers; 
create index idx_state_points on customers (state, points);
explain select customer_id from customers where state='CA' and points>1000;