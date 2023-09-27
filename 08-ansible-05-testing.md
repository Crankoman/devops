# Домашнее задание к занятию 5 «Тестирование roles»

## Подготовка к выполнению

1. Установите molecule: `pip3 install "molecule==3.5.2"` и драйвера `pip3 install molecule_docker molecule_podman`.
2. Выполните `docker pull aragast/netology:latest` —  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри.

## Основная часть

Ваша цель — настроить тестирование ваших ролей. 

Задача — сделать сценарии тестирования для vector. 

Ожидаемый результат — все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s centos_7` внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу.

<-- Ответ

<details>  
<summary>подробнее</summary>

```commandline
molecule test -s centos_7
INFO     centos_7 scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/b9a93c/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/b9a93c/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/b9a93c/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Inventory /tmp/ansible-clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /root/.cache/molecule/ansible-clickhouse/centos_7/inventory/hosts
INFO     Inventory /tmp/ansible-clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /root/.cache/molecule/ansible-clickhouse/centos_7/inventory/group_vars
INFO     Inventory /tmp/ansible-clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /root/.cache/molecule/ansible-clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Inventory /tmp/ansible-clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /root/.cache/molecule/ansible-clickhouse/centos_7/inventory/hosts
INFO     Inventory /tmp/ansible-clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /root/.cache/molecule/ansible-clickhouse/centos_7/inventory/group_vars
INFO     Inventory /tmp/ansible-clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /root/.cache/molecule/ansible-clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > lint
COMMAND: yamllint .
ansible-lint
flake8

WARNING  Listing 77 violation(s) that are fatal
fqcn[action-core]: Use FQCN for builtin module actions (set_fact).
handlers/main.yml:3 Use `ansible.builtin.set_fact` or `ansible.legacy.set_fact` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_role).
molecule/centos_7/converge.yml:5 Use `ansible.builtin.include_role` or `ansible.legacy.include_role` instead.

fqcn[action-core]: Use FQCN for builtin module actions (assert).
molecule/centos_7/verify.yml:8 Use `ansible.builtin.assert` or `ansible.legacy.assert` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_role).
molecule/centos_8/converge.yml:5 Use `ansible.builtin.include_role` or `ansible.legacy.include_role` instead.

fqcn[action-core]: Use FQCN for builtin module actions (assert).
molecule/centos_8/verify.yml:8 Use `ansible.builtin.assert` or `ansible.legacy.assert` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_role).
molecule/resources/playbooks/converge.yml:5 Use `ansible.builtin.include_role` or `ansible.legacy.include_role` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_role).
molecule/ubuntu_focal/converge.yml:5 Use `ansible.builtin.include_role` or `ansible.legacy.include_role` instead.

fqcn[action-core]: Use FQCN for builtin module actions (assert).
molecule/ubuntu_focal/verify.yml:8 Use `ansible.builtin.assert` or `ansible.legacy.assert` instead.

fqcn[action-core]: Use FQCN for builtin module actions (set_fact).
tasks/configure/db.yml:2 Use `ansible.builtin.set_fact` or `ansible.legacy.set_fact` instead.

jinja[spacing]: Jinja2 spacing could be improved: clickhouse-client -h 127.0.0.1 --port {{ clickhouse_tcp_secure_port | default(clickhouse_tcp_port) }}{{' --secure' if clickhouse_tcp_secure_port is defined else '' }} -> clickhouse-client -h 127.0.0.1 --port {{ clickhouse_tcp_secure_port | default(clickhouse_tcp_port) }}{{ ' --secure' if clickhouse_tcp_secure_port is defined else '' }} (warning)
tasks/configure/db.yml:2 Jinja2 template rewrite recommendation: `clickhouse-client -h 127.0.0.1 --port {{ clickhouse_tcp_secure_port | default(clickhouse_tcp_port) }}{{ ' --secure' if clickhouse_tcp_secure_port is defined else '' }}`.

no-free-form: Avoid using free-form when calling module actions. (set_fact)
tasks/configure/db.yml:2 Task/Handler: Set ClickHose Connection String

fqcn[action-core]: Use FQCN for builtin module actions (command).
tasks/configure/db.yml:5 Use `ansible.builtin.command` or `ansible.legacy.command` instead.

fqcn[action-core]: Use FQCN for builtin module actions (command).
tasks/configure/db.yml:11 Use `ansible.builtin.command` or `ansible.legacy.command` instead.

no-changed-when: Commands should not change things if nothing needs doing.
tasks/configure/db.yml:11 Task/Handler: Config | Delete database config

fqcn[action-core]: Use FQCN for builtin module actions (command).
tasks/configure/db.yml:20 Use `ansible.builtin.command` or `ansible.legacy.command` instead.

no-changed-when: Commands should not change things if nothing needs doing.
tasks/configure/db.yml:20 Task/Handler: Config | Create database config

fqcn[action-core]: Use FQCN for builtin module actions (template).
tasks/configure/dict.yml:2 Use `ansible.builtin.template` or `ansible.legacy.template` instead.

fqcn[action-core]: Use FQCN for builtin module actions (file).
tasks/configure/sys.yml:2 Use `ansible.builtin.file` or `ansible.legacy.file` instead.

fqcn[action-core]: Use FQCN for builtin module actions (file).
tasks/configure/sys.yml:17 Use `ansible.builtin.file` or `ansible.legacy.file` instead.

fqcn[action-core]: Use FQCN for builtin module actions (file).
tasks/configure/sys.yml:26 Use `ansible.builtin.file` or `ansible.legacy.file` instead.

fqcn[action-core]: Use FQCN for builtin module actions (template).
tasks/configure/sys.yml:35 Use `ansible.builtin.template` or `ansible.legacy.template` instead.

fqcn[action-core]: Use FQCN for builtin module actions (template).
tasks/configure/sys.yml:45 Use `ansible.builtin.template` or `ansible.legacy.template` instead.

fqcn[action-core]: Use FQCN for builtin module actions (template).
tasks/configure/sys.yml:54 Use `ansible.builtin.template` or `ansible.legacy.template` instead.

fqcn[action-core]: Use FQCN for builtin module actions (template).
tasks/configure/sys.yml:65 Use `ansible.builtin.template` or `ansible.legacy.template` instead.

fqcn[action-core]: Use FQCN for builtin module actions (template).
tasks/configure/sys.yml:76 Use `ansible.builtin.template` or `ansible.legacy.template` instead.

