WITH sales_data AS (
    -- Join customers, orders, and items_list tables
    SELECT 
        C.customer_id,
        C.customer_name,
        O.order_date,
        I.price * O.quantity AS total_sales,
        EXTRACT(MONTH FROM O.order_date) AS order_month
    FROM `big-query-project-438917.dbt_nveerala.customers` AS C
    JOIN `big-query-project-438917.dbt_nveerala.orders` AS O ON C.customer_id = O.customer_id
    JOIN `big-query-project-438917.dbt_nveerala.items_list` AS I ON O.item_name = I.item_name
),

-- Aggregate total sales by customer and month
aggregated_sales AS (
    SELECT
        customer_id,
        customer_name,
        order_month,
        SUM(total_sales) AS monthly_sales
    FROM sales_data
    GROUP BY customer_id, customer_name, order_month
)

-- Pivot to display monthly sales as columns
SELECT
    customer_id,
    customer_name,
    COALESCE(SUM(CASE WHEN order_month = 1 THEN monthly_sales END), 0) AS Jan_sales,
    COALESCE(SUM(CASE WHEN order_month = 2 THEN monthly_sales END), 0) AS Feb_sales,
    COALESCE(SUM(CASE WHEN order_month = 3 THEN monthly_sales END), 0) AS Mar_sales,
    COALESCE(SUM(CASE WHEN order_month = 4 THEN monthly_sales END), 0) AS Apr_sales,
    COALESCE(SUM(CASE WHEN order_month = 5 THEN monthly_sales END), 0) AS May_sales,
    COALESCE(SUM(CASE WHEN order_month = 6 THEN monthly_sales END), 0) AS Jun_sales,
    COALESCE(SUM(CASE WHEN order_month = 7 THEN monthly_sales END), 0) AS Jul_sales,
    COALESCE(SUM(CASE WHEN order_month = 8 THEN monthly_sales END), 0) AS Aug_sales,
    COALESCE(SUM(CASE WHEN order_month = 9 THEN monthly_sales END), 0) AS Sep_sales,
    COALESCE(SUM(CASE WHEN order_month = 10 THEN monthly_sales END), 0) AS Oct_sales,
    COALESCE(SUM(CASE WHEN order_month = 11 THEN monthly_sales END), 0) AS Nov_sales,
    COALESCE(SUM(CASE WHEN order_month = 12 THEN monthly_sales END), 0) AS Dec_sales
FROM aggregated_sales
GROUP BY customer_id, customer_name
ORDER BY customer_name
