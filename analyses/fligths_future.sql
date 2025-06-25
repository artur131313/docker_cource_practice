select
    count (*)
from
{{ ref('fct_flights') }}
where 
    scheduled_departure >= '{{ run_started_at|string|truncate(10, True, "") }}'
