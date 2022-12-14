# Домашнее задание к занятию "3.1. Работа в терминале. Лекция 1"
## 1. С помощью базового файла конфигурации запустите Ubuntu 20.04 в VirtualBox посредством Vagrant:
<- 

    curl -LO https://app.vagrantup.com/bento/boxes/ubuntu-20.04/versions/202206.03.0/providers/download/virtualbox.box
    mv virtualbox.box ubuntu-20.04
    vagrant box add "bento/ubuntu-20.04" "c:\downloads\ubuntu-20.04"
    vagrant init
    vagrant up
## 2. Ознакомьтесь с графическим интерфейсом VirtualBox:
### Посмотрите как выглядит виртуальная машина, которую создал для вас Vagrant, какие аппаратные ресурсы ей выделены. 
<-
![](/img/2022-11-13_21-04-19.png)
### Какие ресурсы выделены по-умолчанию?
<-
CPU - 2 core
RAM - 1024 MB
HDD - 64 GB (2,18 GB)
VRAM - 4 MB

## 3. Ознакомьтесь с возможностями конфигурации VirtualBox через Vagrantfile: документация. Как добавить оперативной памяти или ресурсов процессора виртуальной машине?
<- Указать в файле конфигурации необходимые значения ***v.memory***, ***v.cpus*** после выполнить ***vagrant reload***
## 4. Команда vagrant ssh из директории, в которой содержится Vagrantfile, позволит вам оказаться внутри виртуальной машины без каких-либо дополнительных настроек. Попрактикуйтесь в выполнении обсуждаемых команд в терминале Ubuntu.
<-
![](/img/2022-11-13_21-28-29.png)
## 5. Ознакомьтесь с разделами man bash, почитайте о настройках самого bash:
### Какой переменной можно задать длину журнала history, и на какой строчке manual это описывается?
<- ***HISTFILESIZE***, строка ***846*** (version 5.0.17(1)-release (x86_64-pc-linux-gnu)) ![](C:\Users\Crank\PycharmProjects\devops\img\2022-11-13_21-37-53.png)
### Что делает директива ignoreboth в bash?
<- Данная директива применима к переменной ***HISTCONTROL***. Сочетает действие директив ***ignorespace*** и ***ignorespace***, а именно если введенные строки начинаются с пробела они не попадают в историю и если последняя введенная строка совпадает с предыдущей, она игнорируется.
## 6. В каких сценариях использования применимы скобки {} и на какой строчке man bash это описано?/
<- Расширение скобок(Brace Expansion) — это механизм, с помощью которого могут быть сгенерированы произвольные строки, строка ***1091***
## 7. С учётом ответа на предыдущий вопрос, как создать однократным вызовом touch 100000 файлов? 
<- Да. ***touch {0..300000}.txt*** создаст файлы 0.txt - 100000.txt
## Получится ли аналогичным образом создать 300000? Если нет, то почему?
<-  ***Нет***, Argument list too long ограничение на размер массива параметров, определяется в ARG_MAX.
## 8. В man bash поищите по /\[\[. Что делает конструкция [[ -d /tmp ]]
<- 
Речь о механизме условных выражений c поддержкой регулярных выражений CONDITIONAL EXPRESSIONS. ***-d*** - проверка существования папки в примере проверка существование папки ***/tmp*** в случае существования 
    
    if [[ -d /tmp ]]; then echo $?; else echo $?; fi
    0 (true)
    if [[ -d /tmp1 ]]; then echo $?; else echo $?; fi
    1 (false)
## 9. Сделайте так, чтобы в выводе команды type -a bash первым стояла запись с нестандартным путем, например bash is ... Используйте знания о просмотре существующих и создании новых переменных окружения, обратите внимание на переменную окружения PATH
    bash is /tmp/new_path_directory/bash
    bash is /usr/local/bin/bash
    bash is /bin/bash
(прочие строки могут отличаться содержимым и порядком) В качестве ответа приведите команды, которые позволили вам добиться указанного вывода или соответствующие скриншоты.
<-

    mkdir /tmp/new_path_directory&&cp /bin/bash /tmp/new_path_directory/bash&&export PATH=/tmp/new_path_directory:$PATH&&type -a bash
Создаем папку, копируем в папку файл, добавляем в начало переменной PATH путь до директории, выводим путь до директорий где есть bash
## 10. Чем отличается планирование команд с помощью batch и at?
<-
***at*** и ***batch*** читают команды из ввода или из файла и выполняют их позже по времени использованием /bin/sh.

***at*** - выполняет команду один раз в конкретное время. Пример ***"at 12:15 -f /tmp/script.sh"***
***batch*** - выполняет команду один раз в тот момент когда загрузка системы(load average) ниже 1.5 
##` 11. Завершите работу виртуальной машины чтобы не расходовать ресурсы компьютера и/или батарею ноутбука.
<- ***vagrant halt***