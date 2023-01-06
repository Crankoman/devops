# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"


## 1. Задание 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

<-

Вопросы:
<table>
<tr>
<th>Вопрос</th><th>Ответ</th>
</tr>
<tr>
<td>Какое значение будет присвоено переменной `c`?</td><td>Ошибка: TypeError: unsupported operand type(s) for +: 'int' and 'str'</td>
</tr>
<tr>
<td>Как получить для переменной `c` значение 12?</td><td>
конвертировать переменную `a` в строку 

```python
#!/usr/bin/env python3
a = 1
a = str(a)
b = '2'
c = a + b
print(c)
``` 
Результат: 12
</td>
</tr>
<tr>
<td>Как получить для переменной `c` значение 3?</td><td>
конвертировать переменную `b` в число 

```python
#!/usr/bin/env python3
a = 1
b = '2'
b = int(b)
c = a + b
print(c)
``` 
Результат: 3
</td>
</tr> |   
</table>

----

## 2. Задание 2

Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. 

Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```
<-

Мой скрипт:

```python
#!/usr/bin/env python3

import os

# Выносим путь в отдельную переменную
path = '~/netology/sysadm-homeworks'
# Формируем полный путь с учетом домашней директории пользователя и переходим в нее
os.chdir(os.path.expanduser(path))
# Убираем блок отвечающий за переход в директорию
bash_command = "git status"
result_os = os.popen(bash_command).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        # Добавляем в вывод полный путь до текущей папки и разделитель `/`
        prepare_result = os.getcwd() + '/' + result.replace('\tmodified:   ', '')
        print(prepare_result)
        # Убираем вызов `break` который срабатывает сразу на первом проходе цикла
        # break

```

Вывод скрипта при запуске при тестировании:

    python3 test.py
    /root/netology/sysadm-homeworks/01-intro-01/README.md
    /root/netology/sysadm-homeworks/README.md

----

## 3. Задание 3

Доработать скрипт выше так, чтобы он не только мог проверять локальный репозиторий в текущей директории, но и умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

<-

Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys

# проверяем если параметры запуска, если нет просим их ввести
if len(sys.argv) > 1:
    path = sys.argv[1]
else:
    path = input('Введите путь до директории и нажмите Enter:')

# Проверяем можем ли перейти в данную директорию
try:
    os.chdir(os.path.expanduser(path))
    print("Текущая директория - ", os.getcwd())
except (FileNotFoundError, PermissionError, NotADirectoryError):
    print("Не можем перейти в директорию, проверьте путь и права")
    sys.exit()
# Проверяем существует ли диретория `git`
if not os.path.isdir('.git'):
    print("Эта директория не содержит git репозиторий")
    sys.exit()

# пробуем выполнить `git status`
result_os = os.popen("git status").read()

for result in result_os.split('\n'):
    # Проверяем вдруг нет не модифицированных файлов
    if result.find('nothing to commit') != -1:
        print("Эта директория не содержит модифицированных файлов")
        break
    if result.find('modified') != -1:
        # Добавляем в вывод полный путь до текущей папки и разделитель `/`
        prepare_result = os.getcwd() + '/' + result.replace('\tmodified:   ', '')
        print(prepare_result)

```

Вывод скрипта при запуске при тестировании:
```
python3 test.py ~/netology/sysadm-homeworks/
Текущая директория -  /root/netology/sysadm-homeworks
/root/netology/sysadm-homeworks/01-intro-01/README.md
/root/netology/sysadm-homeworks/README.md

python3 test.py ~/netology
Текущая директория -  /root/netology
Эта директория не содержит git репозиторий

python3 test.py ~/netology1
Не можем перейти в директорию, проверьте путь и права
```

----

## 4. Задание 4

Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. 

Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. 

Мы хотим написать скрипт, который: 
- опрашивает веб-сервисы, 
- получает их IP, 
- выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. 

Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

<-

Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
import urllib.request


# Функция записи словаря в файл
def save_dict_to_file(dic):
    f = open('db.txt', 'w+')
    f.write(str(dic))
    f.close()


# Функция чтения словаря из файла
def load_dict_from_file():
    f = open('db.txt', 'r+')
    data = f.read()
    # Проверяем если файл пустой, заполняем
    if not data:
        data = '{"null":"null"}'
    f.close()
    return eval(data)

# Создаем список сервисов
services = ['drive.google.com', 'mail.google.com', 'google.com']

# Читаем данные из файла
dict_data = load_dict_from_file()

# Переменная для словаря
new_dict_data = {}

for service in services:
    # проверяем доступность сервисов
    if urllib.request.urlopen("https://" + service + "/").getcode() < 400:
        # выводим список сервисов
        ip = socket.gethostbyname(service)
        print(f"<{service}> - <{ip}>")
        # Сверяем с прошлым значением
        if service in dict_data:
            if not dict_data[service] == ip:
                print(f"[ERROR] <{service}> IP mismatch: <{dict_data[service]}> <{ip}>")

        # Заполняем справочник
        new_dict_data[service] = ip

    else:
        print(f"Сервис {service} недоступен")

# Записываем словарь с новыми данными в файл
save_dict_to_file(new_dict_data)
```

Вывод скрипта при запуске при тестировании:
```
<drive.google.com> - <173.194.220.194>
<mail.google.com> - <64.233.161.17>
<google.com> - <74.125.205.113>

echo "{'drive.google.com': '1.1.1.1', 'mail.google.com': '1.1.1.1', 'google.com': '1.1.1.1'}" > db.txt

<drive.google.com> - <74.125.205.194>
[ERROR] <drive.google.com> IP mismatch: <1.1.1.1> <74.125.205.194>
<mail.google.com> - <173.194.222.19>
[ERROR] <mail.google.com> IP mismatch: <1.1.1.1> <173.194.222.19>
<google.com> - <209.85.233.139>
[ERROR] <google.com> IP mismatch: <1.1.1.1> <209.85.233.139>
```





----

## 5. Задание 5 Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. 
Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз: 
* переносить архив с нашими изменениями с сервера на наш локальный компьютер, 
* формировать новую ветку, 
* коммитить в неё изменения, 
* создавать pull request (PR) 
* и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. 

Мы хотим максимально автоматизировать всю цепочку действий. 
* Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым).
* При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. 
* С директорией локального репозитория можно делать всё, что угодно. 
* Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. 

Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

<-

Ваш скрипт:
```python
???
```

```
???
```





----