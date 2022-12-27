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

----
## 2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

<-

----
## 3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

<-

----
## 4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

<-

----
## 5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

<-

----
## 6. Установите Nginx, настройте в режиме балансировщика TCP или UDP.

<-
 
----
## 7. Установите bird2, настройте динамический протокол маршрутизации RIP.

<-

----
## 8. Установите Netbox, создайте несколько IP префиксов, используя curl проверьте работу API.

<-

----