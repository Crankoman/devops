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

Версии

```
crank@pc:~$ VBoxManage --version
6.1.38_Ubuntur153438


crank@pc:~$ vagrant --version
Vagrant 2.2.19


crank@pc:~$ ./terraform -version
Terraform v1.3.7
on linux_amd64


crank@pc:~$ ansible --version
ansible 2.10.8
  config file = None
  configured module search path = ['/home/crank/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.10.6 (main, Nov 14 2022, 16:10:14) [GCC 11.3.0]
```
Запуск
<details>                         
    <summary>подробнее</summary>

```
root@pc:~/virt-homeworks/05-virt-02-iaac/src/vagrant# vagrant up
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> server1.netology: flag to force provisioning. Provisioners marked to run always will still run.
root@pc:~/virt-homeworks/05-virt-02-iaac/src/vagrant# vagrant halt
==> server1.netology: Attempting graceful shutdown of VM...
root@pc:~/virt-homeworks/05-virt-02-iaac/src/vagrant# vagrant destroy
    server1.netology: Are you sure you want to destroy the 'server1.netology' VM? [y/N] y
==> server1.netology: Destroying VM and associated drives...
root@pc:~/virt-homeworks/05-virt-02-iaac/src/vagrant# vagrant up
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Importing base box 'bento/ubuntu-20.04'...
==> server1.netology: Matching MAC address for NAT networking...
==> server1.netology: Setting the name of the VM: server1.netology
==> server1.netology: Clearing any previously set network interfaces...
==> server1.netology: Preparing network interfaces based on configuration...
    server1.netology: Adapter 1: nat
    server1.netology: Adapter 2: hostonly
==> server1.netology: Forwarding ports...
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)
==> server1.netology: Running 'pre-boot' VM customizations...
==> server1.netology: Booting VM...
==> server1.netology: Waiting for machine to boot. This may take a few minutes...
    server1.netology: SSH address: 127.0.0.1:2222
    server1.netology: SSH username: vagrant
    server1.netology: SSH auth method: private key
    server1.netology: Warning: Connection reset. Retrying...
    server1.netology: Warning: Remote connection disconnect. Retrying...
    server1.netology:
    server1.netology: Vagrant insecure key detected. Vagrant will automatically replace
    server1.netology: this with a newly generated keypair for better security.
    server1.netology:
    server1.netology: Inserting generated public key within guest...
    server1.netology: Removing insecure key from the guest if it's present...
    server1.netology: Key inserted! Disconnecting and reconnecting using new SSH key...
==> server1.netology: Machine booted and ready!
==> server1.netology: Checking for guest additions in VM...
==> server1.netology: Setting hostname...
==> server1.netology: Configuring and enabling network interfaces...
==> server1.netology: Mounting shared folders...
    server1.netology: /vagrant => /root/virt-homeworks/05-virt-02-iaac/src/vagrant
==> server1.netology: Running provisioner: ansible...
    server1.netology: Running ansible-playbook...

PLAY [nodes] *******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [server1.netology]

TASK [Create directory for ssh-keys] *******************************************
ok: [server1.netology]

TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************
changed: [server1.netology]

TASK [Checking DNS] ************************************************************
changed: [server1.netology]

TASK [Installing tools] ********************************************************
ok: [server1.netology] => (item=['git', 'curl'])

TASK [Installing docker] *******************************************************
changed: [server1.netology]

TASK [Add the current user to docker group] ************************************
changed: [server1.netology]

PLAY RECAP *********************************************************************
server1.netology           : ok=7    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
</details>
---

## Задача 4 

Воспроизвести практическую часть лекции самостоятельно.

- Создать виртуальную машину.
- Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды

<--

```
root@pc:~/virt-homeworks/05-virt-02-iaac/src/vagrant# vagrant ssh
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-110-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu 09 Feb 2023 04:59:46 PM UTC

  System load:  0.02               Users logged in:          0
  Usage of /:   13.0% of 30.63GB   IPv4 address for docker0: 172.17.0.1
  Memory usage: 22%                IPv4 address for eth0:    10.0.2.15
  Swap usage:   0%                 IPv4 address for eth1:    192.168.56.11
  Processes:    108


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Thu Feb  9 16:52:56 2023 from 10.0.2.2
vagrant@server1:~$ docker -v
Docker version 23.0.0, build e92dd87
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
---