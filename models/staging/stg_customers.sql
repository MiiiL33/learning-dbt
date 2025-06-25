with

source as (
    select * from {{ source('jaffle_shop', 'customers') }}
),

renamed as (
    select
        string_field_0 as id,
        string_field_1 as name
    from source
)

select * from renamed
