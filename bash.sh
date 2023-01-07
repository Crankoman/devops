#!/bin/bash
# Создаем массив со списком хостов
array_hosts=("173.194.222.113" "87.250.250.242" "192.168.0.1" )
# Запускаем цикл 5 раз
for ((i=0;i<5;i++))
do
# добавляем дополнительный цикл что бы использовать каждый элемент
    for k in "${array_hosts[@]}"
    do
# используем netcat пишем stdout и stderr в файл log
        netcat -vz $k 80
        # проверяем с каким кодом завершился netcat
        if (($?!=0))
        then
          # пишем в error и завершаем скрипт
          netcat -vz $k 80 >> error 2>&1
          exit
        else
          # пишем в лог
          netcat -vz $k 80 >> log 2>&1
        fi
    done
done