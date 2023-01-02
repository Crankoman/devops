# Домашнее задание к занятию "3.8. Компьютерные сети. Лекция 3"


## 1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP

    telnet route-views.routeviews.org
    Username: rviews
    show ip route x.x.x.x/32
    show bgp x.x.x.x/32

<-

Уточняем свой IP

vagrant@vagrant:~$ curl -w '\n'  http://ident.me
62.213.85.154

Подключаемся к route-views.routeviews.org

    telnet route-views.routeviews.org
    Trying 128.223.51.103...
    Connected to route-views.routeviews.org.
    Escape character is '^]'.
    C
    **********************************************************************
    
                        RouteViews BGP Route Viewer
                        route-views.routeviews.org
    
     route views data is archived on http://archive.routeviews.org
    
     This hardware is part of a grant by the NSF.
     Please contact help@routeviews.org if you have questions, or
     if you wish to contribute your view.
    
     This router has views of full routing tables from several ASes.
     The list of peers is located at http://www.routeviews.org/peers
     in route-views.oregon-ix.net.txt
    
     NOTE: The hardware was upgraded in August 2014.  If you are seeing
     the error message, "no default Kerberos realm", you may want to
     in Mac OS X add "default unset autologin" to your ~/.telnetrc
    
     To login, use the username "rviews".
    
     **********************************************************************
    
    User Access Verification
    
    Username: rviews

Выполняем show ip route 62.213.*.*

    route-views>show ip route 62.213.*.*
    Routing entry for 62.213.*.*/24
      Known via "bgp 6447", distance 20, metric 0
      Tag 6939, type external
      Last update from 64.71.*.* 1w5d ago
      Routing Descriptor Blocks:
      * 64.71.137.241, from 64.71.137.241, 1w5d ago
          Route metric is 0, traffic share count is 1
          AS Hops 3
          Route tag 6939
          MPLS label: none

Выполняем show bgp 62.213.*.*