fqcn[action-core]: Use FQCN for builtin module actions (lineinfile).
tasks/configure/sys.yml:87 Use `ansible.builtin.lineinfile` or `ansible.legacy.lineinfile` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt_key).
tasks/install/apt.yml:5 Use `ansible.builtin.apt_key` or `ansible.legacy.apt_key` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt_repository).
tasks/install/apt.yml:12 Use `ansible.builtin.apt_repository` or `ansible.legacy.apt_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt_repository).
tasks/install/apt.yml:20 Use `ansible.builtin.apt_repository` or `ansible.legacy.apt_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt).
tasks/install/apt.yml:27 Use `ansible.builtin.apt` or `ansible.legacy.apt` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt).
tasks/install/apt.yml:36 Use `ansible.builtin.apt` or `ansible.legacy.apt` instead.

fqcn[action-core]: Use FQCN for builtin module actions (copy).
tasks/install/apt.yml:45 Use `ansible.builtin.copy` or `ansible.legacy.copy` instead.

risky-file-permissions: File permissions unset or incorrect.
tasks/install/apt.yml:45 Task/Handler: Hold specified version during APT upgrade | Package installation

fqcn[action-core]: Use FQCN for builtin module actions (rpm_key).
tasks/install/dnf.yml:5 Use `ansible.builtin.rpm_key` or `ansible.legacy.rpm_key` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum_repository).
tasks/install/dnf.yml:12 Use `ansible.builtin.yum_repository` or `ansible.legacy.yum_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (dnf).
tasks/install/dnf.yml:24 Use `ansible.builtin.dnf` or `ansible.legacy.dnf` instead.

fqcn[action-core]: Use FQCN for builtin module actions (dnf).
tasks/install/dnf.yml:33 Use `ansible.builtin.dnf` or `ansible.legacy.dnf` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum_repository).
tasks/install/yum.yml:5 Use `ansible.builtin.yum_repository` or `ansible.legacy.yum_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum).
tasks/install/yum.yml:16 Use `ansible.builtin.yum` or `ansible.legacy.yum` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum).
tasks/install/yum.yml:25 Use `ansible.builtin.yum` or `ansible.legacy.yum` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_vars).
tasks/main.yml:3 Use `ansible.builtin.include_vars` or `ansible.legacy.include_vars` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:14 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:14 Task/Handler: include_tasks precheck.yml

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:17 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:17 Task/Handler: include_tasks params.yml

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:20 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:20 Task/Handler: include_tasks file={{ lookup('first_found', params) }} apply={'tags': ['install'], '__line__': 23, '__file__': PosixPath('tasks/main.yml')}

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:32 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:32 Task/Handler: include_tasks file=configure/sys.yml apply={'tags': ['config', 'config_sys'], '__line__': 35, '__file__': PosixPath('tasks/main.yml')}

fqcn[action-core]: Use FQCN for builtin module actions (meta).
tasks/main.yml:39 Use `ansible.builtin.meta` or `ansible.legacy.meta` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:42 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:42 Task/Handler: include_tasks service.yml

fqcn[action-core]: Use FQCN for builtin module actions (wait_for).
tasks/main.yml:45 Use `ansible.builtin.wait_for` or `ansible.legacy.wait_for` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:51 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:51 Task/Handler: include_tasks file=configure/db.yml apply={'tags': ['config', 'config_db'], '__line__': 54, '__file__': PosixPath('tasks/main.yml')}

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:58 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:58 Task/Handler: include_tasks file=configure/dict.yml apply={'tags': ['config', 'config_dict'], '__line__': 61, '__file__': PosixPath('tasks/main.yml')}

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:65 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:65 Task/Handler: include_tasks file=remove.yml apply={'tags': ['remove'], '__line__': 68, '__file__': PosixPath('tasks/main.yml')}

fqcn[action-core]: Use FQCN for builtin module actions (set_fact).
tasks/params.yml:3 Use `ansible.builtin.set_fact` or `ansible.legacy.set_fact` instead.

fqcn[action-core]: Use FQCN for builtin module actions (set_fact).
tasks/params.yml:7 Use `ansible.builtin.set_fact` or `ansible.legacy.set_fact` instead.

fqcn[action-core]: Use FQCN for builtin module actions (command).
tasks/precheck.yml:1 Use `ansible.builtin.command` or `ansible.legacy.command` instead.

fqcn[action-core]: Use FQCN for builtin module actions (fail).
tasks/precheck.yml:5 Use `ansible.builtin.fail` or `ansible.legacy.fail` instead.

fqcn[action-core]: Use FQCN for builtin module actions (file).
tasks/remove.yml:3 Use `ansible.builtin.file` or `ansible.legacy.file` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/remove.yml:15 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/remove.yml:15 Task/Handler: include_tasks remove/{{ ansible_pkg_mgr }}.yml

fqcn[action-core]: Use FQCN for builtin module actions (apt).
tasks/remove/apt.yml:5 Use `ansible.builtin.apt` or `ansible.legacy.apt` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt_repository).
tasks/remove/apt.yml:12 Use `ansible.builtin.apt_repository` or `ansible.legacy.apt_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt_key).
tasks/remove/apt.yml:18 Use `ansible.builtin.apt_key` or `ansible.legacy.apt_key` instead.

fqcn[action-core]: Use FQCN for builtin module actions (dnf).
tasks/remove/dnf.yml:5 Use `ansible.builtin.dnf` or `ansible.legacy.dnf` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum_repository).
tasks/remove/dnf.yml:12 Use `ansible.builtin.yum_repository` or `ansible.legacy.yum_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (rpm_key).
tasks/remove/dnf.yml:19 Use `ansible.builtin.rpm_key` or `ansible.legacy.rpm_key` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum).
tasks/remove/yum.yml:5 Use `ansible.builtin.yum` or `ansible.legacy.yum` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum_repository).
tasks/remove/yum.yml:12 Use `ansible.builtin.yum_repository` or `ansible.legacy.yum_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (service).
tasks/service.yml:3 Use `ansible.builtin.service` or `ansible.legacy.service` instead.

name[template]: Jinja templates should only be at the end of 'name'
tasks/service.yml:3 Task/Handler: Ensure {{ clickhouse_service }} is enabled: {{ clickhouse_service_enable }} and state: {{ clickhouse_service_ensure }}

jinja[spacing]: Jinja2 spacing could be improved: deb http://repo.yandex.ru/clickhouse/{{ansible_distribution_release}} stable main -> deb http://repo.yandex.ru/clickhouse/{{ ansible_distribution_release }} stable main (warning)
vars/debian.yml:4 Jinja2 template rewrite recommendation: `deb http://repo.yandex.ru/clickhouse/{{ ansible_distribution_release }} stable main`.

