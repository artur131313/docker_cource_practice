{% set aircraft_query%}
select
    distinct status
 from
 {{ ref('stg_flights__flights') }}   
{% endset%}

{% set aircraft_query_result = run_query(aircraft_query) %}
{% if execute %}
    {% set important_aircrafts = aircraft_query_result.columns[0].values() %}
{%else%}    
    {% set important_aircrafts = [] %}
 {% endif %}   

select
    {% for status in important_aircrafts %}
    SUM (CASE WHEN status = '{{ status }}' THEN 1 ELSE 0 END) as aircrafts_{{status|replace(' ','_')}} 
        {% if not loop.last %},{% endif %}
    {% endfor %}
from
{{ ref('stg_flights__flights') }}


