# Домашнее задание к занятию 3. «MySQL»

## Задача 1

Используя Docker, поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-03-mysql/test_data) и 
восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

Используя команду `\h`, получите список управляющих команд.

Найдите команду для выдачи статуса БД и **приведите в ответе** из её вывода версию сервера БД.

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

**Приведите в ответе** количество записей с `price` > 300.

В следующих заданиях мы будем продолжать работу с этим контейнером.

<--

Ответ:

Создаем Docker-compose файл
```yaml
mysql-server-80:
  image: mysql/mysql-server:8.0
  volumes:
      - ./data/:/var/lib/mysql/
      - ./my.cnf:/etc/my.cnf
  environment:
      MYSQL_ROOT_PASSWORD: test_password
  ports:
    - "3308:3306"
```

Создадим файл `my.cnf`, что бы он не стал папкой и запускаем
```commandline
touch ./my.cnf 
docker-compose up -d
```

Скачиваем бекап

```commandline
wget https://raw.githubusercontent.com/netology-code/virt-homeworks/virt-11/06-db-03-mysql/test_data/test_dump.sql
```

Создаем базу данных и восстанавливаем бекап

```commandline
docker exec -i mysql-test_mysql-server-80_1 mysql -u root --password=test_password -e "CREATE DATABASE `test_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
```

Получаем нужные данные
<details>                         
    <summary>подробнее</summary>

```commandline
root@test:/opt/mysql-test# docker exec -it mysql-test_mysql-server-80_1 mysql -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 25
Server version: 8.0.32 MySQL Community Server - GPL

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> \h

For information about MySQL products and services, visit:
   http://www.mysql.com/
For developer information, including the MySQL Reference Manual, visit:
   http://dev.mysql.com/
To buy MySQL Enterprise support, training, or other products, visit:
   https://shop.mysql.com/

List of all MySQL commands:
Note that all text commands must be first on line and end with ';'
?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
edit      (\e) Edit command with $EDITOR.
ego       (\G) Send command to mysql server, display result vertically.
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
nopager   (\n) Disable pager, print to stdout.
notee     (\t) Don't write into outfile.
pager     (\P) Set PAGER [to_pager]. Print the query results via PAGER.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command.
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don't show warnings after every statement.
resetconnection(\x) Clean session context.
query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.
ssl_session_data_print Serializes the current SSL session data to stdout or file

For server side help, type 'help contents'

mysql> \u test_db
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> \s
--------------
mysql  Ver 8.0.32 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:          104
Current database:       test_db
Current user:           root@localhost
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         8.0.32 MySQL Community Server - GPL
Protocol version:       10
Connection:             Localhost via UNIX socket
Server characterset:    utf8mb4
Db     characterset:    utf8mb4
Client characterset:    latin1
Conn.  characterset:    latin1
UNIX socket:            /var/lib/mysql/mysql.sock
Binary data as:         Hexadecimal
Uptime:                 41 min 54 sec

