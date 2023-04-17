{{ config(
	materialized='table'
) }}


SELECT 
	orders.customer_id AS customer_id,
	customers.name AS name,
	customers.email AS email,
	MIN(orders.created_at) AS first_order_at,
	COUNT(orders.created_at) AS nr_of_orders
FROM {{source('coffee_shop', 'customers')}} AS customers
INNER JOIN {{ source('coffee_shop', 'orders') }} as orders ON customers.id=orders.customer_id
GROUP BY 
	customer_id,
	name,
	email
-- ORDER BY first_order_at
