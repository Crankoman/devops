# Домашнее задание к занятию 4. «PostgreSQL»

## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL, используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:

- вывода списка БД,
- подключения к БД,
- вывода списка таблиц,
- вывода описания содержимого таблиц,
- выхода из psql.

<--

Ответ:

1. Поднимаем истанс PG, данные сохраняем в volume `data`

```yaml
version: '3.9'
services:
  db:
    image: postgres:13
    restart: always
    environment:
      - POSTGRES_USER=***
      - POSTGRES_PASSWORD=***
    ports:
      - '5432:5432'
    volumes:
      - ./  data:/var/lib/postgresql/data
volumes:
  data:
    driver: local

```

1. Подключаемся к PG

```commandline
docker exec -it postgresql-test_db_1 psql -U postgres
psql (13.10 (Debian 13.10-1.pgdg110+1))
Type "help" for help.

postgres=#

```

1. Выполняем команды:

```commandline
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

postgres=# \c postgres
You are now connected to database "postgres" as user "postgres".

postgres=# \dt *
                    List of relations
   Schema   |          Name           | Type  |  Owner
------------+-------------------------+-------+----------
 pg_catalog | pg_aggregate            | table | postgres
 pg_catalog | pg_am                   | table | postgres
 ...
 pg_catalog | pg_ts_template          | table | postgres
 pg_catalog | pg_type                 | table | postgres
 pg_catalog | pg_user_mapping         | table | postgres
(62 rows)

postgres=# \d pg_aggregate
               Table "pg_catalog.pg_aggregate"
      Column      |   Type   | Collation | Nullable | Default
------------------+----------+-----------+----------+---------
 aggfnoid         | regproc  |           | not null |
 aggkind          | "char"   |           | not null |
 aggnumdirectargs | smallint |           | not null |
 aggtransfn       | regproc  |           | not null |
 aggfinalfn       | regproc  |           | not null |
 aggcombinefn     | regproc  |           | not null |
...
 aggmtranstype    | oid      |           | not null |
 aggmtransspace   | integer  |           | not null |
 agginitval       | text     | C         |          |
 aggminitval      | text     | C         |          |
Indexes:
    "pg_aggregate_fnoid_index" UNIQUE, btree (aggfnoid)

postgres=# \q


```

---

## Задача 2

Используя `psql`, создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders`
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления, и полученный результат.

<--

Ответ:

```commandline
postgres=# CREATE DATABASE test_database;
CREATE DATABASE

docker exec -i postgresql-test_db_1 psql -v  -U postgres -d test_database < test_dump.sql
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval
--------
      8
(1 row)

ALTER TABLE

test_database=# SELECT attname, avg_width FROM pg_stats WHERE avg_width = (SELECT MAX(avg_width) FROM pg_stats WHERE tablename='orders');
 attname | avg_width
---------+-----------
 title   |        16
(1 row)

```

---

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложили
провести разбиение таблицы на 2: шардировать на orders_1 - price>499 и orders_2 - price<=499.

Предложите SQL-транзакцию для проведения этой операции.

Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?

<--

Ответ:
Пример транзакции

```commandline
BEGIN;
CREATE TABLE orders_01 (LIKE orders);
INSERT INTO orders_01 SELECT * FROM orders WHERE price > 499;
DELETE FROM orders WHERE price > 499;
CREATE TABLE orders_02 (LIKE orders);
INSERT INTO orders_02 SELECT * FROM orders WHERE price <= 499;
DELETE FROM orders WHERE price <= 499;
COMMIT;
```

При проектировании таблицы orders, можно было использовать декларативное партиционирование с помощью PARTITION BY
и указанием метода разбиения, например так:

```commandline
CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
) PARTITION BY RANGE (price);
CREATE TABLE orders_01 PARTITION OF public.orders FOR VALUES FROM (500) TO (MAXVALUE);
CREATE TABLE orders_02 PARTITION OF public.orders FOR VALUES FROM (MINVALUE) TO (499);

```

---

## Задача 4

Используя утилиту `pg_dump`, создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

<--

Ответ:

```commandline
docker exec -i postgresql-test_db_1 pg_dump -U postgres > new_backup_test_database.sql
```

Про уникальность значения `title` при проектировании таблицы можно было бы использовать свойство UNIQUE,

но так как мы работаем с бэкапом, где уже могут быть не уникальные значения, я считаю что необходимо обновить значение
поля `title` склеив его с уникальным полем `id`.
А если совместить оба подхода то в бекап надо дописать:

```
echo 'UPDATE orders SET title = CONCAT(title,id);' >>  new_backup_test_database.sql
echo 'ALTER TABLE public.orders ADD CONSTRAINT constraint_name UNIQUE (title);' >>  new_backup_test_database.sql
```
---