Read documentation for instructions on how to ignore specific rule violations.

                       Rule Violation Summary
 count tag                    profile    rule associated tags
     2 jinja[spacing]         basic      formatting (warning)
     1 no-free-form           basic      syntax, risk
     9 name[missing]          basic      idiom
     1 name[template]         moderate   idiom
     1 risky-file-permissions safety     unpredictability
     2 no-changed-when        shared     command-shell, idempotency
    61 fqcn[action-core]      production formatting

Failed: 75 failure(s), 2 warning(s) on 59 files. Last profile that met the validation criteria was 'min'.
A new release of ansible-lint is available: 6.19.0 → 6.20.0
/bin/bash: line 3: flake8: command not found
CRITICAL Lint failed with error code 127
WARNING  An error occurred during the test sequence action: 'lint'. Cleaning up.
INFO     Inventory /tmp/ansible-clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /root/.cache/molecule/ansible-clickhouse/centos_7/inventory/hosts
INFO     Inventory /tmp/ansible-clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /root/.cache/molecule/ansible-clickhouse/centos_7/inventory/group_vars
INFO     Inventory /tmp/ansible-clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /root/.cache/molecule/ansible-clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Inventory /tmp/ansible-clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /root/.cache/molecule/ansible-clickhouse/centos_7/inventory/hosts
INFO     Inventory /tmp/ansible-clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /root/.cache/molecule/ansible-clickhouse/centos_7/inventory/group_vars
INFO     Inventory /tmp/ansible-clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /root/.cache/molecule/ansible-clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_7)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos_7)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory

```

</details>  

---

2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.

<-- Ответ


`molecule init scenario --driver-name docker`

```commandline
INFO     Initializing new scenario default...
INFO     Initialized scenario in /opt/vector-role/molecule/default successfully

```

---
3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.

<-- Ответ

`molecule.yml`

```yaml
---
dependency:
  name: galaxy
driver:
  name: docker
platforms:
  - name: centos_8
    image: docker.io/pycontribs/centos:8
    pre_build_image: true
    privileged: true
  - name: ubuntu
    image: docker.io/pycontribs/ubuntu:latest
    pre_build_image: true
provisioner:
  name: ansible
verifier:
  name: ansible

```

---

4. Добавьте несколько assert в verify.yml-файл для проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.).

<-- Ответ

`verify.yml`

```yaml
---
# This is an example playbook to execute Ansible tests.

- name: Verify
  hosts: all
  gather_facts: false
  tasks:
  - name: check vector service started
    ansible.builtin.service:
     name: vector
     state: started

```

---
 
5. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.

<-- Ответ

<details>  
<summary>подробнее</summary>

```commandline
molecule test
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/f5bcd7/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/f5bcd7/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/f5bcd7/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos_8)
ok: [localhost] => (item=ubuntu_latest)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > syntax

playbook: /tmp/temp/devops-netology/homework/hw8.4/playbook/roles/vector-role/molecule/default/converge.yml
INFO     Running default > create

PLAY [Create] ******************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True})
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True})
skipping: [localhost]

TASK [Synchronization the context] *********************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True})
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True})
skipping: [localhost]

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'false_condition': 'not item.pre_build_image | default(false)', 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'false_condition': 'not item.pre_build_image | default(false)', 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 1, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:8)
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest)
skipping: [localhost]

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j441834869329.290652', 'results_file': '/root/.ansible_async/j441834869329.290652', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j312824800377.290763', 'results_file': '/root/.ansible_async/j312824800377.290763', 'changed': True, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=6    changed=2    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Get Vector version] ****************************************
fatal: [ubuntu_latest]: FAILED! => {"changed": false, "cmd": "vector --version", "failed_when_result": true, "msg": "[Errno 2] No such file or directory: b'vector': b'vector'", "rc": 2, "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
fatal: [centos_8]: FAILED! => {"changed": false, "cmd": "vector --version", "failed_when_result": true, "msg": "[Errno 2] No such file or directory: b'vector': b'vector'", "rc": 2, "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
...ignoring
...ignoring

TASK [vector-role : Create directory vector] ***********************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector-role : Get vector distrib] ****************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector-role : Unarchive vector] ******************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector-role : Create a symbolic link] ************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector-role : Mkdir vector data] *****************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Vector config create] **************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Create vector unit file] ***********************************
changed: [centos_8]
changed: [ubuntu_latest]

RUNNING HANDLER [vector-role : Restart Vector] *********************************
fatal: [ubuntu_latest]: FAILED! => {"changed": false, "msg": "Failed to find required executable \"systemctl\" in paths: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"}
fatal: [centos_8]: FAILED! => {"changed": false, "msg": "failure 1 during daemon-reload: System has not been booted with systemd as init system (PID 1). Can't operate.\nFailed to connect to bus: Host is down\n"}

PLAY RECAP *********************************************************************
centos_8                   : ok=9    changed=7    unreachable=0    failed=1    skipped=0    rescued=0    ignored=1
ubuntu_latest              : ok=9    changed=7    unreachable=0    failed=1    skipped=0    rescued=0    ignored=1

CRITICAL Ansible return code was 2, command was: ['ansible-playbook', '--inventory', '/root/.cache/molecule/vector-role/default/inventory', '--skip-tags', 'molecule-notest,notest', '/tmp/temp/devops-netology/homework/hw8.4/playbook/roles/vector-role/molecule/default/converge.yml']
WARNING  An error occurred during the test sequence action: 'converge'. Cleaning up.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory

```

</details> 
---

6. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

https://github.com/Crankoman/vector-role

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example).
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.

<-- Ответ

<details>  
<summary>подробнее</summary>

```commandline
tox
py37-ansible210 create: /opt/vector-role/.tox/py37-ansible210
py37-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.5,certifi==2023.7.22,cffi==1.15.1,chardet==5.2.0,charset-normalizer==3.2.0,click==8.1.7,click-help-colors==0.9.2,cookiecutter==2.3.1,cryptography==41.0.4,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.7.0,Jinja2==3.1.2,jmespath==1.0.1,lxml==4.9.3,markdown-it-py==2.2.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.16.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.5.3,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.3,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.5,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='3928389615'
py37-ansible210 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible210/bin/molecule test -s compatibility --destroy always (exited with code 1)
py37-ansible30 create: /opt/vector-role/.tox/py37-ansible30
py37-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
^X^CERROR: got KeyboardInterrupt signal
___________________________________________________________________________ summary ____________________________________________________________________________
ERROR:   py37-ansible210: commands failed
ERROR:   py37-ansible30: keyboardinterrupt
ERROR:   py39-ansible210: undefined
ERROR:   py39-ansible30: undefined
[root@9ae1f0e80265 vector-role]# tox
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.5,certifi==2023.7.22,cffi==1.15.1,chardet==5.2.0,charset-normalizer==3.2.0,click==8.1.7,click-help-colors==0.9.2,cookiecutter==2.3.1,cryptography==41.0.4,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.7.0,Jinja2==3.1.2,jmespath==1.0.1,lxml==4.9.3,markdown-it-py==2.2.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.16.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.5.3,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.3,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.5,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='2742925339'
py37-ansible210 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible210/bin/molecule test -s compatibility --destroy always (exited with code 1)
py37-ansible30 create: /opt/vector-role/.tox/py37-ansible30
py37-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
ERROR: invocation failed (exit code 1), logfile: /opt/vector-role/.tox/py37-ansible30/log/py37-ansible30-1.log
========================================================================== log start ===========================================================================
Collecting ansible<3.1
  Using cached ansible-3.0.0.tar.gz (30.8 MB)
  Preparing metadata (setup.py): started
  Preparing metadata (setup.py): finished with status 'done'
