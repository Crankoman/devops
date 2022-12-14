# Домашнее задание к занятию "3.5. Файловые системы"


## 1. Узнайте о [sparse](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB) (разряженных) файлах.
<-
Речь идет о Разрежённых файлах (англ. sparse file) — файлы, в котором последовательности нулевых байтов заменены на информацию об этих последовательностях (список дыр).
----
## 2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?
<-
Нет, не могут. Жесткие ссылки на один файл имеют одинаковые права доступа и владельца, так как они имеют одинаковый inode. Как раз в inode и хранятся информация о владельце и правах.
Проверим:

    vagrant@vagrant:~$ mkdir test_links && cd test_links
    vagrant@vagrant:~/test_links$ touch test.file && ln test.file test.hlink
    vagrant@vagrant:~/test_links$ ls -il
    total 0
    1313651 -rw-rw-r-- 2 vagrant vagrant 0 Dec 14 19:56 test.file
    1313651 -rw-rw-r-- 2 vagrant vagrant 0 Dec 14 19:56 test.hlink

Видим что у файла и хардлинка одинаковы inode. Сменим владельца хардлинка и права файла

    vagrant@vagrant:~/test_links$ sudo chown root:root test.hlink && sudo chmod 777 test.file && ls -il
    total 0
    1313651 -rwxrwxrwx 2 root root 0 Dec 14 19:56 test.file
    1313651 -rwxrwxrwx 2 root root 0 Dec 14 19:56 test.hlink

Видим что по факту мы провели операцию над одним объектом. Посмотрим информацию о данном inode ***1313651***

    vagrant@vagrant:~/test_links$ sudo debugfs /dev/mapper/ubuntu--vg-ubuntu--lv
    debugfs 1.45.5 (07-Jan-2020)
    debugfs:  stat <1313651>
    
    Inode: 1313651   Type: regular    Mode:  0777   Flags: 0x80000
    Generation: 3443168266    Version: 0x00000000:00000001
    User:     0   Group:     0   Project:     0   Size: 0
    File ACL: 0
    Links: 2   Blockcount: 0
    Fragment:  Address: 0    Number: 0    Size: 0
     ctime: 0x639a2be2:683a9bd0 -- Wed Dec 14 20:02:42 2022
     atime: 0x639a2a86:5e23423c -- Wed Dec 14 19:56:54 2022
     mtime: 0x639a2a86:5e23423c -- Wed Dec 14 19:56:54 2022
    crtime: 0x639a2a86:5e23423c -- Wed Dec 14 19:56:54 2022
    Size of extra inode fields: 32
    Inode checksum: 0x06a47690
    EXTENTS:

Видим информацию и про права и про владельца

----
## 3. Сделайте `vagrant destroy` на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:
<details>  
<summary>подробнее</summary>

    ```ruby
    path_to_disk_folder = './disks'

    host_params = {
        'disk_size' => 2560,
        'disks'=>[1, 2],
        'cpus'=>2,
        'memory'=>2048,
        'hostname'=>'sysadm-fs',
        'vm_name'=>'sysadm-fs'
    }
    Vagrant.configure("2") do |config|
        config.vm.box = "bento/ubuntu-20.04"
        config.vm.hostname=host_params['hostname']
        config.vm.provider :virtualbox do |v|

            v.name=host_params['vm_name']
            v.cpus=host_params['cpus']
            v.memory=host_params['memory']

            host_params['disks'].each do |disk|
                file_to_disk=path_to_disk_folder+'/disk'+disk.to_s+'.vdi'
                unless File.exist?(file_to_disk)
                    v.customize ['createmedium', '--filename', file_to_disk, '--size', host_params['disk_size']]
                end
                v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', disk.to_s, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
            end
        end
        config.vm.network "private_network", type: "dhcp"
    end
    ```
</details>

    Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.
