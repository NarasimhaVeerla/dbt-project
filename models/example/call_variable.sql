{{config(
    materialized = 'view',
    schema = 'snapshot',
)}}

select item_name,
    price
from {{ref("items_snapshot")}}
where price >= {{var('avg_price')}}