Collecting selinux
  Using cached selinux-0.2.1-py2.py3-none-any.whl (4.3 kB)
Collecting ansible-lint==5.1.3
  Using cached ansible_lint-5.1.3-py3-none-any.whl (113 kB)
Collecting yamllint==1.26.3
  Using cached yamllint-1.26.3-py2.py3-none-any.whl
Collecting lxml
  Using cached lxml-4.9.3-cp37-cp37m-manylinux_2_28_x86_64.whl (7.4 MB)
Collecting molecule==3.5.2
  Using cached molecule-3.5.2-py3-none-any.whl (240 kB)
Collecting molecule_podman
  Using cached molecule_podman-1.1.0-py3-none-any.whl (15 kB)
Collecting jmespath
  Using cached jmespath-1.0.1-py3-none-any.whl (20 kB)
Collecting enrich>=1.2.6
  Using cached enrich-1.2.7-py3-none-any.whl (8.7 kB)
Collecting packaging
  Using cached packaging-23.1-py3-none-any.whl (48 kB)
Collecting tenacity
  Using cached tenacity-8.2.3-py3-none-any.whl (24 kB)
Collecting wcmatch>=7.0
  Using cached wcmatch-8.4.1-py3-none-any.whl (39 kB)
Collecting ruamel.yaml<1,>=0.15.37
  Using cached ruamel.yaml-0.17.32-py3-none-any.whl (112 kB)
Collecting rich>=9.5.1
  Using cached rich-13.5.3-py3-none-any.whl (239 kB)
Collecting typing-extensions
  Using cached typing_extensions-4.7.1-py3-none-any.whl (33 kB)
Collecting pyyaml
  Using cached PyYAML-6.0.1-cp37-cp37m-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (670 kB)
Collecting pathspec>=0.5.3
  Using cached pathspec-0.11.2-py3-none-any.whl (29 kB)
Requirement already satisfied: setuptools in ./.tox/py37-ansible30/lib/python3.7/site-packages (from yamllint==1.26.3->-r tox-requirements.txt (line 3)) (62.1.0)
Collecting cookiecutter>=1.7.3
  Using cached cookiecutter-2.3.1-py3-none-any.whl (39 kB)
Collecting subprocess-tee>=0.3.5
  Using cached subprocess_tee-0.3.5-py3-none-any.whl (8.0 kB)
Collecting click-help-colors>=0.9
  Using cached click_help_colors-0.9.2-py3-none-any.whl (5.5 kB)
Collecting paramiko<3,>=2.5.0
  Using cached paramiko-2.12.0-py2.py3-none-any.whl (213 kB)
Collecting ansible-compat>=0.5.0
  Using cached ansible_compat-1.0.0-py3-none-any.whl (16 kB)
Collecting Jinja2>=2.11.3
  Using cached Jinja2-3.1.2-py3-none-any.whl (133 kB)
Collecting pluggy<2.0,>=0.7.1
  Using cached pluggy-1.2.0-py3-none-any.whl (17 kB)
Collecting pyyaml
  Using cached PyYAML-5.4.1-cp37-cp37m-manylinux1_x86_64.whl (636 kB)
Collecting click<9,>=8.0
  Using cached click-8.1.7-py3-none-any.whl (97 kB)
Collecting cerberus!=1.3.3,!=1.3.4,>=1.3.1
  Using cached Cerberus-1.3.5-py3-none-any.whl (30 kB)
Collecting importlib-metadata
  Using cached importlib_metadata-6.7.0-py3-none-any.whl (22 kB)
Collecting ansible-base<2.11,>=2.10.5
  Using cached ansible_base-2.10.17-py3-none-any.whl
Collecting distro>=1.3.0
  Using cached distro-1.8.0-py3-none-any.whl (20 kB)
Collecting cryptography
  Using cached cryptography-41.0.4-cp37-abi3-manylinux_2_28_x86_64.whl (4.4 MB)
Collecting cached-property~=1.5
  Using cached cached_property-1.5.2-py2.py3-none-any.whl (7.6 kB)
Collecting python-slugify>=4.0.0
  Using cached python_slugify-8.0.1-py2.py3-none-any.whl (9.7 kB)
Collecting arrow
  Using cached arrow-1.2.3-py3-none-any.whl (66 kB)
Collecting requests>=2.23.0
  Using cached requests-2.31.0-py3-none-any.whl (62 kB)
Collecting binaryornot>=0.4.4
  Using cached binaryornot-0.4.4-py2.py3-none-any.whl (9.0 kB)
Collecting MarkupSafe>=2.0
  Using cached MarkupSafe-2.1.3-cp37-cp37m-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (25 kB)
Collecting six
  Using cached six-1.16.0-py2.py3-none-any.whl (11 kB)
Collecting bcrypt>=3.1.3
  Using cached bcrypt-4.0.1-cp36-abi3-manylinux_2_28_x86_64.whl (593 kB)
Collecting pynacl>=1.0.1
  Using cached PyNaCl-1.5.0-cp36-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.manylinux_2_24_x86_64.whl (856 kB)
Collecting zipp>=0.5
  Using cached zipp-3.15.0-py3-none-any.whl (6.8 kB)
Collecting markdown-it-py>=2.2.0
  Using cached markdown_it_py-2.2.0-py3-none-any.whl (84 kB)
Collecting pygments<3.0.0,>=2.13.0
  Using cached Pygments-2.16.1-py3-none-any.whl (1.2 MB)
Collecting ruamel.yaml.clib>=0.2.7
  Using cached ruamel.yaml.clib-0.2.7-cp37-cp37m-manylinux_2_17_x86_64.manylinux2014_x86_64.manylinux_2_24_x86_64.whl (500 kB)