<-
    
    vagrant@sysadm-fs:~$ lsblk
    NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
    loop0                       7:0    0 61.9M  1 loop /snap/core20/1328
    loop1                       7:1    0 67.2M  1 loop /snap/lxd/21835
    loop3                       7:3    0 49.6M  1 loop /snap/snapd/17883
    loop4                       7:4    0 63.2M  1 loop /snap/core20/1738
    loop5                       7:5    0 91.9M  1 loop /snap/lxd/24061
    sda                         8:0    0   64G  0 disk
    ├─sda1                      8:1    0    1M  0 part
    ├─sda2                      8:2    0  1.5G  0 part /boot
    └─sda3                      8:3    0 62.5G  0 part
      └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm  /
    sdb                         8:16   0  2.5G  0 disk
    sdc                         8:32   0  2.5G  0 disk

Появились диски sdb и sdc по 2,5G
----
## 4. Используя `fdisk`, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.
<-
Проверяем какие разделы есть на дисках

     agrant@sysadm-fs:~$ sudo fdisk -l /dev/sdb
     Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
     Disk model: VBOX HARDDISK
     Units: sectors of 1 * 512 = 512 bytes
     Sector size (logical/physical): 512 bytes / 512 bytes
     I/O size (minimum/optimal): 512 bytes / 512 bytes
     vagrant@sysadm-fs:~$ sudo fdisk -l /dev/sdc
     Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
     Disk model: VBOX HARDDISK
     Units: sectors of 1 * 512 = 512 bytes
     Sector size (logical/physical): 512 bytes / 512 bytes
     I/O size (minimum/optimal): 512 bytes / 512 bytes

Видим что разделов нет

Создаем разделы 
<details>  
<summary>подробнее</summary>

    vagrant@sysadm-fs:~$ sudo fdisk /dev/sdb
    
    Welcome to fdisk (util-linux 2.34).
    Changes will remain in memory only, until you decide to write them.
    Be careful before using the write command.
    
    Device does not contain a recognized partition table.
    Created a new DOS disklabel with disk identifier 0x4617ccd2.
    
    Command (m for help): p
    Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
    Disk model: VBOX HARDDISK
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x4617ccd2
    
    Command (m for help): n
    Partition type
       p   primary (0 primary, 0 extended, 4 free)
       e   extended (container for logical partitions)
    Select (default p):
    
    Using default response p.
    Partition number (1-4, default 1): 1
    First sector (2048-5242879, default 2048):
    Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879): +2G
    
    Created a new partition 1 of type 'Linux' and of size 2 GiB.
    
    Command (m for help): n
    Partition type
       p   primary (1 primary, 0 extended, 3 free)
       e   extended (container for logical partitions)
    Select (default p):
    
    Using default response p.
    Partition number (2-4, default 2): 2
    First sector (4196352-5242879, default 4196352):
    Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879): free
    Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879): +5242879
    Value out of range.
    Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879):
    
    Created a new partition 2 of type 'Linux' and of size 511 MiB.
    
    Command (m for help): p
    Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
    Disk model: VBOX HARDDISK
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x4617ccd2
    
    Device     Boot   Start     End Sectors  Size Id Type
    /dev/sdb1          2048 4196351 4194304    2G 83 Linux
    /dev/sdb2       4196352 5242879 1046528  511M 83 Linux
    
    Command (m for help): w
    The partition table has been altered.
    Calling ioctl() to re-read partition table.
    Syncing disks.
</details> 

Проверяем что получилось

    vagrant@sysadm-fs:~$ sudo fdisk -l /dev/sdb
    Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
    Disk model: VBOX HARDDISK
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x4617ccd2
    
    Device     Boot   Start     End Sectors  Size Id Type
    /dev/sdb1          2048 4196351 4194304    2G 83 Linux
    /dev/sdb2       4196352 5242879 1046528  511M 83 Linux

----
## 5. Используя `sfdisk`, перенесите данную таблицу разделов на второй диск.
<-
Используем `sfdisk` с ключем -d - чтобы получить Дамп разделов устройства в формате, который можно использовать в качестве входных данных для `sfdisk`. Передаем через pipe в `sfdisk` с вызовом `/dev/sdc`

    vagrant@sysadm-fs:~$ sudo sfdisk -d /dev/sdb | sudo sfdisk /dev/sdc
    Checking that no-one is using this disk right now ... OK
    
    Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
    Disk model: VBOX HARDDISK
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Created a new DOS disklabel with disk identifier 0x4617ccd2.
    /dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
    /dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
    /dev/sdc3: Done.
    
    New situation:
    Disklabel type: dos
    Disk identifier: 0x4617ccd2
    
    Device     Boot   Start     End Sectors  Size Id Type
    /dev/sdc1          2048 4196351 4194304    2G 83 Linux
    /dev/sdc2       4196352 5242879 1046528  511M 83 Linux
    
    The partition table has been altered.
    Calling ioctl() to re-read partition table.
    Syncing disks.

