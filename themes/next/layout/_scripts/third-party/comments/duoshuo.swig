{% if (theme.duoshuo and theme.duoshuo.shortname) or theme.duoshuo_shortname %}

  {% if theme.duoshuo %}
    {% set duoshuo_shortname = theme.duoshuo.shortname %}
  {% else %}
    {% set duoshuo_shortname = theme.duoshuo_shortname %}
  {% endif %}

  <script type="text/javascript">
    var duoshuoQuery = {short_name:"{{duoshuo_shortname}}"};
    
  </script>
	{% if (theme.duoshuo and theme.duoshuo.shortname) or theme.duoshuo_shortname %}
    <script src="{{ url_for(theme.js) }}/src/embed.js"></script>
{% endif %}
  {% if theme.duoshuo_info.ua_enable %}
    {% set ua_parser_internal = url_for(theme.vendors._internal) + '/ua-parser-js/dist/ua-parser.min.js?v=0.7.9' %}
    <script src="{{ theme.vendors.ua_parser | default(ua_parser_internal) }}"></script>
    <script src="{{ url_for(theme.js) }}/src/hook-duoshuo.js"></script>
  {% endif %}

{% endif %}
