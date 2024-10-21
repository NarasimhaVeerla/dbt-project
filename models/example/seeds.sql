{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = 'item_name',
    merge_exclude_columns = 'item_name',
    alias = 'items_list',
    post_hook = """
    DELETE FROM `big-query-project-438917.dbt_nveerala.items_list`
    WHERE item_name NOT IN (
        SELECT item_name
        FROM `big-query-project-438917.dbt_nveerala.items`
    );
    """
) }}

with items as (
    select * from {{ ref('items') }}
)
select item_name,
    price
from items

--where item_name not in (select item_name from `big-query-project-438917`.`dbt_nveerala`.`items`)