Проверяем результат 

    vagrant@sysadm-fs:~$ lsblk
    NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
    loop0                       7:0    0 61.9M  1 loop /snap/core20/1328
    loop1                       7:1    0 67.2M  1 loop /snap/lxd/21835
    loop3                       7:3    0 49.6M  1 loop /snap/snapd/17883
    loop4                       7:4    0 63.2M  1 loop /snap/core20/1738
    loop5                       7:5    0 91.9M  1 loop /snap/lxd/24061
    sda                         8:0    0   64G  0 disk
    ├─sda1                      8:1    0    1M  0 part
    ├─sda2                      8:2    0  1.5G  0 part /boot
    └─sda3                      8:3    0 62.5G  0 part
      └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm  /
    sdb                         8:16   0  2.5G  0 disk
    ├─sdb1                      8:17   0    2G  0 part
    └─sdb2                      8:18   0  511M  0 part
    sdc                         8:32   0  2.5G  0 disk
    ├─sdc1                      8:33   0    2G  0 part
    └─sdc2                      8:34   0  511M  0 part
`sdc` разбит аналогично
----
## 6. Соберите `mdadm` RAID1 на паре разделов 2 Гб.
<-
Создаем массив с помощью команды `mdadm -C -v /dev/md0 -l 1 -n 2 /dev/sdb1 /dev/sdc1` где 
`-C` - создание массива,
`-v` - подробный вывод,
`/dev/md0` название нового массива,
`-l 1` - RAID1
`-n 2` - использовать 2-а устройства (диска) и их перечисление


    vagrant@sysadm-fs:~$ sudo mdadm -C -v /dev/md0 -l 1 -n 2 /dev/sdb1 /dev/sdc1
    mdadm: Note: this array has metadata at the start and
        may not be suitable as a boot device.  If you plan to
        store '/boot' on this device please ensure that
        your boot-loader understands md/v1.x metadata, or use
        --metadata=0.90
    mdadm: size set to 2094080K
    Continue creating array? y
    mdadm: Defaulting to version 1.2 metadata
    mdadm: array /dev/md0 started.

Проверяем результат 

    vagrant@sysadm-fs:~$ lsblk
    NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
    loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
    loop1                       7:1    0 67.2M  1 loop  /snap/lxd/21835
    loop3                       7:3    0 49.6M  1 loop  /snap/snapd/17883
    loop4                       7:4    0 63.2M  1 loop  /snap/core20/1738
    loop5                       7:5    0 91.9M  1 loop  /snap/lxd/24061
    sda                         8:0    0   64G  0 disk
    ├─sda1                      8:1    0    1M  0 part
    ├─sda2                      8:2    0  1.5G  0 part  /boot
    └─sda3                      8:3    0 62.5G  0 part
      └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
    sdb                         8:16   0  2.5G  0 disk
    ├─sdb1                      8:17   0    2G  0 part
    │ └─md0                     9:0    0    2G  0 raid1
    └─sdb2                      8:18   0  511M  0 part
    sdc                         8:32   0  2.5G  0 disk
    ├─sdc1                      8:33   0    2G  0 part
    │ └─md0                     9:0    0    2G  0 raid1
    └─sdc2                      8:34   0  511M  0 part

Видим что появился массив `/dev/md0` raid1 размером 2G, так как разделы зеркалируются 

----
## 7. Соберите `mdadm` RAID0 на второй паре маленьких разделов.
<-
По аналогии указываем `mdadm -С -v /dev/md1 -l 0 -n 2 /dev/sdb2 /dev/sdc2` где `-l 0` означает RAID0

    vagrant@sysadm-fs:~$ sudo mdadm -С -v /dev/md1 -l 0 -n 2 /dev/sdb2 /dev/sdc2
    mdadm: chunk size defaults to 512K
    mdadm: Defaulting to version 1.2 metadata
    mdadm: array /dev/md1 started.

