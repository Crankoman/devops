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
