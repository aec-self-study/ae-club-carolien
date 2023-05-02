{{ config(
	materialized='table'
) }}

with user_stitching as (
  select
    visitor_id,
    customer_id
  from {{source('web_tracking', 'pageviews')}}
  where customer_id is not NULL
  group by 1,2
)


select 
  pageviews.id,
  pageviews.visitor_id as old_vis_id,
  user_stitching.customer_id as visitor_id,
  pageviews.device_type,
  pageviews.timestamp,
  pageviews.page,
  pageviews.customer_id
from{{source('web_tracking', 'pageviews')}} as pageviews
left join user_stitching on pageviews.visitor_id = user_stitching.visitor_id
order by timestamp

