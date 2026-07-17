select
    product_id,
    productcode as product_code,

    -- Product Details

    trim(brand_name) as brand_name,  --trim removes unnecessary spaces 
    trim(title) as title,
    producttype as product_type,

    current_price,

    coalesce(previous_price, current_price) as previous_price, -- If previous price is missing, use current price

    rrp,     -- Recommended Retail Price

    upper(currency) as currency,


    (rrp - current_price) as discount_amount,     -- Discount 

    -- percentage
    round(
        ((rrp - current_price) / nullif(rrp, 0)) * 100,
        2
    ) as discount_percentage,

    --discounted or not 
    case
        when current_price < rrp then true
        else false
    end as is_discounted

from {{ source('raw', 'ASOS_PRODUCTS_RAW') }}
