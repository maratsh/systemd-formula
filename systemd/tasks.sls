{% from "systemd/map.jinja" import systemd with context %}
{% from 'systemd/macro/tasks.sls' import systemd_tasks %}
{{ systemd_tasks(systemd.tasks) }}
