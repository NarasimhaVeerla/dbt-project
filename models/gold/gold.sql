-- set the database and schema

{{config(
    materialized = 'incremental',
    unique_key = 'Customer_id',
    schema = 'golddataset',
    alias = 'customer_bill'
)}}

-- Get the data from bronze layer

with silver_orders AS (
    SELECT Customer_id,
        Customer_name,
        Price * Quantity AS Final_amount
    FROM {{ref("silver")}}
)

-- Insert new data into the existing table (customer_data)
SELECT
    Customer_id,
    Customer_name,
    Final_amount
FROM silver_orders

--{% if is_incremental() %}
    -- Only insert rows that don't already exist in the table based on the unique key
  --  WHERE Customer_id NOT IN (
    --    SELECT DISTINCT Customer_id
     --   FROM {{ this }}  -- Refers to the existing customer_data table in silverdataset
 --   )
--{% endif %}