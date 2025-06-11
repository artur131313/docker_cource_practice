select
  aircraft_code,
  COUNT(*) as aircraft_seat_cnt
from {{ ref('stg_flights__seats') }}
GROUP BY
    aircraft_code