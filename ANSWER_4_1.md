# Домашнее задание к занятию "4.1. Командная оболочка Bash: Практические навыки"


## 1. Задание 1

Есть скрипт:
```bash
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
```

Какие значения переменным c,d,e будут присвоены? Почему?

| Переменная  | Значение | Обоснование                                                                   |
| ------------- |----------|-------------------------------------------------------------------------------|
| `c`  | `a+b`    | `+ без $(()) текстовый символ, a и b без $ не является работой с переменными` |
| `d`  | `1+2`    | `+ без $(()) текстовый символ, $a и $b переменные`                            |
| `e`  | `3`      | `$a и $b переменные, $(()) используется для арифмитических операций`          |

<-
````
#!/bin/bash
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
echo $c
echo $d
echo $e
````
````
sh bash.sh
a+b
1+2
3
````
----

## 2. Задание 2

На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным (после чего скрипт должен завершиться). В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:
```bash
#!/bin/bash
while ((1==1)
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	fi
done
```
<-

Ваш скрипт:
```bash
#!/bin/bash
while ((1==1)) # добавляем пропущенную закрывающую скобку )
do
        curl https://google.com
        if (($? != 0))
        then
                date >> curl.log
        else
                break # добавляем else и break для случая когда условие не выполнено
        fi
done
```
G
----

## 3. Задание 3

Необходимо написать скрипт, который проверяет доступность трёх IP: `192.168.0.1`, `173.194.222.113`, `87.250.250.242` по `80` порту и записывает результат в файл `log`. Проверять доступность необходимо пять раз для каждого узла.

<-

Ваш скрипт:
```bash
#!/bin/bash
# Создаем массив со списком хостов
array_hosts=("192.168.0.1" "173.194.222.113" "87.250.250.242")
# Запускаем цикл 5 раз
for ((i=0;i<5;i++))
do
# добавляем дополнительный цикл что бы использовать каждый элемент
    for k in "${array_hosts[@]}"
    do
# используем netcat пишем stdout и stderr в файл log
        netcat -vz $k 80 >> log 2>&1
    done
done
```
проверяем
````
cat log
netcat: connect to 192.168.0.1 port 80 (tcp) failed: No route to host
Connection to 173.194.222.113 80 port [tcp/http] succeeded!
Connection to 87.250.250.242 80 port [tcp/http] succeeded!
netcat: connect to 192.168.0.1 port 80 (tcp) failed: No route to host
Connection to 173.194.222.113 80 port [tcp/http] succeeded!
Connection to 87.250.250.242 80 port [tcp/http] succeeded!
netcat: connect to 192.168.0.1 port 80 (tcp) failed: No route to host
Connection to 173.194.222.113 80 port [tcp/http] succeeded!
Connection to 87.250.250.242 80 port [tcp/http] succeeded!
netcat: connect to 192.168.0.1 port 80 (tcp) failed: No route to host
Connection to 173.194.222.113 80 port [tcp/http] succeeded!
Connection to 87.250.250.242 80 port [tcp/http] succeeded!
netcat: connect to 192.168.0.1 port 80 (tcp) failed: No route to host
Connection to 173.194.222.113 80 port [tcp/http] succeeded!
Connection to 87.250.250.242 80 port [tcp/http] succeeded!
````

----

## 4. Задание 4

Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается.

<-

Ваш скрипт:
```bash
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
```

Проверяем:
````
vagrant@vagrant:~$ bash bash.sh
Connection to 173.194.222.113 80 port [tcp/http] succeeded!
Connection to 87.250.250.242 80 port [tcp/http] succeeded!
netcat: connect to 192.168.0.1 port 80 (tcp) failed: No route to host
vagrant@vagrant:~$ cat log
Connection to 173.194.222.113 80 port [tcp/http] succeeded!
Connection to 87.250.250.242 80 port [tcp/http] succeeded!
vagrant@vagrant:~$ cat error
netcat: connect to 192.168.0.1 port 80 (tcp) failed: No route to host
vagrant@vagrant:~$
````

----

## 5. Задание 5 Дополнительное задание (со звездочкой*) - необязательно к выполнению

Мы хотим, чтобы у нас были красивые сообщения для коммитов в репозиторий. Для этого нужно написать локальный хук для git, который будет проверять, что сообщение в коммите содержит код текущего задания в квадратных скобках и количество символов в сообщении не превышает 30. Пример сообщения: \[04-script-01-bash\] сломал хук.

<-

Ваш скрипт:
```bash
???
```




----