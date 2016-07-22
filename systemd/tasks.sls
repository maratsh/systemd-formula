{% from "systemd/map.jinja" import systemd with context %}
include:
  - systemd.reload

{% for task in systemd.tasks %}
/lib/systemd/system/{{ task.name }}.service:
  file:
    - managed
    - source: salt://systemd/files/task.service
    - mode: 0644
    - user: root
    - group: root
    - template: jinja
    - context:
      task: {{ task }}
    - watch_in:
      cmd: systemctl daemon-reload


systemctl enable {{ task.name }}.service:
  cmd:
    - run
    - watch:
      - file: /lib/systemd/system/*
      - cmd: systemctl daemon-reload

systemctl restart {{ task.name }}.service:
  cmd:
    - run
    - watch:
      - file: /lib/systemd/system/*
      - cmd: systemctl daemon-reload

{% if 'timer' in task  %}
/lib/systemd/system/{{ task.name }}.timer:
  file:
    - managed
    - source: salt://systemd/files/task.timer
    - mode: 0644
    - user: root
    - group: root
    - template: jinja
      task: {{ task }}
    - watch_in:
      cmd: systemctl daemon-reload




systemctl enable {{ task.name }}.timer:
  cmd:
    - run
    - watch:
      - file: /lib/systemd/system/*
      - cmd: systemctl daemon-reload

systemctl restart {{ task.name }}.timer:
  cmd:
    - run
    - watch:
      - file: /lib/systemd/system/*
      - cmd: systemctl daemon-reload

{% endif %}
{% endfor %}
