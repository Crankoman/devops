#!/usr/bin/env python3

import os
import sys

# Выносим путь в отдельную переменную
# path = '~/netology/sysadm-homeworks'
if len(sys.argv) > 1:
    path = sys.argv[1]
else:
    path = input('Введите путь до директории и нажмите Enter:')

# Формируем полный путь с учетом домашней директории пользователя и переходим в нее
try:
    os.chdir(os.path.expanduser(path))
    print("Текущая директория - ", os.getcwd())
except (FileNotFoundError, PermissionError, NotADirectoryError):
    print("Не можем перейти в директорию, проверьте путь и права")
    sys.exit(1)
if not os.path.isdir('.git'):
    print("Эта директория не содержит git репозиторий")
    sys.exit(1)

result_os = os.popen("git status").read()

for result in result_os.split('\n'):
    if result.find('nothing to commit') != -1:
        print("Эта директория не содержит модифицированных файлов")
        break
    if result.find('modified') != -1:
        # Добавляем в вывод полный путь до текущей папки и разделитель `/`
        prepare_result = os.getcwd() + '/' + result.replace('\tmodified:   ', '')
        print(prepare_result)
        # Убираем вызов `break` который срабатывает сразу на первом проходе цикла
