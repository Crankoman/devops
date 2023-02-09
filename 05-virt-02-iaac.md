# Домашнее задание к занятию "2. Применение принципов IaaC в работе с виртуальными машинами"

---

## Задача 1

- Опишите своими словами основные преимущества применения на практике IaaC паттернов.
- Какой из принципов IaaC является основополагающим?

<--
 - Основные преимущества - стабильность и управляемость инфрастуктуры, ее документируемость кодом конфигурации. Новые команды могут быстро понять как работает инфраструктура и начать в ней работать. Возможность быстро найти проблему, распространить изменения и откатиться при необходимости. 
 - Основополагающий принцип Iaac - идемпотентность, свойство получать одинаковый результат при применении повторной операции.
Т.е. получать такой же результат при много кратном выполнении, что и при однократном, например, вызывая API с одинаковыми параметрами получать одинаковый ответ, если метод идемпотентный (например удаление).

---

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

<--

- Чем Ansible выгодно отличается от других систем управление конфигурациями?

Chef и Puppet - работают по Pull методу, а так же используют мало распространенный Ruby

Saltstack - имеет сложную архитектуру взаимодействия систем из-за Push/Pull подхода

Terraform - использует более сложный для входа Golang и для работы с инфрастуктурой использует HCL. Это инструмент только для выполнения задач "инфраструктура как код". Только декларативный подход.

***Ansible*** - наиболее распространенный и универсальный инструмент, использующий Push метод и легкий в освоении Python. Возможен как декларативный, так и императивный подход. Конфигурационные файлы пишутся на YAML. Его поддерживает RadHat.


- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

Push - наиболее надежен и прост, так как предполагает централизованное управление конфигурацией и контроль выполнения команд на системах. Не требует дополнительного сервера для хранения состояний конфигураций.

---

## Задача 3

Установить на личный компьютер:

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://github.com/netology-code/devops-materials)
- [Terraform](https://github.com/netology-code/devops-materials/blob/master/README.md)
- Ansible

*Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.*

<--

```
test@test-VirtualBox:/tmp$ VBoxManage --version
7.0.6r155176

test@test-VirtualBox:/tmp$ vagrant -v
Vagrant 2.3.4

test@test-VirtualBox:/tmp$ ./terraform -v
Terraform v1.3.7
on linux_amd64

test@test-VirtualBox:~/ansible$ ansible --versio
ansible [core 2.14.2]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/test/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/test/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.10.6 (main, Nov 14 2022, 16:10:14) [GCC 11.3.0] (/usr/bin/python3)
  jinja version = 3.0.3
  libyaml = True

```

---

## Задача 4 

Воспроизвести практическую часть лекции самостоятельно.

- Создать виртуальную машину.
- Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
```
docker ps
```
Vagrantfile из лекции и код ansible находятся в [папке](https://github.com/netology-code/virt-homeworks/tree/virt-11/05-virt-02-iaac/src).

Примечание! Если Vagrant выдает вам ошибку:
```
URL: ["https://vagrantcloud.com/bento/ubuntu-20.04"]     
Error: The requested URL returned error: 404:
```

Выполните следующие действия:
1. Скачайте с [сайта](https://app.vagrantup.com/bento/boxes/ubuntu-20.04) файл-образ "bento/ubuntu-20.04"
2. Добавьте его в список образов Vagrant: "vagrant box add bento/ubuntu-20.04 <путь к файлу>"

<--

---