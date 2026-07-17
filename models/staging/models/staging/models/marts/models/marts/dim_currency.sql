select

    md5(upper(currency)) as currency_id,

    upper(currency) as currency

from (

    select distinct
        currency

    from {{ ref('stg_products') }}

    where currency is not null

) c
