{% snapshot items_snapshot %}

{{config(
    target_schema = 'snapshot',
    strategy = 'check',
    unique_key = 'item_name',
    check_cols = ['price']
)}}

select * from {{ref("items")}}

{% endsnapshot%}