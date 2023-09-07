# Домашнее задание к занятию 3 «Использование Ansible»

## Подготовка к выполнению

1. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.
2. Репозиторий LightHouse находится [по ссылке](https://github.com/VKCOM/lighthouse).

## Основная часть

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.

<-- Ответ

`site.yml`

```yaml
---
- name: Install Clickhouse
  hosts: clickhouse
  handlers:
    - name: Restart clickhouse service
      ansible.builtin.service:
        name: clickhouse-server
        state: restarted
  tasks:
    - name: Install, configure, and start Clickhouse
      block:
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
      notify: Restart clickhouse service
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
    - name: Restart vector service
      ansible.builtin.service:
        name: vector
        state: restarted
  tasks:
    - name: Install Vector distrib
      become: true
      ansible.builtin.yum:
        name: "https://packages.timber.io/vector/{{ vector_version }}/vector-{{ vector_version }}-1.{{ arch }}.rpm"
        state: present
    - name: Setup vector config
      ansible.builtin.template:
        src: vector.yml.j2
        dest: "/etc/vector/vector.yml"
        mode: "0644"
        owner: "{{ ansible_user_id }}"
        group: "{{ ansible_user_gid }}"
    - name: Vector systemd
      ansible.builtin.template:
        src: /templates/vector.service.j2
        dest: /usr/lib/systemd/system/vector.service
        mode: "0644"
        owner: "{{ ansible_user_id }}"
        group: "{{ ansible_user_gid }}"
        backup: true
      notify: Restart Vector service

- name: Install Nginx
  hosts: lighthouse
  handlers:
    - name: Start-nginx
      become: true
      ansible.builtin.command: nginx
    - name: Reload-nginx
      become: true
      ansible.builtin.command: nginx -s reload-nginx
  tasks:
    - name: Install epel-release
      become: true
      ansible.builtin.yum:
        name: epel-release
        state: present
    - name: Install nginx
      become: true
      ansible.builtin.yum:
        name: nginx
        state: present
      notify: Start-nginx
    - name: Nginx setup config
      become: true
      ansible.builtin.template:
        src: /templates/nginx.conf.j2
        dest: /etc/nginx/nginx.conf
        mode: "0644"
      notify: Reload-nginx

- name: Install LightHouse
  hosts: lighthouse
  handlers:
  - name: Reload-nginx
    become: true
    ansible.builtin.command: nginx -s reload-nginx
  pre_tasks:
    - name: Install git
      become: true
      ansible.builtin.yum:
        name: git
        state: present
  tasks:
    - name: Copy from git
      ansible.builtin.git:
        repo: "{{ lighthouse_git }}"
        version: master
        dest: "{{ lighthouse_dir }}"
    - name: LightHouse setup config
      become: true
      ansible.builtin.template:
        src: /templates/lighthouse.conf.j2
        dest: /etc/nginx/conf.d/default.conf
        mode: "0644"
      notify: Reload-nginx
```

---

4. Подготовьте свой inventory-файл `prod.yml`.

<-- Ответ

`prod.yml`

```yaml
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: 158.160.0.70

vector:
  hosts:
    vector-01:
      ansible_host: 51.250.23.168

lighthouse:
  hosts:
    lighthouse-01:
      ansible_host: 51.250.101.126
```

---

5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.

9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.

<-- Ответ

https://github.com/Crankoman/devops/blob/main/ansible/03/README.md
---

10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.

<-- Ответ

Файлы плейбука https://github.com/Crankoman/devops/tree/main/ansible/03

https://github.com/Crankoman/devops/blob/main/08-ansible-03-yandex.md

---

