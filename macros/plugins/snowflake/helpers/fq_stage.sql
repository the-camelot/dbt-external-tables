{%- macro fq_stage(source_node) %}
    {%- set stage = source_node.external.location|replace('@','') -%}
    {%- set lqn = stage.split('.') -%}
    
    {%- if lqn | length == 3 %}
        {%- set loc_database, loc_schema, loc_identifier = lqn[0], lqn[1], lqn[2] -%}
    {%- elif lqn | length == 2 -%}
        {%- set loc_database, loc_schema, loc_identifier = source_node.database, lqn[0], lqn[1] -%}
    {%- else -%}
        {%- set loc_database, loc_schema, loc_identifier = source_node.database, source_node.schema, lqn[0] -%}
    {%- endif -%}
    {%- set fq_stage = [loc_database,loc_schema,loc_identifier]|join('.') -%}
    @{{fq_stage}}
{% endmacro -%}