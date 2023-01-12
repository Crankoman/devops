# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## 1. Задание 1

Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:

```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис
<-

Ваш скрипт:
```json
{
  "info": "Sample JSON output from our service\\t",
  "elements": [
    {
      "name": "first",
      "type": "server",
      "ip": 7175
    },
    {
      "name": "second",
      "type": "proxy",
      "ip": "71.78.22.43"
    }
  ]
}
```
Исправили строки:

1 - добавил экранирующий символ `\\` к обозначению табуляции `\t`

2 - добавил недостающий пробел ` ` после `:`

7 - добавил запятую `,`, разделяющую записи

9 - добавил двойную закрывающую кавычку `"` для `ip`, сам ip-адрес заключил в двойные кавычки

----

## 2. Задание 2

В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

<-

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
import urllib.request
import json
import yaml


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


# Функция записи в json и yaml
def save_to_json_yaml(dic):
    with open("dump.json", "w+") as outfile_json:
        json.dump(dic, outfile_json)
    with open("dump.yaml", "w") as outfile_yaml:
        yaml.dump(dic, outfile_yaml)


# Создаем список сервисов
services = ['drive.google.com', 'mail.google.com', 'google.com']

# Читаем данные из файла
dict_data = load_dict_from_file()

# Переменная для словаря
new_dict_data = {}
service_dict_data = {}
sites = []
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
        sites.append({service: ip})

    else:
        print(f"Сервис {service} недоступен")
    service_dict_data["site"] = sites

# Записываем словарь с новыми данными в файл
save_dict_to_file(new_dict_data)
save_to_json_yaml(service_dict_data)

```

### Вывод скрипта при запуске при тестировании:
```
<drive.google.com> - <64.233.165.194>
<mail.google.com> - <173.194.222.19>
<google.com> - <142.250.150.113>
[ERROR] <google.com> IP mismatch: <142.250.150.100> <142.250.150.113>
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{"site": [{"drive.google.com": "64.233.165.194"}, {"mail.google.com": "173.194.222.19"}, {"google.com": "142.250.150.100"}]}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
site:
- drive.google.com: 64.233.165.194
- mail.google.com: 173.194.222.19
- google.com: 142.250.150.100

```

----

## 3. Задание 3 Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

Ваш скрипт:
```python
???
```

Пример работы скрипта:
???



<-



----