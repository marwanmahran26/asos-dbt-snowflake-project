select

    md5(upper(trim(product_type))) as product_type_id,

    trim(product_type) as product_type

from (

    select distinct
        product_type

    from {{ ref('stg_products') }}

    where product_type is not null

) types
