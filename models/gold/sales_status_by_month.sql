{{config(
    materialized = 'table',
    schema = 'golddataset',
    alias = 'monthly_sales_status'
)}}

with sales AS(
select {{monthly_sales_status('Jan_sales')}} AS JAN,
    {{monthly_sales_status('Feb_sales')}} AS FEB,
    {{monthly_sales_status('Mar_sales')}} AS MAR,
    {{monthly_sales_status('Apr_sales')}} AS APR,
    {{monthly_sales_status('May_sales')}} AS MAY,
    {{monthly_sales_status('Jun_sales')}} AS JUN,
    {{monthly_sales_status('Jul_sales')}} AS JUL,
    {{monthly_sales_status('Aug_sales')}} AS AUG,
    {{monthly_sales_status('Sep_sales')}} AS SEP,
    {{monthly_sales_status('Oct_sales')}} AS OCT,
    {{monthly_sales_status('Nov_sales')}} AS NOV,
    {{monthly_sales_status('Dec_sales')}} AS DECE,
from {{ref('sales_by_month')}}
)

select Month_Name, Status
from sales
UNPIVOT
(
    Status FOR month_name IN (JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DECE)
) AS unpvt
