# Домашнее задание к занятию "3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

<--

`docker pull nginx` - получаем базовый образ nginx

`nano Dockerfile` - создаем и заполняем Dockerfile

Содержимое Docker file
```Dockerfile
# используем базовый образ 
FROM nginx:latest 
# Запускаем команду которая заполнит файл по-умолчанию нужным содержимым
RUN \
echo "<html><head>Hey, Netology</head> \ 
<body><h1>I’m DevOps Engineer!</h1> \
</body></html>" > /usr/share/nginx/html/index.html

```

`docker build -t nginx_crank_devops .` - Собираем свой образ на основе докер файла с именем "nginx_crank_devops"

`docker run -p 8080:80 --name nginx_test --rm -d nginx_crank_devops` - запускаем контейнер с ключами, `--name` - имя контейнера, `--rm` - удалить контейнер после установки,  `-d` - запустить контейнер в фоновом режиме

`curl -i localhost:8080` - для проверки запускаем curl на порт 8080

Ответ curl:

```
<html><head>Hey, Netology</head> <body><h1>I’m DevOps Engineer!</h1> </body></html>
```

Отправляем образ в репозиторий

`docker image tag nginx_crank_devops crankoman/nginx_crank_devops:1.0` присваеваем теги образу

`docker image push crankoman/nginx_crank_devops:1.0` - публикуем

Результат:

https://hub.docker.com/r/crankoman/nginx_crank_devops

---

## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- Высоконагруженное монолитное java веб-приложение;
- Nodejs веб-приложение;
- Мобильное приложение c версиями для Android и iOS;
- Шина данных на базе Apache Kafka;
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
- Мониторинг-стек на базе Prometheus и Grafana;
- MongoDB, как основное хранилище данных для java-приложения;
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

<--

<table>
<tr>Сценарий</th><th>Решение</th></tr>
<tr><td>Высоконагруженное монолитное java веб-приложение</td><td>VM или Docker что бы удобнее ограничивать потребляемые ресурсы</td></tr>
<tr><td>Nodejs веб-приложение</td><td>Docker, так как множество зависимостей</td></tr>
<tr><td>Мобильное приложение c версиями для Android и iOS</td><td>Только виртуальные машины, специфические ядра ОС и необходимость выводить интерфейс</td></tr>
<tr><td>Шина данных на базе Apache Kafka</td><td>Удобно использовать в Docker в рамках разработки. В продуктивной среде стоит запускать только на физических или виртуальных машинах из-за высоких требований к диковой подсистеме и сохранности данных</td></tr>
<tr><td>Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana</td><td>Раньше рекомендовалось не использовать контейнеры, т.к. компоненты работали не стабильно и менее производительно. Сейчас можно использовать Docker в продуктивной среде удобно балансировать</td></tr>
<tr><td>Мониторинг-стек на базе Prometheus и Grafana</td><td>Удобно использовать Docker. Удобнее масштабировать и некритична потеря данных</td></tr>
<tr><td>MongoDB, как основное хранилище данных для java-приложения</td><td>Удобно использовать в Docker в рамках разработки. В продуктивной среде стоит запускать только на физических или виртуальных машинах из-за высоких требований к диковой подсистеме и сохранности данных</td></tr>
<tr><td>Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry</td><td>Docker для приложения, так как много связанных приложений(веб-сервер, Ruby бэкенд) тянут множество зависимостей. Физическая или виртуальная машина для базы данных и файлов репозиториев, так как контейниризация плохо подходит лдя этих задач</td></tr>
</table>
---

## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

<--

```
mkdir data
docker run
docker run --rm --name centos_1 -v $(pwd)/data:/data -t -d centos
docker run --rm --name debian_2 -v $(pwd)/data:/data -t -d debian
docker exec -it centos_1 bash -c "echo 'This is some text' > /data/randomtext.txt"
echo 'This is some text2' > data/randomtext2.txt
docker exec -it debian_2 bash -c "ls /data"
randomtext.txt  randomtext2.txt
docker exec -it debian_2 bash -c "cat /data/randomtext.txt /data/randomtext2.txt"
This is some text
This is some text2
```
---
## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

<--

Dockerfile

```
FROM python

# Install Ansible.
RUN pip install ansible

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]

```


`docker build -t ansible_crank_devops .`

`docker image tag ansible_crank_devops crankoman/ansible_crank_devops:1.0`

`docker image push crankoman/ansible_crank_devops:1.0`

https://hub.docker.com/r/crankoman/ansible_crank_devops

---