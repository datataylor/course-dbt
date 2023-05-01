{% snapshot products_snapshot_inventory %}

{{
  config(
    target_database = target.database,
    target_schema = target.schema,
    strategy='check',
    unique_key='product_guid',
    check_cols=['inventory'],
   )
}}

select * from {{ ref('stg_postgres__products') }}

{% endsnapshot %}