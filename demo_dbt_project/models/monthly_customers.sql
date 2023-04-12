
select
    date_trunc(first_order_at, month) as signup_month,
    count(*) as new_customers
 
-- from `aec-students.dbt_carova.customers` -- update this for your project and schema
from {{ ref('customers') }}
 
group by 1