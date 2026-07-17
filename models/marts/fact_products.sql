-- =========================================
-- Fact Table: Products
-- One row = One Product
-- =========================================

select distinct

    -- Product Information
    p.product_id,
    p.product_code,
    p.title,

    -- Dimension Keys
    b.brand_id,
    pt.product_type_id,
    c.currency_id,
    pb.price_band_id,

    -- Pricing
    p.current_price,
    p.previous_price,
    p.rrp,

    -- Business Metrics
    p.discount_amount,
    p.discount_percentage,
    p.is_discounted

from {{ ref('stg_products') }} as p

left join {{ ref('dim_brand') }} as b
    on upper(trim(p.brand_name)) = upper(trim(b.brand_name))

left join {{ ref('dim_product_type') }} as pt
    on upper(trim(p.product_type)) = upper(trim(pt.product_type))

left join {{ ref('dim_currency') }} as c
    on upper(trim(p.currency)) = upper(trim(c.currency))

left join {{ ref('dim_price_band') }} as pb
    on
        case
            when p.current_price < 30 then 'Budget'
            when p.current_price between 30 and 100 then 'Mid-Range'
            else 'Premium'
        end = pb.price_band
