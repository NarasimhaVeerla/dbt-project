{% macro monthly_sales_status(month_name)%}

    case when sum({{month_name}}) >= 1800 then 'Good Sales'
            when sum({{month_name}}) < 1800 and sum({{month_name}}) >= 1200 then 'Avarage Sales'
            else 'Not up to the mark' end

{% endmacro%}