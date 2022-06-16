# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql

### Ответ
Используя docker поднимаем инстанс PostgreSQL (версию 13), данные БД сохраняем в volume:  
`docker run -d --name 6.4_postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=netology -v data_volume:/data postgres:13`.  
Подключаемся к БД PostgreSQL используя psql: `psql -h 172.17.0.2 -U postgres`.  
Управляющие команды psql для:
- вывода списка БД - `\l`
- подключения к БД - `\c`
- вывода списка таблиц - `\dt`
- вывода описания содержимого таблиц - `\d`
- выхода из psql - `\q`

## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

### Ответ
Создаем БД test_database: `CREATE DATABASE test_database;`.  
Подключаемся к контейнеру и восстанавливаем бэкап БД в test_database:  
`docker exec -it 6.4_postgres bash`, `psql -U postgres test_database < /data/test_dump.sql`.  
Переходим в управляющую консоль psql внутри контейнера:
`psql -h 172.17.0.2 -U postgres`.  
Подключаемся к восстановленной БД и проводим операцию ANALYZE для сбора статистики по таблице:
`\c test_database`, `ANALYZE orders;`.
Используя таблицу pg_stats, находим столбец таблицы orders с наибольшим средним значением размера элементов в байтах с помощью команды:
`SELECT tablename, attname, avg_width FROM pg_stats WHERE avg_width = (SELECT MAX(avg_width) FROM pg_stats WHERE tablename = 'orders');`.
Полученный результат: столбец - **title**, максимальный средний размер элементов в столбце в байтах - **16**.

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

### Ответ
SQL-транзакция для разбиения таблицы на 2:  
```
BEGIN;
CREATE TABLE orders_1 (CHECK (price>499)) INHERITS (orders);
CREATE TABLE orders_2 (CHECK (price<=499)) INHERITS (orders);
COMMIT;
```
Можно было изначально предусмотреть автоматическое создание партиций и занесение данных в них при указанных условиях (значениях price) с помощью функции.

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

### Ответ
Используя утилиту pg_dump создаем бекап БД test_database:  
`docker exec -it 6.4_postgres bash`, `pg_dump -U postgres test_database > /data/backup.sql`.  
Можно добавить в блок CREATE TABLE в бэкап-файле ограничение уникальности UNIQUE для столбца title:
```
CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) UNIQUE,
    price integer DEFAULT 0
);
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---