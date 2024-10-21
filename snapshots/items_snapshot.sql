{% snapshot items_snapshot %}

{{config(
    target_schema = 'snapshot',
    strategy = 'check',
    unique_key = 'item_name',
    check_cols = ['price']
)}}

select * from `big-query-project-438917.dbt_nveerala.items`

{% endsnapshot%}