<details>
<summary>Подробнее</summary>

    route-views>show bgp 62.213.*.*
    BGP routing table entry for 62.213.85.0/24, version 2607270963
    Paths: (21 available, best #7, table default)
      Not advertised to any peer
      Refresh Epoch 1
      3333 9002 202984 25227, (aggregated by 25227 172.20.1.24)
        193.0.0.56 from 193.0.0.56 (193.0.0.56)
          Origin IGP, localpref 100, valid, external
          path 7FE126503C88 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      20912 3257 9002 202984 25227, (aggregated by 25227 172.20.1.24)
        212.66.96.126 from 212.66.96.126 (212.66.96.126)
          Origin IGP, localpref 100, valid, external
          Community: 3257:8052 3257:50001 3257:54900 3257:54901 20912:65004 65535:65284
          path 7FE0E8EDCC58 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      53767 174 3216 202984 25227, (aggregated by 25227 172.20.1.24)
        162.251.163.2 from 162.251.163.2 (162.251.162.3)
          Origin incomplete, localpref 100, valid, external
          Community: 174:21101 174:22010 53767:5000
          path 7FE174646498 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      49788 12552 9002 202984 25227, (aggregated by 25227 172.20.1.24)
        91.218.184.60 from 91.218.184.60 (91.218.184.60)
          Origin IGP, localpref 100, valid, external
          Community: 12552:10000 12552:14000 12552:14100 12552:14101 12552:24000
          Extended Community: 0x43:100:1
          path 7FE12B5609A8 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      3356 9002 202984 25227, (aggregated by 25227 172.20.1.24)
        4.68.4.46 from 4.68.4.46 (4.69.184.201)
          Origin IGP, metric 0, localpref 100, valid, external
          Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065
          path 7FE16E22A548 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      3267 31500 202984 25227, (aggregated by 25227 172.20.1.24)
        194.85.40.15 from 194.85.40.15 (185.141.126.1)
          Origin incomplete, metric 0, localpref 100, valid, external
          path 7FE121512798 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      6939 202984 25227, (aggregated by 25227 172.20.1.24)
        64.71.137.241 from 64.71.137.241 (216.218.252.164)
          Origin IGP, localpref 100, valid, external, best
          path 7FE0476D81F8 RPKI State not found
          rx pathid: 0, tx pathid: 0x0
      Refresh Epoch 1
      3561 3910 3356 3216 202984 25227, (aggregated by 25227 172.20.1.24)
        206.24.210.80 from 206.24.210.80 (206.24.210.80)
          Origin IGP, localpref 100, valid, external
          path 7FE12595B9D8 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      7018 3356 3216 202984 25227, (aggregated by 25227 172.20.1.24)
        12.0.1.63 from 12.0.1.63 (12.0.1.63)
          Origin IGP, localpref 100, valid, external
          Community: 7018:5000 7018:37232
          path 7FE04FDA1D50 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      701 1273 3216 202984 25227, (aggregated by 25227 172.20.1.24)
        137.39.3.55 from 137.39.3.55 (137.39.3.55)
          Origin incomplete, localpref 100, valid, external
          path 7FE1793FFB98 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      8283 31500 202984 25227, (aggregated by 25227 172.20.1.24)
        94.142.247.3 from 94.142.247.3 (94.142.247.3)
          Origin incomplete, metric 0, localpref 100, valid, external
          Community: 8283:1 8283:101
          unknown transitive attribute: flag 0xE0 type 0x20 length 0x24
            value 0000 205B 0000 0000 0000 0001 0000 205B
                  0000 0005 0000 0001 0000 205B 0000 0008
                  0000 001A
          path 7FE1296CA550 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      57866 9002 202984 25227, (aggregated by 25227 172.20.1.24)
        37.139.139.17 from 37.139.139.17 (37.139.139.17)
          Origin IGP, metric 0, localpref 100, valid, external
          Community: 9002:0 9002:64667 57866:100 65100:9002 65103:1 65104:31
          unknown transitive attribute: flag 0xE0 type 0x20 length 0x30
            value 0000 E20A 0000 0064 0000 232A 0000 E20A
                  0000 0065 0000 0064 0000 E20A 0000 0067
                  0000 0001 0000 E20A 0000 0068 0000 001F
    
          path 7FE026AA58D8 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      3549 3356 3216 202984 25227, (aggregated by 25227 172.20.1.24)
        208.51.134.254 from 208.51.134.254 (67.16.168.191)
          Origin IGP, metric 0, localpref 100, valid, external
          Community: 0:200 3216:2001 3216:2003 3216:4477 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067 3549:2581 3549:30840 8631:50 12389:2800 20485:50002 47541:21 47541:2101 47542:21 47542:2101
          path 7FE0F809AFE0 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      101 3356 9002 202984 25227, (aggregated by 25227 172.20.1.24)
        209.124.176.223 from 209.124.176.223 (209.124.176.223)
          Origin IGP, localpref 100, valid, external
          Community: 101:20100 101:20110 101:22100 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065
          Extended Community: RT:101:22100
          path 7FE14FF2F408 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 2
      2497 3216 202984 25227, (aggregated by 25227 172.20.1.24)
        202.232.0.2 from 202.232.0.2 (58.138.96.254)
          Origin incomplete, localpref 100, valid, external
          path 7FE0BC096BA8 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      4901 6079 9002 202984 25227, (aggregated by 25227 172.20.1.24)
        162.250.137.254 from 162.250.137.254 (162.250.137.254)
          Origin IGP, localpref 100, valid, external
          Community: 65000:10100 65000:10300 65000:10400
          path 7FE11EC1EA28 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      20130 6939 202984 25227, (aggregated by 25227 172.20.1.24)
        140.192.8.16 from 140.192.8.16 (140.192.8.16)
          Origin IGP, localpref 100, valid, external
          path 7FE0E7DE5E58 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      852 31133 35598 202984 202984 25227, (aggregated by 25227 172.20.1.24)
        154.11.12.212 from 154.11.12.212 (96.1.209.43)
          Origin IGP, metric 0, localpref 100, valid, external
          path 7FE1699233D0 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      3303 6939 202984 25227, (aggregated by 25227 172.20.1.24)
        217.192.89.50 from 217.192.89.50 (138.187.128.158)
          Origin IGP, localpref 100, valid, external
          Community: 3303:1006 3303:1021 3303:1030 3303:3067 6939:7337 6939:8752 6939:9002
          path 7FDFFBD65808 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      1351 6939 202984 25227, (aggregated by 25227 172.20.1.24)
        132.198.255.253 from 132.198.255.253 (132.198.255.253)
          Origin IGP, localpref 100, valid, external
          path 7FE0B1344B88 RPKI State not found
          rx pathid: 0, tx pathid: 0
      Refresh Epoch 1
      3257 9002 202984 25227, (aggregated by 25227 172.20.1.24)
        89.149.178.10 from 89.149.178.10 (213.200.83.26)
          Origin IGP, metric 10, localpref 100, valid, external
          Community: 3257:8052 3257:50001 3257:54900 3257:54901 65535:65284
          path 7FE125364BC8 RPKI State not found
          rx pathid: 0, tx pathid: 0
</details>

----
## 2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

<-

Загружаем модуль ядра

    modprobe -v dummy
    insmod /lib/modules/5.4.0-135-generic/kernel/drivers/net/dummy.ko numdummies=0

Проверяем что модуль загрузился

    lsmod | grep dummy
    dummy                  16384  0

Создаем интерфейс

    ip link add dev dum0 type dummy

Назначим IP-адрес 

    ip addr add 192.168.121.1/24 dev dum0

Включаем интерфейс

    ip link set dev dum0 up
    ifconfig dum0
    dum0: flags=195<UP,BROADCAST,RUNNING,NOARP>  mtu 1500
            inet 192.168.121.1  netmask 255.255.255.0  broadcast 0.0.0.0
            inet6 fe80::4b6:9bff:fe4c:713c  prefixlen 64  scopeid 0x20<link>
            ether 06:b6:9b:4c:71:3c  txqueuelen 1000  (Ethernet)
            RX packets 0  bytes 0 (0.0 B)
            RX errors 0  dropped 0  overruns 0  frame 0
            TX packets 10  bytes 700 (700.0 B)
            TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

Добавляем статические маршруты

    ip route add 192.168.0.0/16 via 192.168.121.1 dev dum0
    ip route add 10.0.2.15 via 192.168.121.1  dev dum0

Проверяем таблицу маршрутизации

    ip route show
    default via 212.193.48.1 dev eth0 proto dhcp src 212.193.51.117 metric 100
    10.0.2.15 via 192.168.121.1 dev dum0
    172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown
    172.18.0.0/16 dev br-927cc8275356 proto kernel scope link src 172.18.0.1
    192.168.0.0/16 via 192.168.121.1 dev dum0
    192.168.121.0/24 dev dum0 proto kernel scope link src 192.168.121.1
    212.193.48.0/21 dev eth0 proto kernel scope link src 212.193.51.117
    212.193.48.1 dev eth0 proto dhcp scope link src 212.193.51.117 metric 100


----
## 3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

<-

Используем `ss`, ключ `-l` - Показывать слушающие сокеты, ключ `-n` - Не раскрывать имена служб, ключ `-t` - Показывать только сокеты TCP, ключ `-p` - Показывать процесс, использующий сокет.

    root@260831:~# ss -lntp
    State       Recv-Q      Send-Q           Local Address:Port             Peer Address:Port      Process
    LISTEN      0           4096                   0.0.0.0:3306                  0.0.0.0:*          users:(("docker-proxy",pid=126800,fd=4))
    LISTEN      0           511                    0.0.0.0:80                    0.0.0.0:*          users:(("nginx",pid=264142,fd=11),("nginx",pid=789,fd=11))
    LISTEN      0           4096             127.0.0.53%lo:53                    0.0.0.0:*          users:(("systemd-resolve",pid=640,fd=13))
    LISTEN      0           128                    0.0.0.0:3223                  0.0.0.0:*          users:(("sshd",pid=763,fd=3))
    LISTEN      0           511                    0.0.0.0:443                   0.0.0.0:*          users:(("nginx",pid=264142,fd=13),("nginx",pid=789,fd=13))
    LISTEN      0           4096                      [::]:3306                     [::]:*          users:(("docker-proxy",pid=126812,fd=4))
    LISTEN      0           511                       [::]:80                       [::]:*          users:(("nginx",pid=264142,fd=12),("nginx",pid=789,fd=12))
    LISTEN      0           128                       [::]:3223                     [::]:*          users:(("sshd",pid=763,fd=4))
    LISTEN      0           511                       [::]:443                      [::]:*          users:(("nginx",pid=264142,fd=14),("nginx",pid=789,fd=14))

:3306 - mysql (запущен через Docker)
:80 - http, nginx
:3223 - ssh, openssh
:443 - https, nginx
:53 - dns


----
## 4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

<-
Используем `ss`, ключ `-l` - Показывать слушающие сокеты, ключ `-n` - Не раскрывать имена служб, ключ `-u` - Показывать только сокеты UDP, ключ `-p` - Показывать процесс, использующий сокет.

    ss -lnup
    UNCONN        0             0                     127.0.0.53%lo:53                        0.0.0.0:*            users:(("systemd-resolve",pid=640,fd=12))
    UNCONN        0             0                           0.0.0.0:1701                      0.0.0.0:*            users:(("xl2tpd",pid=756,fd=3))

:1701 - l2tp, vpn-сервер
:53 - dns
----
## 5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

<-
![](/img/diagL3.png)
----
## 6. Установите Nginx, настройте в режиме балансировщика TCP или UDP.

<-
Добавляем в Vagrant `config.vm.network "public_network", bridge: "Realtek RTL8852AE WiFi 6 802.11ax PCIe Adapter"` что бы получить доступ к ВМ с хостовой машины

Будем балансировать TCP трафик на 80 порт.

Устанавливаем на всех ВМ nginx `sudo apt install nginx`

172.28.128.10 (192.168.1.14)  будет балансировщиком, а 172.28.128.60 (192.168.1.17) и 172.28.128.90 (192.168.1.18) балансируемыми хостами.

На 172.28.128.60 и 172.28.128.90 меняем файл по-умолчанию на содержимое вывода `ip a` - выполняем `ip a > /var/www/html/index.nginx-debian.html` чтобы различать какой сервер вернул данные

Меняем конфиг на балансировщике в`/etc/nginx/sites-enabled/default`
````
# не указываем алгортм балансировки, по-умолчанию Round Robin
upstream balancer{
    server 172.28.128.60;
    server 172.28.128.90;
}
   # настройка обратного прокси
server {
    listen 80 default_server;
    location / {
        proxy_pass http://balancer;
    }
}
````

Применяем новый кофиг `service nginx reload`

Проверяем с хостовой машины так как алгоритм Round Robin, то достаточно два раза запросить и получим ответ от каждого из серверов

Ответил 172.28.128.60 (192.168.1.17)

````
curl 192.168.1.14
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1186  100  1186    0     0   299k      0 --:--:-- --:--:-- --:--:--  386k1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:a2:6b:fd brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
       valid_lft 85237sec preferred_lft 85237sec
    inet6 fe80::a00:27ff:fea2:6bfd/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 08:00:27:e2:05:34 brd ff:ff:ff:ff:ff:ff
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:f6:17:12 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.17/16 brd 192.168.255.255 scope global dynamic eth2
       valid_lft 85239sec preferred_lft 85239sec
    inet6 fe80::a00:27ff:fef6:1712/64 scope link
       valid_lft forever preferred_lft forever
````

Ответил 172.28.128.90 (192.168.1.18)

````
curl 192.168.1.14
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1186  100  1186    0     0   232k      0 --:--:-- --:--:-- --:--:--  289k1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:a2:6b:fd brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
       valid_lft 85284sec preferred_lft 85284sec
    inet6 fe80::a00:27ff:fea2:6bfd/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 08:00:27:69:2e:f7 brd ff:ff:ff:ff:ff:ff
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:d6:14:16 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.18/16 brd 192.168.255.255 scope global dynamic eth2
       valid_lft 85286sec preferred_lft 85286sec
    inet6 fe80::a00:27ff:fed6:1416/64 scope link
       valid_lft forever preferred_lft forever
````

----
## 7. Установите bird2, настройте динамический протокол маршрутизации RIP.

<-
Устанавливаем bird2

    apt install bird2

Активируем демон bird 

    Synchronizing state of bird.service with SysV service script with /lib/systemd/systemd-sysv-install.
    Executing: /lib/systemd/systemd-sysv-install enable bird

Настраиваем динамический протокол маршрутизации RIP в конфигурационном файле `/etc/bird/bird.conf`

````
log syslog all;
protocol kernel {
 ipv4 {
 export all; # Default is export none
 };
 persist; # Don't remove routes on BIRD shutdown
}
protocol device {
}
protocol rip {
 ipv4 {
 import all;
 export all;
 };
 interface "eth1";
 interface "eth2";
}
protocol direct {
 ipv4; # Connect to default IPv4 table
 interface "dummy*";
}
````

Перезапускаем сервис `service bird restart`

Проверяем что получилось и видим протокол rip
````
birdc show protocols all
BIRD 2.0.7 ready.
Name       Proto      Table      State  Since         Info
kernel1    Kernel     master4    up     20:45:11.756
  Channel ipv4
    State:          UP
    Table:          master4
    Preference:     10
    Input filter:   ACCEPT
    Output filter:  ACCEPT
    Routes:         0 imported, 0 exported, 0 preferred
    Route change stats:     received   rejected   filtered    ignored   accepted
      Import updates:              0          0          0          0          0
      Import withdraws:            0          0        ---          0          0
      Export updates:              0          0          0        ---          0
      Export withdraws:            0        ---        ---        ---          0

device1    Device     ---        up     20:45:11.756

rip1       RIP        master4    up     20:45:11.756
  Channel ipv4
    State:          UP
    Table:          master4
    Preference:     120
    Input filter:   ACCEPT
    Output filter:  ACCEPT
    Routes:         0 imported, 0 exported, 0 preferred
    Route change stats:     received   rejected   filtered    ignored   accepted
      Import updates:              0          0          0          0          0
      Import withdraws:            0          0        ---          0          0
      Export updates:              0          0          0        ---          0
      Export withdraws:            0        ---        ---        ---          0

direct1    Direct     ---        up     20:45:11.756
  Channel ipv4
    State:          UP
    Table:          master4
    Preference:     240
    Input filter:   ACCEPT
    Output filter:  REJECT
    Routes:         0 imported, 0 exported, 0 preferred
    Route change stats:     received   rejected   filtered    ignored   accepted
      Import updates:              0          0          0          0          0
      Import withdraws:            0          0        ---          0          0
      Export updates:              0          0          0        ---          0
      Export withdraws:            0        ---        ---        ---          0

````
----

## 8. Установите Netbox, создайте несколько IP префиксов, используя curl проверьте работу API.

<-

Разворачиваем Netbox через Docker

    cd /tmp
    git clone https://github.com/netbox-community/netbox-docker.git
    cd /tmp/netbox-docker/
    docker compose up

Подключаемся через браузер http://192.168.1.14:8000/ используя логин и пароль по-умолчанию `admin` `admin`

Добавляем префиксы через http://192.168.1.14:8000/ipam/prefixes/add/
![](img/netbox.png)

Проверяем работу API через curl используя токен по-умолчанию `0123456789abcdef0123456789abcdef01234567`

````
curl -X GET -H "Authorization: TOKEN 0123456789abcdef0123456789abcdef01234567" \
> -H "Accept: application/json; indent=4" \
> http://192.168.1.14:8000/api/ipam/prefixes/
````
Результат
````
{
    "count": 2,
    "next": null,
    "previous": null,
    "results": [
        {
            "id": 1,
            "url": "http://192.168.1.14:8000/api/ipam/prefixes/1/",
            "display": "192.168.1.0/24",
            "family": {
                "value": 4,
                "label": "IPv4"
            },
            "prefix": "192.168.1.0/24",
            "site": null,
            "vrf": null,
            "tenant": null,
            "vlan": null,
            "status": {
                "value": "active",
                "label": "Active"
            },
            "role": null,
            "is_pool": false,
            "mark_utilized": false,
            "description": "",
            "comments": "",
            "tags": [],
            "custom_fields": {},
            "created": "2023-01-02T20:25:49.299987Z",
            "last_updated": "2023-01-02T20:25:49.300015Z",
            "children": 0,
            "_depth": 0
        },
        {
            "id": 2,
            "url": "http://192.168.1.14:8000/api/ipam/prefixes/2/",
            "display": "192.168.100.0/24",
            "family": {
                "value": 4,
                "label": "IPv4"
            },
            "prefix": "192.168.100.0/24",
            "site": null,
            "vrf": null,
            "tenant": null,
            "vlan": null,
            "status": {
                "value": "active",
                "label": "Active"
            },
            "role": null,
            "is_pool": false,
            "mark_utilized": false,
            "description": "",
            "comments": "",
            "tags": [],
            "custom_fields": {},
            "created": "2023-01-02T20:25:59.116840Z",
            "last_updated": "2023-01-02T20:25:59.116859Z",
            "children": 0,
            "_depth": 0
        }
    ]
}
````
----