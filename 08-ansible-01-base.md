# Домашнее задание к занятию 1 «Введение в Ansible»

Файлы задания: https://github.com/Crankoman/devops/tree/main/ansible/01

## Основная часть

0. Установим ansible и docker-модуль для python
```commandline
pip3 install ansible
ansible-galaxy collection install community.docker
```

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.

<-- Ответ
Запускаем плейбук на окружении test `ansible-playbook site.yml -i inventory/test.yml`

```commandline
PLAY [Print os facts] *****************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************
ok: [localhost]

TASK [Print OS] ***********************************************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *********************************************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP ****************************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Ответ: `12` т.к. ОС - Ubuntu

---

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.

<-- Ответ

Меняем значение в файле `group_vars/all/examp.yml` `sed -i 's/12/all default fact/' group_vars/all/examp.yml`

Проверяем `ansible-playbook site.yml -i inventory/test.yml`

```commandline
PLAY [Print os facts] *****************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************
ok: [localhost]

TASK [Print OS] ***********************************************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *********************************************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP ****************************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

---

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.

<-- Ответ

Подготовим `docker-compose.yml` и запустим его `docker-compose up -d`
```yaml
version: '3.9'
services:
  centos7:
    image: pycontribs/centos:7
    container_name: centos7
    restart: unless-stopped
    entrypoint: "sleep infinity"

  ubuntu:
    image: pycontribs/ubuntu
    container_name: ubuntu
    restart: unless-stopped
    entrypoint: "sleep infinity"

```

---
 
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
 
<-- Ответ

Запускаем `ansible-playbook site.yml -i inventory/prod.yml`

```commandline
PLAY [Print os facts] *****************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ***********************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *********************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP ****************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

centos -> el

ubuntu -> deb

---

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
 
<-- Ответ
```commandline
sed -i 's/deb/deb default fact/' group_vars/deb/examp.yml
sed -i 's/el/el default fact/' group_vars/el/examp.yml
```

---

6. Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

<-- Ответ
```commandline
ansible-playbook site.yml -i inventory/prod.yml

PLAY [Print os facts] *****************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ***********************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *********************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ****************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
---
 
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.

<-- Ответ

`ansible-vault encrypt group_vars/deb/examp.yml`
```commandline
New Vault password:
Confirm New Vault password:
Encryption successful
root@4SER-1670916090:/opt/mnt-homeworks/08-ansible-01-base/playbook# cat group_vars/deb/examp.yml
$ANSIBLE_VAULT;1.1;AES256
32386163316632363834343332306539336561646161323034376535376134643064656632666462
6536333233643462623464613238623464653634386163330a383936343438643838663566343730
30316263323930313734343731623132636435653164313762623434646531656666343035353534
3166343432653030340a333635373431353332306239386338623832356430373563366334616636
61333865356537343665313463323336343831616633323263343536633333633962653865343361
3862643663653664333936396530336164316537343565323061
```

`ansible-vault encrypt group_vars/el/examp.yml`

```yaml
New Vault password:
Confirm New Vault password:
Encryption successful
root@4SER-1670916090:/opt/mnt-homeworks/08-ansible-01-base/playbook# cat group_vars/el/examp.yml
$ANSIBLE_VAULT;1.1;AES256
32363166346263613232373130643963613862393037313532386139666462333932303734353166
6531626136316563366138613536663566653161393930650a393666393437653638613138356362
32363164306661366235643936333266663232336165656365396536313066323331646562636435
6363643738396633320a313862376531636433633236333330383237663164323537386261336637
61313266326262306465646431623665623037323232363734363139346530646438326165323263
6430646632373162336665623036353738393934613063636437
```

---
 
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

<-- Ответ

`ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass`

```commandline
Vault password:

PLAY [Print os facts] ******************************************************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **********************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *****************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

---
 
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

<-- Ответ

`ansible-doc -t connection -l | grep control

```commandline
ansible.builtin.local        execute on controller
community.docker.nsenter     execute on host running controller container
```

выбираем `ansible.builtin.local`

---
 
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.

<-- Ответ

`inventory/prod.yml`

