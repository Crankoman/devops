# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению

1. * Необязательно. Изучите, что такое [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY).
2. Создайте свой публичный репозиторий на GitHub с произвольным именем или используйте старый.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

<-- Ответ

`docker-compose.yml`

```yaml
version: '3.9'
services:
  clickhouse-01:
    image: pycontribs/centos:7
    container_name: clickhouse-01
    restart: unless-stopped
    entrypoint: "sleep infinity"

  vector-01:
    image: pycontribs/centos:7
    container_name: vector-01
    restart: unless-stopped
    entrypoint: "sleep infinity"
```

---

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.

<-- Ответ


`inventory/prod.yml`

```yaml
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_connection: docker
      
vector:
  hosts:
    vector-01:
      ansible_connection: docker
```

---

2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2.

3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.

4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.

<-- Ответ

Весь плейбук находится тут https://github.com/Crankoman/devops/tree/main/ansible/02

`site.yml`

```yaml
---
---
- name: Install Clickhouse
  hosts: clickhouse
  handlers:
    - name: Start clickhouse service
      become: true
      ansible.builtin.service:
        name: clickhouse-server
        state: restarted
  tasks:
    - block:
        - name: Get clickhouse distrib
          ansible.builtin.get_url:
            url: "https://packages.clickhouse.com/rpm/stable/{{ item }}-{{ clickhouse_version }}.x86_64.rpm"
            dest: "./{{ item }}-{{ clickhouse_version }}.rpm"
          with_items: "{{ clickhouse_packages }}"
      rescue:
        - name: Get clickhouse distrib rescue
          ansible.builtin.get_url:
            url: "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-{{ clickhouse_version }}.x86_64.rpm"
            dest: "./clickhouse-common-static-{{ clickhouse_version }}.rpm"
    - name: Install clickhouse packages
      become: true
      ansible.builtin.yum:
        name:
          - clickhouse-common-static-{{ clickhouse_version }}.rpm
          - clickhouse-client-{{ clickhouse_version }}.rpm
          - clickhouse-server-{{ clickhouse_version }}.rpm
      notify: Start clickhouse service
    - name: Flush handlers
      ansible.builtin.meta: flush_handlers
    - name: Create database
      ansible.builtin.command: "clickhouse-client -q 'create database logs;'"
      register: create_db
      failed_when: create_db.rc != 0 and create_db.rc !=82
      changed_when: create_db.rc == 0

- name: Install Vector
  hosts: vector
  handlers:
   - name: Start vector service
     ansible.builtin.command: /usr/bin/vector --config-yaml {{ vector_config_dir }}/vector.toml
     tags: skip_ansible_lint
  tasks:
      - name: Install Vector distrib
        become: true
        ansible.builtin.yum:
          name: "https://packages.timber.io/vector/{{ vector_version }}/vector-{{ vector_version }}-1.{{ arch }}.rpm"
          state: present
      - name: Configure Vector | ensure what directory exists
        ansible.builtin.file:
          path: "{{ vector_config_dir }}"
          state: directory
          mode: 0644
          owner: root
          group: root
      - name: Configure Vector | Template config
        ansible.builtin.template:
          src: vector.toml.j2
          mode: 0644
          owner: root
          group: root
          dest: "{{ vector_config_dir }}/vector.toml"
        notify: Start vector service
```

---

5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.

<-- Ответ

```commandline
ansible-lint site.yml
WARNING  Listing 8 violation(s) that are fatal
name[missing]: All tasks should be named.
site.yml:11 Task/Handler: block/always/rescue

risky-file-permissions: File permissions unset or incorrect.
site.yml:12 Task/Handler: Get clickhouse distrib

risky-file-permissions: File permissions unset or incorrect.
site.yml:18 Task/Handler: Get clickhouse distrib rescue

jinja[spacing]: Jinja2 spacing could be improved: create_db.rc != 0 and create_db.rc !=82 -> create_db.rc != 0 and create_db.rc != 82 (warning)
site.yml:32 Jinja2 template rewrite recommendation: `create_db.rc != 0 and create_db.rc != 82`.

yaml[indentation]: Wrong indentation: expected 4 but found 3
site.yml:41

yaml[indentation]: Wrong indentation: expected 4 but found 6
site.yml:45

yaml[octal-values]: Forbidden implicit octal value "0644"
site.yml:54

yaml[octal-values]: Forbidden implicit octal value "0644"
site.yml:60

Read documentation for instructions on how to ignore specific rule violations.

                  Rule Violation Summary
 count tag                    profile rule associated tags
     1 jinja[spacing]         basic   formatting (warning)
     1 name[missing]          basic   idiom
     2 yaml[indentation]      basic   formatting, yaml
     2 yaml[octal-values]     basic   formatting, yaml
     2 risky-file-permissions safety  unpredictability

Failed: 7 failure(s), 1 warning(s) on 1 files. Last profile that met the validation criteria was 'min'.
```

---

6. Попробуйте запустить playbook на этом окружении с флагом `--check`.

<-- Ответ

```commandline
ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Clickhouse] **************************************************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] **********************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
ok: [clickhouse-01] => (item=clickhouse-common-static)

TASK [Install clickhouse packages] *****************************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] ******************************************************************************************************************************************

TASK [Create database] *****************************************************************************************************************************************
skipping: [clickhouse-01]

PLAY [Install Vector] ******************************************************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************************************************
ok: [vector-01]

TASK [Install Vector distrib] **********************************************************************************************************************************
ok: [vector-01]

TASK [Configure Vector | ensure what directory exists] *********************************************************************************************************
ok: [vector-01]

TASK [Configure Vector | Template config] **********************************************************************************************************************
ok: [vector-01]

PLAY RECAP *****************************************************************************************************************************************************
clickhouse-01              : ok=3    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
vector-01                  : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```

---

7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.

8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.

<-- Ответ

```commandline
ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] **************************************************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] **********************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
ok: [clickhouse-01] => (item=clickhouse-common-static)

TASK [Install clickhouse packages] *****************************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] ******************************************************************************************************************************************

TASK [Create database] *****************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] ******************************************************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************************************************
ok: [vector-01]

TASK [Install Vector distrib] **********************************************************************************************************************************
ok: [vector-01]

TASK [Configure Vector | ensure what directory exists] *********************************************************************************************************
ok: [vector-01]

TASK [Configure Vector | Template config] **********************************************************************************************************************
ok: [vector-01]

PLAY RECAP *****************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
vector-01                  : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

---

9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook).

https://github.com/Crankoman/devops/blob/main/ansible/02/README.md
---

10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

