{% macro systemd_override(override) %}

include:
  - systemd.reload


{% for task in override %}
/etc/systemd/system/{{ task.name }}.service.d/override.conf:
  file:
    - managed
    - source: salt://systemd/files/task.service
    - mode: 0644
    - user: root
    - group: root
    - makedirs: True
    - template: jinja
    - context:
      task: {{ task }}
    - watch_in:
      cmd: systemctl daemon-reload

{% endfor %}
{% endmacro %}
