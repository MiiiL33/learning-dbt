with products as (
    select * from {{ ref('stg_products') }}
),

supplies as (
    select * from {{ ref('stg_supplies') }}
),

product_supplies_summary as (
    select
        product_id,
        sum(supply_cost) as supply_cost
    from supplies
    group by 1
),

final as (
    select
        products.product_id,
        products.name as product_name,
        products.type as product_type,
        products.description as product_description,
        products.price as product_price,
        product_supplies_summary.supply_cost,
        -- Reglas de clasificación simples como ejemplo
        products.type = 'jaffle' as is_food_item,
        products.type = 'beverage' as is_drink_item
    from products
    left join product_supplies_summary 
        on products.product_id = product_supplies_summary.product_id
)

select * from final
