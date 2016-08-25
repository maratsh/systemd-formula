# saltstack systemd formula

This formula provide configuration management for systemd services, tasks and units override

## Supported platform: ##
* Redhat 7
* Debian 8


## Usage as macro ##
* Set variables ```{% from "someapp/map.jinja" import someapp with context %}```
* Import macro into state ```{% from 'systemd/macro/tasks.sls' import systemd_tasks %}```
* Use macro ```{{ systemd_tasks(someapp.tasks) }}```
