select

    -- Surrogate Key
    md5(price_band) as price_band_id,

    -- Price Category
    price_band

from (

    select distinct

        case
            when current_price < 30 then 'Budget'
            when current_price between 30 and 100 then 'Mid-Range'
            else 'Premium'
        end as price_band

    from {{ ref('stg_products') }}

)
