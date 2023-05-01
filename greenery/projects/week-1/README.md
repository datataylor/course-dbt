#Week 1 project

1. How many users do we have? 130

SELECT COUNT (DISTINCT user_guid)from dev_db.dbt_taylormon20gmailcom.stg_postgres__users;

2. On average, how many orders do we receive per hour? 15

with num_orders as (
    SELECT
        date_trunc('hour', created_at) as hour_ordered,
        count(distinct order_guid) as num_of_orders_per_hr
    FROM
        dev_db.dbt_taylormon20gmailcom.stg_postgres__orders
    GROUP BY 1)
select 
    round(avg(num_of_orders_per_hr))
from 
    num_orders;


3. On average, how long does an order take from being placed to being delivered? 4

SELECT round(AVG(DATEDIFF(day, created_at, delivered_at))) AS AVGDateDiff
from dev_db.dbt_taylormon20gmailcom.stg_postgres__orders;

4. How many users have only made one purchase? Two purchases? Three+ purchases?
25- made one purchase
28-made two purchases
71- made 3 or more purchases



with user_purchases as 
    (SELECT 
        user_guid,
        count(distinct order_guid) as num_purchases
    FROM dev_db.dbt_taylormon20gmailcom.stg_postgres__orders
    GROUP BY 1)
    SELECT
        CASE
            WHEN num_purchases = 1 THEN 'user made 1 purchase'
            WHEN num_purchases = 2 THEN 'user made 2 purchases'
            WHEN num_purchases >= 3 THEN 'user made 3 or more purchases'
        END as num_purchases,
        count (distinct user_guid) as num_users
    FROM user_purchases
    GROUP BY 1;

    5. On average, how many unique sessions do we have per hour? 39 

    with user_sessions as 
    (SELECT  
        hour(created_at) as hour_ordered,
        count(DISTINCT session_guid) as num_of_sessions
    FROM dev_db.dbt_taylormon20gmailcom.stg_postgres__events
    GROUP BY 1)
    
select round(avg(num_of_sessions))
from user_sessions;