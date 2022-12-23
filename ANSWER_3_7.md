# Домашнее задание к занятию "3.7. Компьютерные сети. Лекция 2"


## 1. Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?

<-
Windows `ipconfig`

    C:\Users\Crank> ipconfig /all
    
    Настройка протокола IP для Windows
    
       Имя компьютера  . . . . . . . . . : DESKTOP-586VINB
       Основной DNS-суффикс  . . . . . . :
       Тип узла. . . . . . . . . . . . . : Гибридный
       IP-маршрутизация включена . . . . : Нет
       WINS-прокси включен . . . . . . . : Нет
    
    Адаптер Ethernet Ethernet:
    
       DNS-суффикс подключения . . . . . :
       Описание. . . . . . . . . . . . . : VirtualBox Host-Only Ethernet Adapter
       Физический адрес. . . . . . . . . : 0A-00-27-00-00-12
       DHCP включен. . . . . . . . . . . : Нет
       Автонастройка включена. . . . . . : Да
       Локальный IPv6-адрес канала . . . : fe80::d437:368d:decd:ff09%18(Основной)
       IPv4-адрес. . . . . . . . . . . . : 192.168.56.1(Основной)
       Маска подсети . . . . . . . . . . : 255.255.255.0
       Основной шлюз. . . . . . . . . :
       IAID DHCPv6 . . . . . . . . . . . : 621412391
       DUID клиента DHCPv6 . . . . . . . : 00-01-00-01-2B-18-31-64-E0-0A-F6-8E-52-25
       NetBios через TCP/IP. . . . . . . . : Включен
    
    Адаптер беспроводной локальной сети Подключение по локальной сети* 9:
    
       Состояние среды. . . . . . . . : Среда передачи недоступна.
       DNS-суффикс подключения . . . . . :
       Описание. . . . . . . . . . . . . : Microsoft Wi-Fi Direct Virtual Adapter
       Физический адрес. . . . . . . . . : E2-0A-F6-8E-52-25
       DHCP включен. . . . . . . . . . . : Да
       Автонастройка включена. . . . . . : Да
    
    Адаптер беспроводной локальной сети Подключение по локальной сети* 10:
    
       Состояние среды. . . . . . . . : Среда передачи недоступна.
       DNS-суффикс подключения . . . . . :
       Описание. . . . . . . . . . . . . : Microsoft Wi-Fi Direct Virtual Adapter #2
       Физический адрес. . . . . . . . . : F2-0A-F6-8E-52-25
       DHCP включен. . . . . . . . . . . : Да
       Автонастройка включена. . . . . . : Да
    
    Адаптер беспроводной локальной сети Беспроводная сеть:
    
       DNS-суффикс подключения . . . . . :
       Описание. . . . . . . . . . . . . : Realtek RTL8852AE WiFi 6 802.11ax PCIe Adapter
       Физический адрес. . . . . . . . . : E0-0A-F6-8E-52-25
       DHCP включен. . . . . . . . . . . : Да
       Автонастройка включена. . . . . . : Да
       Локальный IPv6-адрес канала . . . : fe80::9569:63b0:afb1:f2f9%6(Основной)
       IPv4-адрес. . . . . . . . . . . . : 192.168.1.12(Основной)
       Маска подсети . . . . . . . . . . : 255.255.0.0
       Аренда получена. . . . . . . . . . : 18 декабря 2022 г. 22:08:47
       Срок аренды истекает. . . . . . . . . . : 22 декабря 2022 г. 22:05:05
       Основной шлюз. . . . . . . . . : fe80::1%6
                                           192.168.1.1
       DHCP-сервер. . . . . . . . . . . : 192.168.1.1
       IAID DHCPv6 . . . . . . . . . . . : 367004406
       DUID клиента DHCPv6 . . . . . . . : 00-01-00-01-2B-18-31-64-E0-0A-F6-8E-52-25
       DNS-серверы. . . . . . . . . . . : 77.88.8.8
                                           8.8.8.8
                                           8.8.4.4
       NetBios через TCP/IP. . . . . . . . : Включен

Linux `ifconfig`

ifconfig -a

    ifconfig -a
    ens3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
            inet 194.87.218.192  netmask 255.255.255.0  broadcast 194.87.218.255
            inet6 fe80::5054:ff:fe1f:5241  prefixlen 64  scopeid 0x20<link>
            ether 52:54:00:1f:52:41  txqueuelen 1000  (Ethernet)
            RX packets 43462465  bytes 2708322243 (2.7 GB)
            RX errors 0  dropped 5  overruns 0  frame 0
            TX packets 189756  bytes 10767602 (10.7 MB)
            TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
    
    lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
            inet 127.0.0.1  netmask 255.0.0.0
            inet6 ::1  prefixlen 128  scopeid 0x10<host>
            loop  txqueuelen 1000  (Local Loopback)
            RX packets 324  bytes 30114 (30.1 KB)
            RX errors 0  dropped 0  overruns 0  frame 0
            TX packets 324  bytes 30114 (30.1 KB)
            TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