Collecting bracex>=2.1.1
  Using cached bracex-2.3.post1-py3-none-any.whl (12 kB)
Collecting chardet>=3.0.2
  Using cached chardet-5.2.0-py3-none-any.whl (199 kB)
Collecting cffi>=1.12
  Using cached cffi-1.15.1-cp37-cp37m-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (427 kB)
Collecting mdurl~=0.1
  Using cached mdurl-0.1.2-py3-none-any.whl (10.0 kB)
Collecting text-unidecode>=1.3
  Using cached text_unidecode-1.3-py2.py3-none-any.whl (78 kB)
Collecting certifi>=2017.4.17
  Using cached certifi-2023.7.22-py3-none-any.whl (158 kB)
Collecting idna<4,>=2.5
  Using cached idna-3.4-py3-none-any.whl (61 kB)
Collecting urllib3<3,>=1.21.1
  Using cached urllib3-2.0.5-py3-none-any.whl (123 kB)
Collecting charset-normalizer<4,>=2
  Using cached charset_normalizer-3.2.0-cp37-cp37m-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (175 kB)
Collecting python-dateutil>=2.7.0
  Using cached python_dateutil-2.8.2-py2.py3-none-any.whl (247 kB)
Collecting pycparser
  Using cached pycparser-2.21-py2.py3-none-any.whl (118 kB)
Building wheels for collected packages: ansible
  Building wheel for ansible (setup.py): started
  Building wheel for ansible (setup.py): finished with status 'error'
  error: subprocess-exited-with-error

  × python setup.py bdist_wheel did not run successfully.
  │ exit code: 1
  ╰─> [12455 lines of output]
      running bdist_wheel
      running build
      running build_py
      package init file 'ansible_collections/__init__.py' not found (or not a regular file)
      running egg_info
      writing ansible.egg-info/PKG-INFO
      writing dependency_links to ansible.egg-info/dependency_links.txt
      writing requirements to ansible.egg-info/requires.txt
      writing top-level names to ansible.egg-info/top_level.txt
      reading manifest file 'ansible.egg-info/SOURCES.txt'
      reading manifest template 'MANIFEST.in'
      warning: no files found matching 'README'
      adding license file 'COPYING'
      writing manifest file 'ansible.egg-info/SOURCES.txt'
      creating build
      creating build/lib
      creating build/lib/ansible_collections
      creating build/lib/ansible_collections/amazon
      creating build/lib/ansible_collections/amazon/aws
      copying ansible_collections/amazon/aws/.gitignore -> build/lib/ansible_collections/amazon/aws
      copying ansible_collections/amazon/aws/CHANGELOG.rst -> build/lib/ansible_collections/amazon/aws
      copying ansible_collections/amazon/aws/CONTRIBUTING.md -> build/lib/ansible_collections/amazon/aws
      copying ansible_collections/amazon/aws/COPYING -> build/lib/ansible_collections/amazon/aws
      copying ansible_collections/amazon/aws/FILES.json -> build/lib/ansible_collections/amazon/aws
      copying ansible_collections/amazon/aws/MANIFEST.json -> build/lib/ansible_collections/amazon/aws
      copying ansible_collections/amazon/aws/README.md -> build/lib/ansible_collections/amazon/aws
      copying ansible_collections/amazon/aws/requirements.txt -> build/lib/ansible_collections/amazon/aws
      copying ansible_collections/amazon/aws/shippable.yml -> build/lib/ansible_collections/amazon/aws
      creating build/lib/ansible_collections/amazon/aws/.github
      copying ansible_collections/amazon/aws/.github/BOTMETA.yml -> build/lib/ansible_collections/amazon/aws/.github
      copying ansible_collections/amazon/aws/.github/settings.yml -> build/lib/ansible_collections/amazon/aws/.github
      creating build/lib/ansible_collections/amazon/aws/changelogs
      copying ansible_collections/amazon/aws/changelogs/changelog.yaml -> build/lib/ansible_collections/amazon/aws/changelogs
      copying ansible_collections/amazon/aws/changelogs/config.yaml -> build/lib/ansible_collections/amazon/aws/changelogs
      creating build/lib/ansible_collecti  Running setup.py clean for ansible
Failed to build ansible
Installing collected packages: text-unidecode, cached-property, zipp, urllib3, typing-extensions, tenacity, subprocess-tee, six, ruamel.yaml.clib, pyyaml, python-slugify, pygments, pycparser, pathspec, packaging, mdurl, MarkupSafe, lxml, jmespath, idna, distro, charset-normalizer, chardet, certifi, bracex, bcrypt, yamllint, wcmatch, selinux, ruamel.yaml, requests, python-dateutil, markdown-it-py, Jinja2, importlib-metadata, cffi, binaryornot, ansible-compat, rich, pynacl, pluggy, cryptography, click, cerberus, arrow, paramiko, enrich, cookiecutter, click-help-colors, ansible-base, molecule, ansible-lint, ansible, molecule_podman
  Running setup.py install for ansible: started
  Running setup.py install for ansible: finished with status 'error'
Unable to print the message and arguments - possible formatting error.
Use the traceback above to help find the error.
  ERROR: Failed building wheel for ansible
--- Logging error ---
Traceback (most recent call last):
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_internal/operations/build/wheel_legacy.py", line 87, in build_wheel_legacy
    spinner=spinner,
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_internal/utils/subprocess.py", line 224, in call_subprocess
    raise error
pip._internal.exceptions.InstallationSubprocessError: python setup.py bdist_wheel exited with 1

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_internal/utils/logging.py", line 172, in emit
    self.console.print(renderable, overflow="ignore", crop=False, style=style)
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_vendor/rich/console.py", line 1637, in print
    self._buffer.extend(new_segments)
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_vendor/rich/console.py", line 837, in __exit__
    self._exit_buffer()
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_vendor/rich/console.py", line 795, in _exit_buffer
    self._check_buffer()
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_vendor/rich/console.py", line 1930, in _check_buffer
    self.file.flush()
OSError: [Errno 28] No space left on device
Call stack:
  File "/usr/local/lib/python3.7/runpy.py", line 193, in _run_module_as_main
    "__main__", mod_spec)
  File "/usr/local/lib/python3.7/runpy.py", line 85, in _run_code
    exec(code, run_globals)
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/__main__.py", line 31, in <module>
    sys.exit(_main())
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_internal/cli/main.py", line 70, in main
    return command.main(cmd_args)
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_internal/cli/base_command.py", line 101, in main
    return self._main(args)
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_internal/cli/base_command.py", line 221, in _main
    return run(options, args)
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_internal/cli/base_command.py", line 167, in exc_logging_wrapper
    status = run_func(*args)
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_internal/cli/req_command.py", line 205, in wrapper
    return func(self, options, args)
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_internal/commands/install.py", line 366, in run
    global_options=[],
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_internal/wheel_builder.py", line 354, in build
    req.editable and req.permit_editable_wheels,
  File "/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/pip/_internal/wheel_builder.py", line 223, in _build_one
    req, output_dir, build_options, global_options, editable
  File "/oUnable to print the message and arguments - possible formatting error.
