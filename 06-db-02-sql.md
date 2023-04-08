# Домашнее задание к занятию "6.2. SQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

<--

Ответ:
```yaml
version: "3.9"
services:
  postgresql12:
    image: postgres:12
    environment:
      POSTGRES_USER: "postgres"
      POSTGRES_PASSWORD: "postgres"
    ports:
      - 5432:5432
    volumes:
      - /tmp/data:/var/lib/postgresql/data
      - /tmp/backup:/var/lib/postgresql/backup


```

Проверяем:
```
root@test:/tmp# docker ps
CONTAINER ID   IMAGE                        COMMAND                  CREATED          STATUS          PORTS                                                  NAMES
dabb4dc60576   postgres:12                  "docker-entrypoint.s…"   44 seconds ago   Up 43 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp              tmp_postgresql12_1
root@test:/tmp# ls /tmp/data
PG_VERSION  pg_commit_ts  pg_ident.conf  pg_notify    pg_snapshots  pg_subtrans  pg_wal                postgresql.conf
base        pg_dynshmem   pg_logical     pg_replslot  pg_stat       pg_tblspc    pg_xact               postmaster.opts
global      pg_hba.conf   pg_multixact   pg_serial    pg_stat_tmp   pg_twophase  postgresql.auto.conf  postmaster.pid

```

---

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db

<--

Ответ:

```
CREATE USER "test-admin-user";
CREATE DATABASE "test_db";
\connect "test_db";
CREATE TABLE "orders" (
    "id" SERIAL PRIMARY KEY,
    "наименование" VARCHAR,
    "цена" INTEGER);
CREATE TABLE "clients" (
    "id" SERIAL PRIMARY KEY,
    "фамилия" VARCHAR,
    "страна проживания" VARCHAR,
    "заказ" SERIAL,
    FOREIGN KEY ("заказ") REFERENCES "orders" ("id"));
CREATE INDEX ON "clients"("страна проживания");
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to "test-admin-user";
CREATE USER "test-simple-user";
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO "test-simple-user";
```

1. итоговый список БД после выполнения пунктов выше

```
\l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
```

1. описание таблиц (describe)

<details>                         
    <summary>подробнее</summary>

```
\d+ orders
                                                        Table "public.orders"
    Column    |       Type        | Collation | Nullable |              Default               | Storage  | Stats target | Description
--------------+-------------------+-----------+----------+------------------------------------+----------+--------------+-------------
 id           | integer           |           | not null | nextval('orders_id_seq'::regclass) | plain    |              |
 наименование | character varying |           |          |                                    | extended |              |
 цена         | integer           |           |          |                                    | plain    |              |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

\d+ clients
                                                             Table "public.clients"
      Column       |       Type        | Collation | Nullable |                 Default                  | Storage  | Stats target | Description
-------------------+-------------------+-----------+----------+------------------------------------------+----------+--------------+-------------
 id                | integer           |           | not null | nextval('clients_id_seq'::regclass)      | plain    |              |
 фамилия           | character varying |           |          |                                          | extended |              |
 страна проживания | character varying |           |          |                                          | extended |              |
 заказ             | integer           |           | not null | nextval('"clients_заказ_seq"'::regclass) | plain    |              |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "clients_страна проживания_idx" btree ("страна проживания")
Foreign-key constraints:
    "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

```
</details>

1. SQL-запрос для выдачи списка пользователей с правами над таблицами test_db

```
SELECT * 
FROM information_schema.table_privileges 
where table_name in ('clients','orders')
order by grantee;
```


1. список пользователей с правами над таблицами test_db

<details>                         
    <summary>подробнее</summary>


```
 grantor  |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy
----------+------------------+---------------+--------------+------------+----------------+--------------+----------------
 postgres | postgres         | test_db       | public       | orders     | INSERT         | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | SELECT         | YES          | YES
 postgres | postgres         | test_db       | public       | orders     | UPDATE         | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | DELETE         | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | TRUNCATE       | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | REFERENCES     | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | TRIGGER        | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | INSERT         | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | SELECT         | YES          | YES
 postgres | postgres         | test_db       | public       | clients    | UPDATE         | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | DELETE         | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | TRUNCATE       | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | REFERENCES     | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | TRIGGER        | YES          | NO
 postgres | test-admin-user  | test_db       | public       | orders     | TRIGGER        | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-admin-user  | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | TRUNCATE       | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | REFERENCES     | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | TRUNCATE       | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | REFERENCES     | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | TRIGGER        | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | DELETE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | SELECT         | NO           | YES
(36 rows)
```

</details>

