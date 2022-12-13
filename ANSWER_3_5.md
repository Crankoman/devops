# Домашнее задание к занятию "3.5. Файловые системы"


## 1. Узнайте о [sparse](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB) (разряженных) файлах.

## 2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

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

## 4. Используя `fdisk`, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

## 5. Используя `sfdisk`, перенесите данную таблицу разделов на второй диск.

## 6. Соберите `mdadm` RAID1 на паре разделов 2 Гб.

## 7. Соберите `mdadm` RAID0 на второй паре маленьких разделов.

## 8. Создайте 2 независимых PV на получившихся md-устройствах.

## 9. Создайте общую volume-group на этих двух PV.

## 10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

## 11. Создайте `mkfs.ext4` ФС на получившемся LV.

## 12. Смонтируйте этот раздел в любую директорию, например, `/tmp/new`.

## 13. Поместите туда тестовый файл, например `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`.

## 14. Прикрепите вывод `lsblk`.

## 15. Протестируйте целостность файла:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```

## 16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

## 17. Сделайте `--fail` на устройство в вашем RAID1 md.

## 18. Подтвердите выводом `dmesg`, что RAID1 работает в деградированном состоянии.

## 19. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```

## 20. Погасите тестовый хост, `vagrant destroy`.
 
*В качестве решения ответьте на вопросы и опишите, каким образом эти ответы были получены*

----