Use the traceback above to help find the error.
error: legacy-install-failure

× Encountered error while trying to install package.
╰─> ansible

note: This is an issue with the package mentioned above, not pip.
hint: See above for output from the failure.

=========================================================================== log end ============================================================================
ERROR: could not install deps [-rtox-requirements.txt, ansible<3.1]; v = InvocationError("/opt/vector-role/.tox/py37-ansible30/bin/python -m pip install -rtox-requirements.txt 'ansible<3.1'", 1)
py39-ansible210 create: /opt/vector-role/.tox/py39-ansible210
py39-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
ERROR: invocation failed (exit code 2), logfile: /opt/vector-role/.tox/py39-ansible210/log/py39-ansible210-1.log
========================================================================== log start ===========================================================================
Collecting ansible<3.0
  Using cached ansible-2.10.7.tar.gz (29.9 MB)
  Preparing metadata (setup.py): started
  Preparing metadata (setup.py): finished with status 'done'
Collecting selinux
  Downloading selinux-0.3.0-py2.py3-none-any.whl (4.2 kB)
Collecting ansible-lint==5.1.3
  Using cached ansible_lint-5.1.3-py3-none-any.whl (113 kB)
Collecting yamllint==1.26.3
  Using cached yamllint-1.26.3.tar.gz (126 kB)
  Preparing metadata (setup.py): started
  Preparing metadata (setup.py): finished with status 'done'
Collecting lxml
  Downloading lxml-4.9.3-cp39-cp39-manylinux_2_28_x86_64.whl (8.0 MB)
     ━━━━━━━━━━━━━━━━━━━━━                    4.2/8.0 MB 2.8 MB/s eta 0:00:02
ERROR: Exception:
Traceback (most recent call last):
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_vendor/urllib3/response.py", line 438, in _error_catcher
    yield
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_vendor/urllib3/response.py", line 519, in read
    data = self._fp.read(amt) if not fp_closed else b""
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_vendor/cachecontrol/filewrapper.py", line 94, in read
    self.__buf.write(data)
  File "/usr/local/lib/python3.9/tempfile.py", line 474, in func_wrapper
    return func(*args, **kwargs)
