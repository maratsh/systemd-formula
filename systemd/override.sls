{% from "systemd/map.jinja" import systemd with context %}
{% from 'systemd/macro/override.sls' import systemd_override %}
{{ systemd_override(systemd.override) }}