Threads: 2  Questions: 275  Slow queries: 0  Opens: 162  Flush tables: 3  Open tables: 80  Queries per second avg: 0.109
--------------
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.01 sec)
mysql> SELECT COUNT(*) FROM `orders` WHERE `price` > 300;
+----------+
| COUNT(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
```

</details>

Версия сервера: `mysql  Ver 8.0.32 for Linux on x86_64 (MySQL Community Server - GPL)`

Список таблиц: `orders`

Количество записей: `1`

---

## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:

- плагин авторизации mysql_native_password
- срок истечения пароля — 180 дней 
- количество попыток авторизации — 3 
- максимальное количество запросов в час — 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James".


Предоставьте привилегии пользователю `test` на операции SELECT базы `test_db`.

```sql
GRANT SELECT ON test_db.* TO 'test';
```

Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES, получите данные по пользователю `test` и 
**приведите в ответе к задаче**.

<--

Ответ:

Создаем пользователя 

```sql
CREATE USER test 
IDENTIFIED WITH mysql_native_password BY 'test-pass'
WITH 
MAX_CONNECTIONS_PER_HOUR 100
PASSWORD EXPIRE INTERVAL 100 DAY
FAILED_LOGIN_ATTEMPTS 3
ATTRIBUTE '{"fname": "James", "lname": "Pretty"}';
```

Предоставляем права

```sql
GRANT SELECT ON test_db.* TO 'test';
FLUSH PRIVILEGES;
```

Проверяем

```commandline
mysql> select * from INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE user = 'test';
+------+------+---------------------------------------+
| USER | HOST | ATTRIBUTE                             |
+------+------+---------------------------------------+
| test | %    | {"fname": "James", "lname": "Pretty"} |
+------+------+---------------------------------------+
1 row in set (0.00 sec)
```

---


## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`,
- на `InnoDB`.

<--

Ответ:

Смотрим профилирование запросов 
```commandline
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> select * from orders;
+----+-----------------------+-------+
| id | title                 | price |
+----+-----------------------+-------+
|  1 | War and Peace         |   100 |
|  2 | My little pony        |   500 |
|  3 | Adventure mysql times |   300 |
|  4 | Server gravity falls  |   300 |
|  5 | Log gossips           |   123 |
+----+-----------------------+-------+
5 rows in set (0.00 sec)

mysql> SHOW PROFILES;
+----------+------------+----------------------+
| Query_ID | Duration   | Query                |
+----------+------------+----------------------+
|        1 | 0.00341450 | select * from orders |
+----------+------------+----------------------+
1 row in set, 1 warning (0.00 sec)

mysql> SHOW PROFILE FOR QUERY 1;
+--------------------------------+----------+
| Status                         | Duration |
+--------------------------------+----------+
| starting                       | 0.000866 |
| Executing hook on transaction  | 0.000043 |
| starting                       | 0.000118 |
| checking permissions           | 0.000055 |
| Opening tables                 | 0.000471 |
| init                           | 0.000135 |
| System lock                    | 0.000107 |
| optimizing                     | 0.000049 |
| statistics                     | 0.000242 |
| preparing                      | 0.000311 |
| executing                      | 0.000593 |
| end                            | 0.000023 |
| query end                      | 0.000011 |
| waiting for handler commit     | 0.000102 |
| closing tables                 | 0.000057 |
| freeing items                  | 0.000074 |
| cleaning up                    | 0.000160 |
+--------------------------------+----------+
17 rows in set, 1 warning (0.01 sec)

```

Проверяем какой движек используется в test_db - InnoDB

```
mysql> SELECT TABLE_SCHEMA ,TABLE_NAME, ENGINE  FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'test_db';
+--------------+------------+--------+
| TABLE_SCHEMA | TABLE_NAME | ENGINE |
+--------------+------------+--------+
| test_db      | orders     | InnoDB |
+--------------+------------+--------+
1 row in set (0.00 sec)
```

Меняем производительность и смотрим как меняется производительность

```commandline
mysql> ALTER TABLE test_db.orders  ENGINE = MyISAM;
Query OK, 5 rows affected (0.09 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from test_db.orders;
+----+-----------------------+-------+
| id | title                 | price |
+----+-----------------------+-------+
|  1 | War and Peace         |   100 |
|  2 | My little pony        |   500 |
|  3 | Adventure mysql times |   300 |
|  4 | Server gravity falls  |   300 |
|  5 | Log gossips           |   123 |
+----+-----------------------+-------+
5 rows in set (0.00 sec)

mysql> SHOW PROFILE FOR QUERY 14;
+--------------------------------+----------+
| Status                         | Duration |
+--------------------------------+----------+
| starting                       | 0.001112 |
| Executing hook on transaction  | 0.000046 |
| starting                       | 0.000152 |
| checking permissions           | 0.000130 |
| Opening tables                 | 0.000656 |
| init                           | 0.000068 |
| System lock                    | 0.000313 |
| optimizing                     | 0.000058 |
| statistics                     | 0.000202 |
| preparing                      | 0.000358 |
| executing                      | 0.000476 |
| end                            | 0.000030 |
| query end                      | 0.000092 |
| closing tables                 | 0.000084 |
| freeing items                  | 0.001004 |
| cleaning up                    | 0.000162 |
+--------------------------------+----------+
16 rows in set, 1 warning (0.00 sec)

mysql> ALTER TABLE test_db.orders  ENGINE = InnoDB;
Query OK, 5 rows affected (0.10 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from test_db.orders;
+----+-----------------------+-------+
| id | title                 | price |
+----+-----------------------+-------+
|  1 | War and Peace         |   100 |
|  2 | My little pony        |   500 |
|  3 | Adventure mysql times |   300 |
|  4 | Server gravity falls  |   300 |
|  5 | Log gossips           |   123 |
+----+-----------------------+-------+
5 rows in set (0.00 sec)


mysql> SHOW PROFILE FOR QUERY 16;
+--------------------------------+----------+
| Status                         | Duration |
+--------------------------------+----------+
| starting                       | 0.000397 |
| Executing hook on transaction  | 0.000012 |
| starting                       | 0.000035 |
| checking permissions           | 0.000019 |
| Opening tables                 | 0.000158 |
| init                           | 0.000022 |
| System lock                    | 0.000046 |
| optimizing                     | 0.000026 |
| statistics                     | 0.000113 |
| preparing                      | 0.000176 |
| executing                      | 0.000134 |
| end                            | 0.000011 |
| query end                      | 0.000015 |
| waiting for handler commit     | 0.000058 |
| closing tables                 | 0.000041 |
| freeing items                  | 0.000049 |
| cleaning up                    | 0.000081 |
+--------------------------------+----------+
17 rows in set, 1 warning (0.01 sec)
```

---

## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):

- скорость IO важнее сохранности данных;
- нужна компрессия таблиц для экономии места на диске;
- размер буффера с незакомиченными транзакциями 1 Мб;
- буффер кеширования 30% от ОЗУ;
- размер файла логов операций 100 Мб.

Приведите в ответе изменённый файл `my.cnf`.

<--

Ответ:

По умолчанию `/etc/my.cnf` - пустой

```
[mysqld]
innodb_flush_log_at_trx_commit = 0
innodb_file_per_table = ON
innodb_log_buffer_size = 1M
innodb_buffer_pool_size = 300M
innodb_redo_log_capacity = 100M
```
---