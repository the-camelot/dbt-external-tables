{%- macro fq_file_format(source_node) %}
    {%- set file_format = source_node.external.file_format -%}
    {%- set ff_ltrimmed = file_format|lower|replace(' ','') -%}

    {%- if 'type=' in ff_ltrimmed -%}
        {{file_format}}
    {%- else -%}
        {%- set ff_standardized = ff_ltrimmed
            | replace('(','') | replace(')','')
            | replace('format_name=','') -%}
        {%- set fqn = ff_standardized.split('.') -%}
        
        {%- if fqn | length == 3 -%}
            {%- set ff_database, ff_schema, ff_identifier = fqn[0], fqn[1], fqn[2] -%}
        {%- elif fqn | length == 2 -%}
            {%- set ff_database, ff_schema, ff_identifier = source_node.database, fqn[0], fqn[1] -%}
        {%- else -%}
            {%- set ff_database, ff_schema, ff_identifier = source_node.database, source_node.schema, fqn[0] -%}
        {%- endif -%}
        {{ff_database}}.{{ff_schema}}.{{ff_identifier}}
    {%- endif -%}
{% endmacro -%}