Проверяем результат 

    vagrant@sysadm-fs:~$ lsblk
    NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
    loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
    loop1                       7:1    0 67.2M  1 loop  /snap/lxd/21835
    loop3                       7:3    0 49.6M  1 loop  /snap/snapd/17883
    loop4                       7:4    0 63.2M  1 loop  /snap/core20/1738
    loop5                       7:5    0 91.9M  1 loop  /snap/lxd/24061
    sda                         8:0    0   64G  0 disk
    ├─sda1                      8:1    0    1M  0 part
    ├─sda2                      8:2    0  1.5G  0 part  /boot
    └─sda3                      8:3    0 62.5G  0 part
      └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
    sdb                         8:16   0  2.5G  0 disk
    ├─sdb1                      8:17   0    2G  0 part
    │ └─md0                     9:0    0    2G  0 raid1
    └─sdb2                      8:18   0  511M  0 part
      └─md1                     9:1    0 1018M  0 raid0
    sdc                         8:32   0  2.5G  0 disk
    ├─sdc1                      8:33   0    2G  0 part
    │ └─md0                     9:0    0    2G  0 raid1
    └─sdc2                      8:34   0  511M  0 part
      └─md1                     9:1    0 1018M  0 raid0

Видим что появился массив `/dev/md1` raid0 размером 1018M, так как сумма пространств разделов складываются

----
## 8. Создайте 2 независимых PV на получившихся md-устройствах.
<-
Выполняем

    vagrant@sysadm-fs:~$ sudo pvcreate /dev/md0
      Physical volume "/dev/md0" successfully created.
    vagrant@sysadm-fs:~$ sudo pvcreate /dev/md1
      Physical volume "/dev/md1" successfully created.

Проверяем

    vagrant@sysadm-fs:~$ sudo pvs
      PV         VG        Fmt  Attr PSize    PFree
      /dev/md0             lvm2 ---    <2.00g   <2.00g
      /dev/md1             lvm2 ---  1018.00m 1018.00m
      /dev/sda3  ubuntu-vg lvm2 a--   <62.50g   31.25g

----
## 9. Создайте общую volume-group на этих двух PV.
<-
Выполняем

    vagrant@sysadm-fs:~$ sudo vgcreate vg01 /dev/md0 /dev/md1
      Volume group "vg01" successfully created

Проверяем

    vagrant@sysadm-fs:~$ sudo pvs
      PV         VG        Fmt  Attr PSize    PFree
      /dev/md0   vg01      lvm2 a--    <2.00g   <2.00g
      /dev/md1   vg01      lvm2 a--  1016.00m 1016.00m
      /dev/sda3  ubuntu-vg lvm2 a--   <62.50g   31.25g
    vagrant@sysadm-fs:~$ sudo vgs
      VG        #PV #LV #SN Attr   VSize   VFree
      ubuntu-vg   1   1   0 wz--n- <62.50g 31.25g
      vg01        2   0   0 wz--n-  <2.99g <2.99g
----
## 10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.
<-
Выполняем `lvcreate -L 100M /dev/vg01 /dev/md1` где  `-L 100M` - размер 100 Мб

    vagrant@sysadm-fs:~$ sudo lvcreate -L 100M /dev/vg01 /dev/md1
      Logical volume "lvol0" created.

Проверяем

    vagrant@sysadm-fs:~$ sudo lvs
      LV        VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
      ubuntu-lv ubuntu-vg -wi-ao---- <31.25g
      lvol0     vg01      -wi-a----- 100.00m

----
## 11. Создайте `mkfs.ext4` ФС на получившемся LV.
<-
Выполняем 

    vagrant@sysadm-fs:~$ sudo mkfs.ext4 /dev/vg01/lvol0
    mke2fs 1.45.5 (07-Jan-2020)
    Creating filesystem with 25600 4k blocks and 25600 inodes
    
    Allocating group tables: done
    Writing inode tables: done
    Creating journal (1024 blocks): done
    Writing superblocks and filesystem accounting information: done

