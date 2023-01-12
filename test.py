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