----
## 2. Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?

<-
Протокол ***Link Layer Discovery Protocol (LLDP)***  https://en.wikipedia.org/wiki/Link_Layer_Discovery_Protocol

lldpcli, lldpctl - контроль сервиса lldpd

Информация о пакете ***lldpd***

    apt show lldpd
    Package: lldpd
    Version: 1.0.13-1
    Priority: optional
    Section: universe/net
    Origin: Ubuntu
    Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
    Original-Maintainer: Vincent Bernat <bernat@debian.org>
    Bugs: https://bugs.launchpad.net/ubuntu/+filebug
    Installed-Size: 558 kB
    Pre-Depends: init-system-helpers (>= 1.54~)
    Depends: libbsd0 (>= 0.6.0), libc6 (>= 2.34), libcap2 (>= 1:2.10), libevent-2.1-7 (>= 2.1.8-stable), libreadline8 (>= 6.0), libsnmp40 (>= 5.9+dfsg), libxml2 (>= 2.7.4), adduser, lsb-base
    Suggests: snmpd
    Homepage: https://lldpd.github.io
    Download-Size: 193 kB
    APT-Manual-Installed: yes
    APT-Sources: http://ru.archive.ubuntu.com/ubuntu jammy/universe amd64 Packages
    Description: implementation of IEEE 802.1ab (LLDP)
     LLDP is an industry standard protocol designed to supplant
     proprietary Link-Layer protocols such as Extreme's EDP (Extreme
     Discovery Protocol) and CDP (Cisco Discovery Protocol). The goal of
     LLDP is to provide an inter-vendor compatible mechanism to deliver
     Link-Layer notifications to adjacent network devices.
     .
     This implementation provides LLDP sending and reception, supports
     VLAN and includes an SNMP subagent that can interface to an SNMP
     agent through AgentX protocol.
     .
     This daemon is also able to deal with CDP, SONMP, FDP and EDP
     protocol. It also handles LLDP-MED extension.



----
## 3. Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.
<-
Технология ***virtual local area network (VLAN)*** https://en.wikipedia.org/wiki/VLAN

Описание пакета lan

    apt show vlan
    Package: vlan
    Version: 2.0.5ubuntu5
    Priority: extra
    Section: universe/misc
    Origin: Ubuntu
    Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
    Original-Maintainer: Willem van den Akker <wvdakker@wilsoft.nl>
    Bugs: https://bugs.launchpad.net/ubuntu/+filebug
    Installed-Size: 51.2 kB
    Depends: iproute2
    Download-Size: 10.4 kB
    APT-Manual-Installed: yes
    APT-Sources: http://ru.archive.ubuntu.com/ubuntu jammy/universe amd64 Packages
    Description: ifupdown integration for vlan configuration
     This package contains integration scripts for configuring vlan
     interfaces via ifupdown (/etc/network/interfaces).
     For further details see vlan-interfaces(5) man page in this package.
     .
     Please note that these integration scripts only supports a limited
     set of interface naming schemes, which means you might be better
     off with writing your own ifupdown hooks using ip(route2)
     directly in /etc/network/interfaces rather than using this package.
     .
     It currently also ships a wrapper script for backwards compatibility
     called vconfig, that replaces the old deprecated vconfig program
     with translations to ip(route2) commands.
     This compatibility shim might be dropped in future releases, please
     use ip(route2) commands directly.
     .
     Your kernel needs vlan support for this to work, see "modinfo 8021q".

Есть следующие команды: `vconfig` (устаревшая), `ip`, настройка с попошью netplan

    ip link add link eth1 name eth1.10 type vlan id 10
Пример конфига

    network:
      ethernets:
        enp1s0:
          dhcp4: false
          addresses:
            - 192.168.122.201/24
          gateway4: 192.168.122.1
          nameservers:
              addresses: [8.8.8.8, 1.1.1.1]
        vlans:
            enp1s0.100:
                id: 100
                link: enp1s0
                addresses: [192.168.100.2/24]

----
## 4. Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.
<-
Какие типы агрегации интерфейсов есть в Linux

***Team и Bonding***

Какие опции есть для балансировки нагрузки

 - 802.3ad - (dynamic link aggregation)
 - active-backup
 - broadcast
 - balance-alb - (adaptive load balancing)
 - balance-rr - (round-robin)
 - balance-tlb - (adaptive transmit load balancing)
 - balance-xor

пример конфига /etc/netplan/01-netcfg.yaml

    network:
      version: 2
      ethernets:
        eth0:
          dhcp4: true
        eth1:
          dhcp4: no
        eth2:
          dhcp4: no
      bonds:
       bond0:
        interfaces: [eth1, eth2]
        parameters:
          mode: balance-alb