Проверяем

    vagrant@sysadm-fs:~$ lsblk -f
    NAME               FSTYPE            LABEL       UUID                                   FSAVAIL FSUSE% MOUNTPOINT
    loop0              squashfs                                                                   0   100% /snap/core20/1328
    loop1              squashfs                                                                   0   100% /snap/lxd/21835
    loop3              squashfs                                                                   0   100% /snap/snapd/17883
    loop4              squashfs                                                                   0   100% /snap/core20/1738
    loop5              squashfs                                                                   0   100% /snap/lxd/24061
    sda
    ├─sda1
    ├─sda2             ext4                          1347b25b-64dd-4d97-80ce-90cd82397358      1.3G     7% /boot
    └─sda3             LVM2_member                   x7S6t2-at3n-E9kU-cz28-gAH3-QU9H-vyVuNf
      └─ubuntu--vg-ubuntu--lv
                       ext4                          d940a45b-2440-4ece-9c0c-45ced4c52e39     25.4G    12% /
    sdb
    ├─sdb1             linux_raid_member sysadm-fs:0 812c83ab-855d-0046-0247-76d20447cc52
    │ └─md0            LVM2_member                   Orfi2A-Eund-eq5A-HfOm-FRur-5m9Z-737khU
    └─sdb2             linux_raid_member sysadm-fs:1 dcd9cf90-8ad7-a990-71df-23fd355398f3
      └─md1            LVM2_member                   LlpW41-0FGM-4fow-slk8-jj3G-F433-qTZ2Y6
        └─vg01-lvol0   ext4                          53bd5651-0f0d-4100-8acb-58f69fd0ac87
    sdc
    ├─sdc1             linux_raid_member sysadm-fs:0 812c83ab-855d-0046-0247-76d20447cc52
    │ └─md0            LVM2_member                   Orfi2A-Eund-eq5A-HfOm-FRur-5m9Z-737khU
    └─sdc2             linux_raid_member sysadm-fs:1 dcd9cf90-8ad7-a990-71df-23fd355398f3
      └─md1            LVM2_member                   LlpW41-0FGM-4fow-slk8-jj3G-F433-qTZ2Y6
        └─vg01-lvol0   ext4                          53bd5651-0f0d-4100-8acb-58f69fd0ac87

Видим что у vg01-lvol0 файловая система ext4

----
## 12. Смонтируйте этот раздел в любую директорию, например, `/tmp/new`.
<-
Создаем папку 

    vagrant@sysadm-fs:~$ sudo mkdir /tmp/new

Монтируем 

    vagrant@sysadm-fs:~$ sudo mount /dev/vg01/lvol0 /tmp/new/

Проверяем

    vagrant@sysadm-fs:~$ df -h
    Filesystem                         Size  Used Avail Use% Mounted on
    udev                               948M     0  948M   0% /dev
    tmpfs                              199M  1.1M  198M   1% /run
    /dev/mapper/ubuntu--vg-ubuntu--lv   31G  3.7G   26G  13% /
    tmpfs                              992M     0  992M   0% /dev/shm
    tmpfs                              5.0M     0  5.0M   0% /run/lock
    tmpfs                              992M     0  992M   0% /sys/fs/cgroup
    /dev/loop0                          62M   62M     0 100% /snap/core20/1328
    /dev/loop1                          68M   68M     0 100% /snap/lxd/21835
    /dev/sda2                          1.5G  110M  1.3G   8% /boot
    vagrant                            477G  122G  355G  26% /vagrant
    /dev/loop3                          50M   50M     0 100% /snap/snapd/17883
    /dev/loop4                          64M   64M     0 100% /snap/core20/1738
    /dev/loop5                          92M   92M     0 100% /snap/lxd/24061
    tmpfs                              199M     0  199M   0% /run/user/1000
    /dev/mapper/vg01-lvol0              93M   72K   86M   1% /tmp/new

Видим что все примонтировалось правильно
----
## 13. Поместите туда тестовый файл, например `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`.
<-
Выполняем

    vagrant@sysadm-fs:~$ sudo wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
    --2022-12-14 22:57:05--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
    Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
    Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 24084888 (23M) [application/octet-stream]
    Saving to: ‘/tmp/new/test.gz’
    
    /tmp/new/test.gz              100%[=================================================>]  22.97M  5.05MB/s    in 4.4s
    
    2022-12-14 22:57:09 (5.19 MB/s) - ‘/tmp/new/test.gz’ saved [24084888/24084888]

