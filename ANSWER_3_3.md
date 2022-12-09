# Домашнее задание к занятию "3.3. Операционные системы. Лекция 1"

## 1. Какой системный вызов делает команда cd?

<-

выполняем `strace /bin/bash -c 'cd /tmp/' 2>&1 | grep tmp` 
Используем контсрукцию /bin/bash -c 'cd /tmp/' т.к. это встроенная комманда
strace выводит результат в поток в stderr, перенаправляем его в stdout `2>&1`, а после в пайп grep где ищем упомянание интересущей нас папки `| grep tmp`  

    execve("/bin/bash", ["/bin/bash", "-c", "cd /tmp/"], 0x7fff1c1405e0 /* 24 vars */) = 0
    stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
    stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
    chdir("/tmp")        

------  

## 2. Попробуйте использовать команду file на объекты разных типов в файловой системе. Используя strace выясните, где находится база данных file, на основании которой она делает свои догадки.

<-

    vagrant@vagrant:~$ file /dev/tty
    /dev/tty: character special (5/0)
    vagrant@vagrant:~$ file /dev/sda
    /dev/sda: block special (8/0)
    vagrant@vagrant:~$ file /bin/bash
    /bin/bash: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=2a9f157890930ced4c3ad0e74fc1b1b84aad71e6, for GNU/Linux 3.2.0, stripped

выполним `strace -e openat,read  file /dev/tty` где -e позволяет фильровать системные вызовы, оставляем только `openat,read`

получим

    ...
    read(3, "# Magic local data for file(1) c"..., 4096) = 111
    read(3, "", 4096)                       = 0
    openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
    ...

Ответ `/usr/share/misc/magic.mgc`

------  

## 3. Предположим, приложение пишет лог в текстовый файл. 
Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. 
Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).

<-

1. Выясним PID процесса например через `ps aux | grep название_приложения`
2. Выясняем FD файла в которое оно пишет через `lsof -p PID`, удаленный файл - будет помечен как (deleted)
3. Перезаписываем с помощью `echo - n >/proc/PID/fd/FD`


------  

## 4. Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?

<- 

Зомби-процессы не используют системные ресурсы. Т.к. Зомби-процессы это уже завершившися помощью системного вызова exit() процессы и уже освободили ресурсы. Однако запись о них занимает небольшое место, при  большом количестве зомби-процессов они могут потребялть некоторое количество ОЗУ.

------  

## 5. В iovisor BCC есть утилита opensnoop
    root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
    /usr/sbin/opensnoop-bpfcc
На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты? Воспользуйтесь пакетом bpfcc-tools для Ubuntu 20.04. Дополнительные сведения по установке.

<-

    vagrant@vagrant:~$ dpkg -L bpfcc-tools | grep sbin/opensnoop
    dpkg-query: package 'bpfcc-tools' is not installed
    Use dpkg --contents (= dpkg-deb --contents) to list archive files contents.

`sudo apt install bpfcc-tools -y`

      vagrant@vagrant:~$ /usr/sbin/opensnoop-bpfcc
      modprobe: ERROR: could not insert 'kheaders': Operation not permitted
      Unable to find kernel headers. Try rebuilding kernel with CONFIG_IKHEADERS=m (module)
      chdir(/lib/modules/5.4.0-110-generic/build): No such file or directory
      Traceback (most recent call last):
        File "/usr/sbin/opensnoop-bpfcc", line 180, in <module>
          b = BPF(text=bpf_text)
        File "/usr/lib/python3/dist-packages/bcc/__init__.py", line 347, in __init__
          raise Exception("Failed to compile BPF module %s" % (src_file or "<text>"))
      Exception: Failed to compile BPF module <text>

запуска через sudo 

    vagrant@vagrant:~$ sudo /usr/sbin/opensnoop-bpfcc
    PID    COMM               FD ERR PATH
    391    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.procs
    391    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.threads
    905    vminfo              4   0 /var/run/utmp
    638    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
    638    dbus-daemon        19   0 /usr/share/dbus-1/system-services
    638    dbus-daemon        -1   2 /lib/dbus-1/system-services
    638    dbus-daemon        19   0 /var/lib/snapd/dbus-1/system-services/



------  


## 6. Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.

<-

системный вызов uname()

man 2 uname строка ***65***: Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.

------  


## 7. Чем отличается последовательность команд через ; и через && в bash? Например:
    root@netology1:~# test -d /tmp/some_dir; echo Hi
    Hi
    root@netology1:~# test -d /tmp/some_dir && echo Hi
    root@netology1:~#
Есть ли смысл использовать в `bash &&`, если применить `set -e`?
<- 

`;` - Просто разделитель команд. Команды будут выполнться последовательно, независимо от успехв их выполения

`&&` - логическое AND (И). Т.е. команда после && выполнится только в случае успешного выполнения(завершится с exit кодом 0) команды перед &&

Имеет смысл. `set -e` немедлено завершит работу шелла только встретит команду, которая завершится с ошибкой, а при использовании `&&` завершится только набор команд, без выхода из шелла.

------  


## 8. Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?

<- 
выполним `set --help` и узнаем:
e - Exit immediately if a command exits with a non-zero status. Немедленно завершите работу, если команда завершается cо стаусом отличным от 0 (exit код не 0)
u - Treat unset variables as an error when substituting. Рассматривать неустановленные переменные как ошибку при замене
x - Print commands and their arguments as they are executed. Выводить команды и их аргументы когда оны выполняются
o - option-name (позволят выбрать опции)
pipefall -  the return value of a pipeline is the status of the last command to exit with a non-zero status, or zero if no command exited with a non-zero status. возвращаемое значение конвейера - это статус последней команды для завершения с ненулевым статусом или ноль, если ни одна команда не завершилась с ненулевым статусом

Позволяет выводить детальные ошибки и завершать его выполнение в случае ошибки

------  


## 9. Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).

<- 
Выполним `ps h -e -o stat | cut -c1 | sort | uniq -c | sort -h -r` где:
ps: h - иисключаем заголовок, -e выводить все процессы, -o stat выводить только поле PROCESS STATE CODES (КОДЫ СОСТОЯНИЯ ПРОЦЕССА)
cut -c1 - обрезаем до одного символа
sort - отсортируем список
uniq -c подсчитаем уникальные значения
sort 
-h при сортировке использовать человечиский подход (сортивароть цифры как числа, а не как знаки)
-r сортировка от большего к меньшему

    vagrant@vagrant:~$ ps h -e -o stat | cut -c1 | sort | uniq -c | sort -h -r
         63 S
         49 I
          1 R

Самый встречающийся статус - S
     < - высокоприоритетный (неприятный для других пользователей)
     N - с низким приоритетом (приятный для других пользователей)
     L -  имеет страницы, заблокированные в памяти (для ввода-вывода в реальном времени и пользовательского ввода-вывода)
     s -  является лидером сеанса
     l -  является многопоточным (с использованием CLONE_THREAD, как это делают pthreads NPTL)
     + -  находится в группе процессов переднего плана

------  

