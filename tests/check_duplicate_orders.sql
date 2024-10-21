WITH order_duplicates AS (
  SELECT 
    order_id, 
    COUNT(*) AS count
  FROM {{ ref('gold') }}
  GROUP BY order_id
  HAVING COUNT(*) > 1
)

SELECT *
FROM order_duplicates