---

## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

<--

Ответ:

Наполняем данными

```
INSERT INTO public.orders ("наименование", "цена") VALUES ('Шоколад', 10), ('Принтер',3000), ('Книга', 500), ('Монитор', 7000), ('Гитара', 4000);
SELECT * FROM public.orders;
 id | наименование | цена
----+--------------+------
  1 | Шоколад      |   10
  2 | Принтер      | 3000
  3 | Книга        |  500
  4 | Монитор      | 7000
  5 | Гитара       | 4000
(5 rows)

```
```
INSERT INTO public.clients (id, "фамилия", "страна проживания", "заказ") 
VALUES (1, 'Иванов Иван Иванович', 'USA', NULL),
(2, 'Петров Петр Петрович', 'Canada', NULL),
(3, 'Иоганн Себастьян Бах', 'Japan', NULL),
(4, 'Ронни Джеймс Дио', 'Russia', NULL), 
(5, 'Ritchie Blackmore', 'Russia', NULL);
SELECT * FROM public.clients;
 id |       фамилия        | страна проживания | заказ
----+----------------------+-------------------+-------
  1 | Иванов Иван Иванович | USA               |
  2 | Петров Петр Петрович | Canada            |
  3 | Иоганн Себастьян Бах | Japan             |
  4 | Ронни Джеймс Дио     | Russia            |
  5 | Ritchie Blackmore    | Russia            |
(5 rows)

```
```
select count(*) FROM public.clients;
 count
-------
     5
(1 row)
```
```
select count(*) FROM public.orders;
 count
-------
     5
(1 row)

```

---

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.

<--

Ответ:
```
UPDATE public.clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Книга') WHERE "фамилия"='Иванов Иван Иванович';
UPDATE public.clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Монитор') WHERE "фамилия"='Петров Петр Петрович';
UPDATE public.clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Гитара') WHERE "фамилия"='Иоганн Себастьян Бах';
SELECT * FROM public.clients;
 id |       фамилия        | страна проживания | заказ
----+----------------------+-------------------+-------
  4 | Ронни Джеймс Дио     | Russia            |
  5 | Ritchie Blackmore    | Russia            |
  1 | Иванов Иван Иванович | USA               |     3
  2 | Петров Петр Петрович | Canada            |     4
  3 | Иоганн Себастьян Бах | Japan             |     5
(5 rows)
```
```
SELECT * FROM public.clients WHERE "заказ" IS NOT NULL;
 id |       фамилия        | страна проживания | заказ
----+----------------------+-------------------+-------
  1 | Иванов Иван Иванович | USA               |     3
  2 | Петров Петр Петрович | Canada            |     4
  3 | Иоганн Себастьян Бах | Japan             |     5
(3 rows)
```
---

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

<--
```
EXPLAIN SELECT * FROM public.clients WHERE "заказ" IS NOT NULL;
                        QUERY PLAN
-----------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
   Filter: ("заказ" IS NOT NULL)
(2 rows)
```
Ответ:
Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)- процессорное времени на поиск первой записи .. весь результат  rows=ориентировочное количество строк, width=средний размер строки в байтах
Filter - примененые фильтры
---

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

<--

Ответ:
```commandline
root@28b52f40e070:/# pg_dump -U postgres -d test_db -Fc  -f /var/lib/postgresql/backup/backup.back
root@4SER-1670916090:/tmp# ls backup/
backup.back
root@4SER-1670916090:/tmp# docker-compose down
Stopping tmp_postgresql12_1 ... done
Removing tmp_postgresql12_1 ... done
Removing network tmp_default
root@4SER-1670916090:/tmp# rm -rf data/ # удяляем данные старого контейнера
root@4SER-1670916090:/tmp# docker-compose up -d
Creating network "tmp_default" with the default driver
Creating tmp_postgresql12_1 ... done
root@4SER-1670916090:/tmp# docker exec -it tmp_postgresql12_1 bash
root@6e384847dbf6:/# psql -U postgres
psql (12.14 (Debian 12.14-1.pgdg110+1))
Type "help" for help.

postgres=# \l+
                                                                   List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   |  Size   | Tablespace |                Description
-----------+----------+----------+------------+------------+-----------------------+---------+------------+--------------------------------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |                       | 7969 kB | pg_default | default administrative connection database
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +| 7825 kB | pg_default | unmodifiable empty database
           |          |          |            |            | postgres=CTc/postgres |         |            |
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +| 7825 kB | pg_default | default template for new databases
           |          |          |            |            | postgres=CTc/postgres |         |            |
(3 rows)




```
---