----
## 5. Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.
<-
Сколько IP адресов в сети с маской /29

***2^(32-29) = 8 комбинаций***  из них Один адрес  для сети и один для broadcast запроса.

Сколько /29 подсетей можно получить из сети с маской /24

***32 подсети***

Пример /29 подсетей внутри сети 10.10.10.0/24

    ipcalc -b 10.10.10.0/29
    Address:   10.10.10.0
    Netmask:   255.255.255.248 = 29
    Wildcard:  0.0.0.7
    =>
    Network:   10.10.10.0/29
    HostMin:   10.10.10.1
    HostMax:   10.10.10.6
    Broadcast: 10.10.10.7
    Hosts/Net: 6                     Class A, Private Internet


----
## 6. Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.
<-
     
    ipcalc -b 100.64.0.0/10 -s 51
    Address:   100.64.0.0
    Netmask:   255.192.0.0 = 10
    Wildcard:  0.63.255.255
    =>
    Network:   100.64.0.0/10
    HostMin:   100.64.0.1
    HostMax:   100.127.255.254
    Broadcast: 100.127.255.255
    Hosts/Net: 4194302               Class A
    
    1. Requested size: 51 hosts
    Netmask:   255.255.255.192 = 26
    Network:   100.64.0.0/26
    HostMin:   100.64.0.1
    HostMax:   100.64.0.62
    Broadcast: 100.64.0.63
    Hosts/Net: 62                    Class A
    
    Needed size:  64 addresses.
    Used network: 100.64.0.0/26
    Unused:
    100.64.0.64/26
    100.64.0.128/25
    100.64.1.0/24
    100.64.2.0/23
    100.64.4.0/22
    100.64.8.0/21
    100.64.16.0/20
    100.64.32.0/19
    100.64.64.0/18
    100.64.128.0/17
    100.65.0.0/16
    100.66.0.0/15
    100.68.0.0/14
    100.72.0.0/13
    100.80.0.0/12
    100.96.0.0/11


----
## 7. Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?
<-
1. Windows `arp`

1.1. Windows. Вывести таблицу `arp -a`

    Интерфейс: 192.168.1.12 --- 0x6
      адрес в Интернете      Физический адрес      Тип
      192.168.1.1           98-00-6a-7c-a6-44     динамический
      192.168.255.255       ff-ff-ff-ff-ff-ff     статический
      224.0.0.2             01-00-5e-00-00-02     статический
      224.0.0.22            01-00-5e-00-00-16     статический
      224.0.0.251           01-00-5e-00-00-fb     статический
      224.0.0.252           01-00-5e-00-00-fc     статический
      224.0.1.127           01-00-5e-00-01-7f     статический
      233.233.233.233       01-00-5e-69-e9-e9     статический
      239.255.255.250       01-00-5e-7f-ff-fa     статический
      239.255.255.253       01-00-5e-7f-ff-fd     статический
      255.255.255.255       ff-ff-ff-ff-ff-ff     статический
    
    Интерфейс: 192.168.56.1 --- 0x12
      адрес в Интернете      Физический адрес      Тип
      192.168.56.255        ff-ff-ff-ff-ff-ff     статический
      224.0.0.2             01-00-5e-00-00-02     статический
      224.0.0.22            01-00-5e-00-00-16     статический
      224.0.0.251           01-00-5e-00-00-fb     статический
      224.0.0.252           01-00-5e-00-00-fc     статический
      224.0.1.127           01-00-5e-00-01-7f     статический
      233.233.233.233       01-00-5e-69-e9-e9     статический
      239.255.255.250       01-00-5e-7f-ff-fa     статический
      239.255.255.253       01-00-5e-7f-ff-fd     статический

1.2. Windows. Очистить ARP кешa `arp -d *`

    C:\Windows\System32>arp -d *
    
    C:\Windows\System32>arp -a
    
    Интерфейс: 192.168.1.12 --- 0x6
      адрес в Интернете      Физический адрес      Тип
      192.168.1.1           98-00-6a-7c-a6-44     динамический
      224.0.0.2             01-00-5e-00-00-02     статический
      224.0.0.22            01-00-5e-00-00-16     статический
    
    Интерфейс: 192.168.56.1 --- 0x12
      адрес в Интернете      Физический адрес      Тип
      224.0.0.22            01-00-5e-00-00-16     статический

1.3. Windows. Из ARP таблицы удалить только один нужный IP `arp -d 192.168.1.1`


2. Linux `ip neigh`

2.1. Linux. Вывести таблицу `ip neigh show`

    ip neigh show
    194.87.218.1 dev ens3 lladdr 00:11:0a:68:1a:94 REACHABLE

2.2. Linux. Очистить ARP кеш `ip neigh flush all`


2.3. Linux. Из ARP таблицы удалить только один нужный IP `ip neigh del 192.168.1.1 dev ens3`

----
