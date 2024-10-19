-- Set the table and materialization configuration
{{ config(
    materialized='incremental', 
    alias='customer_data',
    unique_key = ['Customer_id','order_id'],
    incremental_strategy = 'merge',
    merge_exclude_columns = ['Customer_id','order_id']) }}

-- Fetch the data from the bronze layer
with
    bronze_orders as (
        select * from {{ ref("bronze") }}  -- This references the bronze layer model
    )

    -- Perform Merge
SELECT customer_id, 
    customer_name, 
    city, 
    order_id, 
    item_name, 
    price, 
    quantity
FROM bronze_orders

