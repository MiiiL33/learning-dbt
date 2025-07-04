with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

locations as (
    select * from {{ ref('stg_locations') }}
),

joined as (
    select
        orders.order_id, 
        orders.location_id,
        orders.customer_id,
        orders.order_total,
        orders.tax_paid,
        orders.ordered_at,
        customers.name as customer_name,
        locations.location_name,
        locations.tax_rate,
        locations.location_opened_at

    from 
       orders 
        left join customers 
            on orders.customer_id = customers.name
        left join locations 
            on orders.location_id = locations.location_id    
)

select * from joined