OSError: [Errno 28] No space left on device

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/cli/base_command.py", line 167, in exc_logging_wrapper
    status = run_func(*args)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/cli/req_command.py", line 205, in wrapper
    return func(self, options, args)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/commands/install.py", line 339, in run
    requirement_set = resolver.resolve(
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/resolution/resolvelib/resolver.py", line 94, in resolve
    result = self._result = resolver.resolve(
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_vendor/resolvelib/resolvers.py", line 481, in resolve
    state = resolution.resolve(requirements, max_rounds=max_rounds)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_vendor/resolvelib/resolvers.py", line 348, in resolve
    self._add_to_criteria(self.state.criteria, r, parent=None)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_vendor/resolvelib/resolvers.py", line 172, in _add_to_criteria
    if not criterion.candidates:
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_vendor/resolvelib/structs.py", line 151, in __bool__
    return bool(self._sequence)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/resolution/resolvelib/found_candidates.py", line 155, in __bool__
    return any(self)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/resolution/resolvelib/found_candidates.py", line 143, in <genexpr>
    return (c for c in iterator if id(c) not in self._incompatible_ids)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/resolution/resolvelib/found_candidates.py", line 47, in _iter_built
    candidate = func()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/resolution/resolvelib/factory.py", line 215, in _make_candidate_from_link
    self._link_candidate_cache[link] = LinkCandidate(
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/resolution/resolvelib/candidates.py", line 288, in __init__
    super().__init__(
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/resolution/resolvelib/candidates.py", line 158, in __init__
    self.dist = self._prepare()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/resolution/resolvelib/candidates.py", line 227, in _prepare
    dist = self._prepare_distribution()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/resolution/resolvelib/candidates.py", line 299, in _prepare_distribution
    return preparer.prepare_linked_requirement(self._ireq, parallel_builds=True)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/operations/prepare.py", line 487, in prepare_linked_requirement
    return self._prepare_linked_requirement(req, parallel_builds)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/operations/prepare.py", line 532, in _prepare_linked_requirement
    local_file = unpack_url(
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/operations/prepare.py", line 214, in unpack_url
    file = get_http_url(
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/operations/prepare.py", line 94, in get_http_url
    from_path, content_type = download(link, temp_dir.path)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/network/download.py", line 146, in __call__
    for chunk in chunks:
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/cli/progress_bars.py", line 304, in _rich_progress_bar
    for chunk in iterable:
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_internal/network/utils.py", line 63, in response_chunks
    for chunk in response.raw.stream(
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_vendor/urllib3/response.py", line 576, in stream
    data = self.read(amt=amt, decode_content=decode_content)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_vendor/urllib3/response.py", line 541, in read
    raise IncompleteRead(self._fp_bytes_read, self.length_remaining)
  File "/usr/local/lib/python3.9/contextlib.py", line 135, in __exit__
    self.gen.throw(type, value, traceback)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/pip/_vendor/urllib3/response.py", line 455, in _error_catcher
    raise ProtocolError("Connection broken: %r" % e, e)
pip._vendor.urllib3.exceptions.ProtocolError: ("Connection broken: OSError(28, 'No space left on device')", OSError(28, 'No space left on device'))
--- Logging error ---
WARNING: You are using pip version 22.0.4; however, version 23.2.1 is available.
You should consider upgrading via the '/opt/vector-role/.tox/py39-ansible210/bin/python -m pip install --upgrade pip' command.

=========================================================================== log end ============================================================================
ERROR: could not install deps [-rtox-requirements.txt, ansible<3.0]; v = InvocationError("/opt/vector-role/.tox/py39-ansible210/bin/python -m pip install -rtox-requirements.txt 'ansible<3.0'", 2)
py39-ansible30 create: /opt/vector-role/.tox/py39-ansible30
py39-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
ERROR: invocation failed (exit code 1), logfile: /opt/vector-role/.tox/py39-ansible30/log/py39-ansible30-1.log
========================================================================== log start ===========================================================================
Collecting ansible<3.1
  Using cached ansible-3.0.0.tar.gz (30.8 MB)
ERROR: Could not install packages due to an OSError: [Errno 28] No space left on device


=========================================================================== log end ============================================================================
ERROR: could not install deps [-rtox-requirements.txt, ansible<3.1]; v = InvocationError("/opt/vector-role/.tox/py39-ansible30/bin/python -m pip install -rtox-requirements.txt 'ansible<3.1'", 1)
___________________________________________________________________________ summary ____________________________________________________________________________
ERROR:   py37-ansible210: commands failed
ERROR:   py37-ansible30: could not install deps [-rtox-requirements.txt, ansible<3.1]; v = InvocationError("/opt/vector-role/.tox/py37-ansible30/bin/python -m pip install -rtox-requirements.txt 'ansible<3.1'", 1)
ERROR:   py39-ansible210: could not install deps [-rtox-requirements.txt, ansible<3.0]; v = InvocationError("/opt/vector-role/.tox/py39-ansible210/bin/python -m pip install -rtox-requirements.txt 'ansible<3.0'", 2)
ERROR:   py39-ansible30: could not install deps [-rtox-requirements.txt, ansible<3.1]; v = InvocationError("/opt/vector-role/.tox/py39-ansible30/bin/python -m pip install -rtox-requirements.txt 'ansible<3.1'", 1)

```

</detaild>

5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.

<-- Ответ

`molecule init scenario podman --driver-name podman`
```commandline
INFO     Initializing new scenario podman...

PLAY [Create a new molecule scenario] ******************************************

TASK [Check if destination folder exists] **************************************
changed: [localhost]

TASK [Check if destination folder is empty] ************************************
ok: [localhost]

TASK [Fail if destination folder is not empty] *********************************
skipping: [localhost]

TASK [Expand templates] ********************************************************
changed: [localhost] => (item=molecule/podman/destroy.yml)
changed: [localhost] => (item=molecule/podman/molecule.yml)
changed: [localhost] => (item=molecule/podman/converge.yml)
changed: [localhost] => (item=molecule/podman/create.yml)

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Initialized scenario in /opt/vector-role/molecule/podman successfully.
```

</details>  

---

4. Создайте облегчённый сценарий для molecule с драйвером molecule_podman. Проверьте его на исполнимость.

<-- Ответ

`molecule.yml`

```yaml
---
dependency:
  name: galaxy
driver:
  name: podman
platforms:
  - name: toxtest
    image: docker.io/aragast/netology:latest
    pre_build_image: true
    workdir: /opt/vector_role
    privileged: true
provisioner:
  name: ansible
verifier:
  name: ansible
scenario:
  test_sequence:
    - destroy
    - create
    - converge
    - verify
    - destroy

```

---
5. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.

<-- Ответ

```editorconfig

[tox]
minversion = 1.8
basepython = python3.6
envlist = py{37,39}-ansible{210,30}
skipsdist = true

[testenv]
passenv = *
deps =
    -r tox-requirements.txt
    ansible210: ansible<3.0
    ansible30: ansible<3.1
commands =
    {posargs:molecule test -s podman --destroy always}
```

---

6. Запустите команду `tox`. Убедитесь, что всё отработало успешно.

<-- Ответ

<details>  
<summary>подробнее</summary>

`docker run --privileged=True -v /opt/vector-role:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`

```commandline
[root@f1bc75a97b85 vector-role]# tox
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.5,certifi==2023.7.22,cffi==1.15.1,chardet==5.2.0,charset-normalizer==3.2.0,click==8.1.7,click-help-colors==0.9.2,cookiecutter==2.3.1,cryptography==41.0.4,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.7.0,Jinja2==3.1.2,jmespath==1.0.1,lxml==4.9.3,markdown-it-py==2.2.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.16.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.5.3,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.3,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.5,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='1511354860'
py37-ansible210 run-test: commands[0] | molecule test -s podman --destroy always
INFO     podman scenario test matrix: destroy, create, converge, verify, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/b984a4/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/b984a4/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/b984a4/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Populate instance config] ************************************************
ok: [localhost]

TASK [Dump instance config] ****************************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running podman > create

PLAY [Create] ******************************************************************

TASK [Populate instance config dict] *******************************************
skipping: [localhost]

TASK [Convert instance config dict to a list] **********************************
skipping: [localhost]

TASK [Dump instance config] ****************************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=0    changed=0    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0

INFO     Running podman > converge

PLAY [Converge] ****************************************************************

TASK [Replace this task with one that validates your content] ******************
ok: [toxtest] => {
    "msg": "This is the effective test"
}

PLAY RECAP *********************************************************************
toxtest                    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running podman > verify
INFO     Running Ansible Verifier
WARNING  Skipping, verify playbook not configured.
INFO     Verifier completed successfully.
INFO     Running podman > destroy

PLAY [Destroy] *****************************************************************

TASK [Populate instance config] ************************************************
ok: [localhost]

TASK [Dump instance config] ****************************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
py37-ansible30 create: /opt/vector-role/.tox/py37-ansible30
py37-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
py37-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.5,certifi==2023.7.22,cffi==1.15.1,chardet==5.2.0,charset-normalizer==3.2.0,click==8.1.7,click-help-colors==0.9.2,cookiecutter==2.3.1,cryptography==41.0.4,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.7.0,Jinja2==3.1.2,jmespath==1.0.1,lxml==4.9.3,markdown-it-py==2.2.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.16.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.5.3,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.3,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.5,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible30 run-test-pre: PYTHONHASHSEED='1511354860'
py37-ansible30 run-test: commands[0] | molecule test -s podman --destroy always
INFO     podman scenario test matrix: destroy, create, converge, verify, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/b984a4/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/b984a4/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/b984a4/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Populate instance config] ************************************************
ok: [localhost]

TASK [Dump instance config] ****************************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running podman > create

PLAY [Create] ******************************************************************

TASK [Populate instance config dict] *******************************************
skipping: [localhost]

TASK [Convert instance config dict to a list] **********************************
skipping: [localhost]

TASK [Dump instance config] ****************************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=0    changed=0    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0

INFO     Running podman > converge

PLAY [Converge] ****************************************************************

TASK [Replace this task with one that validates your content] ******************
ok: [toxtest] => {
    "msg": "This is the effective test"
}

PLAY RECAP *********************************************************************
toxtest                    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running podman > verify
INFO     Running Ansible Verifier
WARNING  Skipping, verify playbook not configured.
INFO     Verifier completed successfully.
INFO     Running podman > destroy

PLAY [Destroy] *****************************************************************

TASK [Populate instance config] ************************************************
ok: [localhost]

TASK [Dump instance config] ****************************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
py39-ansible210 create: /opt/vector-role/.tox/py39-ansible210
py39-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
py39-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==4.1.10,ansible-core==2.15.4,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.4,Cerberus==1.3.5,certifi==2023.7.22,cffi==1.15.1,chardet==5.2.0,charset-normalizer==3.2.0,click==8.1.7,click-help-colors==0.9.2,cookiecutter==2.3.1,cryptography==41.0.4,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-resources==5.0.7,Jinja2==3.1.2,jmespath==1.0.1,jsonschema==4.19.1,jsonschema-specifications==2023.7.1,lxml==4.9.3,markdown-it-py==3.0.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==2.0.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.3.0,pycparser==2.21,Pygments==2.16.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,referencing==0.30.2,requests==2.31.0,resolvelib==1.0.1,rich==13.5.3,rpds-py==0.10.3,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.3,text-unidecode==1.3,typing_extensions==4.8.0,urllib3==2.0.5,wcmatch==8.5,yamllint==1.26.3
py39-ansible210 run-test-pre: PYTHONHASHSEED='1511354860'
py39-ansible210 run-test: commands[0] | molecule test -s podman --destroy always
INFO     podman scenario test matrix: destroy, create, converge, verify, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/f5bcd7/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/f5bcd7/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/f5bcd7/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'
Traceback (most recent call last):
  File "/opt/vector-role/.tox/py39-ansible210/bin/molecule", line 8, in <module>
    sys.exit(main())
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1157, in __call__
    return self.main(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1078, in main
    rv = self.invoke(ctx)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1688, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1434, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 783, in invoke
    return __callback(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/decorators.py", line 33, in new_func
    return f(get_current_context(), *args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/test.py", line 159, in test
    base.execute_cmdline_scenarios(scenario_name, args, command_args, ansible_args)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 118, in execute_cmdline_scenarios
    execute_scenario(scenario)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 160, in execute_scenario
    execute_subcommand(scenario.config, action)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 149, in execute_subcommand
    return command(config).execute()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/logger.py", line 188, in wrapper
    rt = func(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/destroy.py", line 107, in execute
    self._config.provisioner.destroy()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/provisioner/ansible.py", line 705, in destroy
    pb.execute()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/provisioner/ansible_playbook.py", line 110, in execute
    self._config.driver.sanity_checks()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule_podman/driver.py", line 224, in sanity_checks
    if runtime.version < Version("2.10.0"):
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible_compat/runtime.py", line 393, in version
    self._version = parse_ansible_version(proc.stdout)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible_compat/config.py", line 44, in parse_ansible_version
    raise InvalidPrerequisiteError(msg)
ansible_compat.errors.InvalidPrerequisiteError: Unable to parse ansible cli version: ansible 2.10.17
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible
  executable location = /opt/vector-role/.tox/py39-ansible210/bin/ansible
  python version = 3.9.2 (default, Jun 13 2022, 19:42:33) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]

Keep in mind that only 2.12 or newer are supported.
ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible210/bin/molecule test -s podman --destroy always (exited with code 1)
py39-ansible30 create: /opt/vector-role/.tox/py39-ansible30
py39-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
py39-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==4.1.10,ansible-core==2.15.4,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.4,Cerberus==1.3.5,certifi==2023.7.22,cffi==1.15.1,chardet==5.2.0,charset-normalizer==3.2.0,click==8.1.7,click-help-colors==0.9.2,cookiecutter==2.3.1,cryptography==41.0.4,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-resources==5.0.7,Jinja2==3.1.2,jmespath==1.0.1,jsonschema==4.19.1,jsonschema-specifications==2023.7.1,lxml==4.9.3,markdown-it-py==3.0.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==2.0.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.3.0,pycparser==2.21,Pygments==2.16.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,referencing==0.30.2,requests==2.31.0,resolvelib==1.0.1,rich==13.5.3,rpds-py==0.10.3,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.3,text-unidecode==1.3,typing_extensions==4.8.0,urllib3==2.0.5,wcmatch==8.5,yamllint==1.26.3
py39-ansible30 run-test-pre: PYTHONHASHSEED='1511354860'
py39-ansible30 run-test: commands[0] | molecule test -s podman --destroy always
INFO     podman scenario test matrix: destroy, create, converge, verify, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/f5bcd7/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/f5bcd7/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/f5bcd7/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'
Traceback (most recent call last):
  File "/opt/vector-role/.tox/py39-ansible30/bin/molecule", line 8, in <module>
    sys.exit(main())
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 1157, in __call__
    return self.main(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 1078, in main
    rv = self.invoke(ctx)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 1688, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 1434, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 783, in invoke
    return __callback(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/decorators.py", line 33, in new_func
    return f(get_current_context(), *args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/test.py", line 159, in test
    base.execute_cmdline_scenarios(scenario_name, args, command_args, ansible_args)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/base.py", line 118, in execute_cmdline_scenarios
    execute_scenario(scenario)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/base.py", line 160, in execute_scenario
    execute_subcommand(scenario.config, action)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/base.py", line 149, in execute_subcommand
    return command(config).execute()
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/logger.py", line 188, in wrapper
    rt = func(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/destroy.py", line 107, in execute
    self._config.provisioner.destroy()
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/provisioner/ansible.py", line 705, in destroy
    pb.execute()
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/provisioner/ansible_playbook.py", line 110, in execute
    self._config.driver.sanity_checks()
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule_podman/driver.py", line 224, in sanity_checks
    if runtime.version < Version("2.10.0"):
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible_compat/runtime.py", line 393, in version
    self._version = parse_ansible_version(proc.stdout)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible_compat/config.py", line 44, in parse_ansible_version
    raise InvalidPrerequisiteError(msg)
ansible_compat.errors.InvalidPrerequisiteError: Unable to parse ansible cli version: ansible 2.10.17
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible
  executable location = /opt/vector-role/.tox/py39-ansible30/bin/ansible
  python version = 3.9.2 (default, Jun 13 2022, 19:42:33) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]

Keep in mind that only 2.12 or newer are supported.
ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible30/bin/molecule test -s podman --destroy always (exited with code 1)
___________________________________________________________________________ summary ____________________________________________________________________________
  py37-ansible210: commands succeeded
  py37-ansible30: commands succeeded
ERROR:   py39-ansible210: commands failed
ERROR:   py39-ansible30: commands failed

```

</details>

---

7. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Не забудьте указать в ответе теги решений Tox и Molecule заданий. В качестве решения пришлите ссылку на  ваш репозиторий и скриншоты этапов выполнения задания. 

<-- Ответ

https://github.com/Crankoman/vector-role

---