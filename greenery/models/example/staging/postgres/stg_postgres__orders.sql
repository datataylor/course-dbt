with source as (
    select * from {{source('postgres','orders') }}
)

, renamed_recast as (
    select
        order_id as order_guid
        , promo_id 
        , user_id as user_guid
        , address_id as address_guid
        , created_at
        , order_cost
        , shipping_cost
        , order_total
        , tracking_id as tracking_guid
        , shipping_service
        , estimated_delivery_at
        , delivered_at
        , status
    from source
    
)

select * from renamed_recast