Проверяем

    vagrant@sysadm-fs:~$ ls -alh /tmp/new/
    total 23M
    drwxr-xr-x  3 root root 4.0K Dec 14 22:57 .
    drwxrwxrwt 13 root root 4.0K Dec 14 22:52 ..
    drwx------  2 root root  16K Dec 14 22:48 lost+found
    -rw-r--r--  1 root root  23M Dec 14 21:54 test.gz

----
## 14. Прикрепите вывод `lsblk`.
<-

    vagrant@sysadm-fs:~$ lsblk
    NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
    loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
    loop1                       7:1    0 67.2M  1 loop  /snap/lxd/21835
    loop3                       7:3    0 49.6M  1 loop  /snap/snapd/17883
    loop4                       7:4    0 63.2M  1 loop  /snap/core20/1738
    loop5                       7:5    0 91.9M  1 loop  /snap/lxd/24061
    sda                         8:0    0   64G  0 disk
    ├─sda1                      8:1    0    1M  0 part
    ├─sda2                      8:2    0  1.5G  0 part  /boot
    └─sda3                      8:3    0 62.5G  0 part
      └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
    sdb                         8:16   0  2.5G  0 disk
    ├─sdb1                      8:17   0    2G  0 part
    │ └─md0                     9:0    0    2G  0 raid1
    └─sdb2                      8:18   0  511M  0 part
      └─md1                     9:1    0 1018M  0 raid0
        └─vg01-lvol0          253:1    0  100M  0 lvm   /tmp/new
    sdc                         8:32   0  2.5G  0 disk
    ├─sdc1                      8:33   0    2G  0 part
    │ └─md0                     9:0    0    2G  0 raid1
    └─sdc2                      8:34   0  511M  0 part
      └─md1                     9:1    0 1018M  0 raid0
        └─vg01-lvol0          253:1    0  100M  0 lvm   /tmp/new
Готово

----
## 15. Протестируйте целостность файла:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```
<-
Выполняем c доп ключем `-v` подробный вывод

    vagrant@sysadm-fs:~$ sudo gzip -t -v /tmp/new/test.gz
    /tmp/new/test.gz:        OK
    vagrant@sysadm-fs:~$ sudo echo $?
    0

Готово
----
## 16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.
<-
Выполняем  `pvmove -v -n lvol0 /dev/md1 /dev/md0` где `-v` подробный вывод `-n` имя PV

    vagrant@sysadm-fs:~$ sudo pvmove -v -n lvol0 /dev/md1 /dev/md0
      Archiving volume group "vg01" metadata (seqno 4).
      Creating logical volume pvmove0
      activation/volume_list configuration setting not defined: Checking only host tags for vg01/lvol0.
      Moving 25 extents of logical volume vg01/lvol0.
      activation/volume_list configuration setting not defined: Checking only host tags for vg01/lvol0.
      Creating vg01-pvmove0
      Loading table for vg01-pvmove0 (253:2).
      Loading table for vg01-lvol0 (253:1).
      Suspending vg01-lvol0 (253:1) with device flush
      Resuming vg01-pvmove0 (253:2).
      Resuming vg01-lvol0 (253:1).
      Creating volume group backup "/etc/lvm/backup/vg01" (seqno 5).
      activation/volume_list configuration setting not defined: Checking only host tags for vg01/pvmove0.
      Checking progress before waiting every 15 seconds.
      /dev/md1: Moved: 56.00%
      /dev/md1: Moved: 100.00%
      Polling finished successfully.

