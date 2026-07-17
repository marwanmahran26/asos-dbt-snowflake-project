
select

    -- Stable Surrogate Key
    md5(upper(trim(brand_name))) as brand_id,

    trim(brand_name) as brand_name

from (

    select distinct
        brand_name

    from {{ ref('stg_products') }}

    where brand_name is not null

) brands
