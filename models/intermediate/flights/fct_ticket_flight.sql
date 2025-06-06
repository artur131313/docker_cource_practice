{{
  config(
    materialized = 'table'
    )
}}
select
    ft.ticket_no,
    fb.flight_id,
    fare_conditions,
    amount,
    CASE 
    WHEN fb.ticket_no IS NOT NULL THEN 1 
        ELSE 0 
    END AS boarding_pass_exists,
    boarding_no,
    seat_no,
    CURRENT_DATE::TIMESTAMPTZ AS load_date    
from
    {{ ref('stg_flights__ticket_flights') }} as ft
left join
    {{ ref('stg_flights__boarding_passes') }} as fb 
    on ft.ticket_no = fb.ticket_no and ft.flight_id = fb.flight_id