```yaml
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  
  local:
    hosts:
      localhost:
        ansible_connection: local
```

---

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

<-- Ответ

`ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass`

```commandline
Vault password:

PLAY [Print os facts] ******************************************************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **********************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP *****************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

---
 
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

<-- Ответ

Файлы задания: https://github.com/Crankoman/devops/tree/main/ansible/01

https://github.com/Crankoman/devops/blob/main/08-ansible-01-base.md

---

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.

<-- Ответ

`ansible-vault decrypt --ask-vault-password group_vars/deb/examp.yml group_vars/el/examp.yml`

```commandline
Vault password:
Decryption successful
```

`cat group_vars/deb/examp.yml group_vars/el/examp.yml`

```yaml
---
  some_fact: "deb default fact"
---
  some_fact: "el default fact"r
```

---
 
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.

<-- Ответ

`ansible-vault encrypt_string "PaSSw0rd" --name 'some_fact' | sed '1s/^/---\n/' > group_vars/all/examp.yml`

```commandline
New Vault password:
Confirm New Vault password:
```

`cat group_vars/all/examp.yml`

```yaml
---
some_fact: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          36366361376364323434663262303262316364613136653964613236323263343632363437303539
          3932333363616430343333643934643561653866316165610a323333373464313466656438356664
          66626661333565623964373666623236393137366562333432366162616135643064336261613437
          3530383136623035620a336461336533303965343235363236663965393663666163303865396263
          3637
```

---
 
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.

<-- Ответ

`ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass`

```commandline
Vault password:

PLAY [Print os facts] ******************************************************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **********************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}

PLAY RECAP *****************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

---

4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).

<-- Ответ

`inventory/prod.yml`

```yaml
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker

  local:
    hosts:
      localhost:
        ansible_connection: local

  fed:
    hosts:
      fedora:
        ansible_connection: docker
```

`group_vars/fedora/examp.yml`

```yaml
---
  some_fact: "fedora default fact"

```

`docker-compose.yml`

```yaml
version: '3.9'
services:
  centos7:
    image: pycontribs/centos:7
    container_name: centos7
    restart: unless-stopped
    entrypoint: "sleep infinity"

  ubuntu:
    image: pycontribs/ubuntu
    container_name: ubuntu
    restart: unless-stopped
    entrypoint: "sleep infinity"

  fedora:
    image: pycontribs/fedora
    container_name: fedora
    restart: unless-stopped
    entrypoint: "sleep infinity"
```

Проверяем `ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass`

```commandline
Vault password:

PLAY [Print os facts] ******************************************************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************************************************
ok: [localhost]
ok: [fedora]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [fedora] => {
    "msg": "Fedora"
}

TASK [Print fact] **********************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}
ok: [fedora] => {
    "msg": "PaSSw0rd"
}

PLAY RECAP *****************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
fedora                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```


---

5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.

<-- Ответ

`start.sh`

```bash
#/bin/bash
docker compose up -d
ansible-playbook -i inventory/prod.yml site.yml --vault-pass-file .pass_file
docker compose down
```

проверяем 

`chmod +x start.sh && ./start.sh`
```commandline
[+] Running 3/3
 ✔ Container ubuntu   Started                                                                                                                             12.0s
 ✔ Container fedora   Started                                                                                                                             11.9s
 ✔ Container centos7  Started                                                                                                                             11.8s

PLAY [Print os facts] ******************************************************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************************************************
ok: [localhost]
ok: [fedora]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [fedora] => {
    "msg": "Fedora"
}

TASK [Print fact] **********************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}
ok: [fedora] => {
    "msg": "PaSSw0rd"
}

PLAY RECAP *****************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
fedora                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[+] Running 4/4
 ✔ Container ubuntu          Removed                                                                                                                      10.7s
 ✔ Container fedora          Removed                                                                                                                      10.6s
 ✔ Container centos7         Removed                                                                                                                      10.6s
 ✔ Network playbook_default  Removed  
```

---

7. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

<-- Ответ

Файлы задания: https://github.com/Crankoman/devops/tree/main/ansible/01

https://github.com/Crankoman/devops/blob/main/08-ansible-01-base.md

---