Проверяем

    vagrant@sysadm-fs:~$ lsblk
    NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
    loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
    loop1                       7:1    0 67.2M  1 loop  /snap/lxd/21835
    loop3                       7:3    0 49.6M  1 loop  /snap/snapd/17883
    loop4                       7:4    0 63.2M  1 loop  /snap/core20/1738
    loop5                       7:5    0 91.9M  1 loop  /snap/lxd/24061
    sda                         8:0    0   64G  0 disk
    ├─sda1                      8:1    0    1M  0 part
    ├─sda2                      8:2    0  1.5G  0 part  /boot
    └─sda3                      8:3    0 62.5G  0 part
      └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
    sdb                         8:16   0  2.5G  0 disk
    ├─sdb1                      8:17   0    2G  0 part
    │ └─md0                     9:0    0    2G  0 raid1
    │   └─vg01-lvol0          253:1    0  100M  0 lvm   /tmp/new
    └─sdb2                      8:18   0  511M  0 part
      └─md1                     9:1    0 1018M  0 raid0
    sdc                         8:32   0  2.5G  0 disk
    ├─sdc1                      8:33   0    2G  0 part
    │ └─md0                     9:0    0    2G  0 raid1
    │   └─vg01-lvol0          253:1    0  100M  0 lvm   /tmp/new
    └─sdc2                      8:34   0  511M  0 part
      └─md1                     9:1    0 1018M  0 raid0

Видим что vg01-lvol0 теперь на md0

----
## 17. Сделайте `--fail` на устройство в вашем RAID1 md.
<-
выполняем `mdadm /dev/md0 --fail /dev/sdc1`

    vagrant@sysadm-fs:~$ sudo mdadm /dev/md0 --fail /dev/sdc1
    mdadm: set /dev/sdc1 faulty in /dev/md0

Проверяем

    vagrant@sysadm-fs:~$ sudo mdadm --detail /dev/md0
    /dev/md0:
               Version : 1.2
         Creation Time : Wed Dec 14 22:08:48 2022
            Raid Level : raid1
            Array Size : 2094080 (2045.00 MiB 2144.34 MB)
         Used Dev Size : 2094080 (2045.00 MiB 2144.34 MB)
          Raid Devices : 2
         Total Devices : 2
           Persistence : Superblock is persistent
    
           Update Time : Wed Dec 14 23:13:48 2022
                 State : clean, degraded
        Active Devices : 1
       Working Devices : 1
        Failed Devices : 1
         Spare Devices : 0
    
    Consistency Policy : resync
    
                  Name : sysadm-fs:0  (local to host sysadm-fs)
                  UUID : 812c83ab:855d0046:024776d2:0447cc52
                Events : 19
    
        Number   Major   Minor   RaidDevice State
           0       8       17        0      active sync   /dev/sdb1
           -       0        0        1      removed
    
           1       8       33        -      faulty   /dev/sdc1

Видим одно отказавшее устройство в массиве

----
## 18. Подтвердите выводом `dmesg`, что RAID1 работает в деградированном состоянии.
<-
Выполняем  `dmesg | tail -n 15` выводим последние 15 строчек

    vagrant@sysadm-fs:~$ dmesg | tail -n 15
    [ 5719.409771]  sdc: sdc1 sdc2
    [ 5719.412569]  sdc: sdc1 sdc2
    [ 5893.438253] md/raid1:md0: not clean -- starting background reconstruction
    [ 5893.438254] md/raid1:md0: active with 2 out of 2 mirrors
    [ 5893.438267] md0: detected capacity change from 0 to 2144337920
    [ 5893.439498] md: resync of RAID array md0
    [ 5903.931872] md: md0: resync done.
    [ 5911.743172] md1: detected capacity change from 0 to 1067450368
    [ 6126.348821] md1: detected capacity change from 1067450368 to 0
    [ 6126.348829] md: md1 stopped.
    [ 6856.961364] md1: detected capacity change from 0 to 1067450368
    [ 8602.831907] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
    [ 8602.831916] ext4 filesystem being mounted at /tmp/new supports timestamps until 2038 (0x7fffffff)
    [ 9794.154059] md/raid1:md0: Disk failure on sdc1, disabling device.
                   md/raid1:md0: Operation continuing on 1 devices.

Видим что работа продолжается на одном устройстве

----
## 19. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```
<-
Проверяем архив

    vagrant@sysadm-fs:~$ sudo gzip -t -v /tmp/new/test.gz
    /tmp/new/test.gz:        OK
    vagrant@sysadm-fs:~$ sudo echo $?
    0
Все ок

----
## 20. Погасите тестовый хост, `vagrant destroy`.
<-

----