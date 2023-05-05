# Домашнее задание к занятию 5. «Elasticsearch»

## Задача 1

В этом задании вы потренируетесь в:

- установке Elasticsearch,
- первоначальном конфигурировании Elasticsearch,
- запуске Elasticsearch в Docker.

Используя Docker-образ [centos:7](https://hub.docker.com/_/centos) как базовый и
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/)

- составьте Dockerfile-манифест для Elasticsearch,
- соберите Docker-образ и сделайте `push` в ваш docker.io-репозиторий,
- запустите контейнер из получившегося образа и выполните запрос пути `/` с хост-машины.

Требования к `elasticsearch.yml`:

- данные `path` должны сохраняться в `/var/lib`,
- имя ноды должно быть `netology_test`.

В ответе приведите:

- текст Dockerfile-манифеста,
- ссылку на образ в репозитории dockerhub,
- ответ `Elasticsearch` на запрос пути `/` в json-виде.

Подсказки:

- возможно, вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum,
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml,
- при некоторых проблемах вам поможет Docker-директива ulimit,
- Elasticsearch в логах обычно описывает проблему и пути её решения.

Далее мы будем работать с этим экземпляром Elasticsearch.

<--

Ответ:

Dockerfile

```dockerfile
FROM centos:7

EXPOSE 9200 9300
RUN yum -y install curl && \
    curl -L -O https://mirrors.huaweicloud.com/elasticsearch/7.10.2/elasticsearch-7.10.2-linux-x86_64.tar.gz && \
    yum -y clean all  && rm -rf /var/cache && \
    groupadd -g 1000 elasticsearch && useradd -ms /bin/bash elasticsearch -u 1000 -g 1000 && \
    tar -xvf elasticsearch-7.10.2-linux-x86_64.tar.gz  && rm elasticsearch-7.10.2-linux-x86_64.tar.gz && \
    mv elasticsearch-7.10.2 /var/lib/elasticsearch && chown -R elasticsearch:elasticsearch /var/lib/elasticsearch

COPY elasticsearch.yml /var/lib/elasticsearch/config/elasticsearch.yml

USER 1000

WORKDIR /var/lib/elasticsearch
CMD ["/var/lib/elasticsearch/bin/elasticsearch"]
```

elasticsearch.yml

```
path:
    data: /var/lib/elasticsearch
node.name: netology_test
network.host: 0.0.0.0
discovery.type: single-node
```

Публикуем образ

```commandline
docker build . -t crankoman/elasticsearch_crank_devops:7.10.2
docker push crankoman/elasticsearch_crank_devops:7.10.2
```

https://hub.docker.com/repository/docker/crankoman/elasticsearch_crank_devops/general

Проверяем и выполняем запрос

```commandline
docker run -p 80:9200 -d crankoman/elasticsearch_crank_devops:7.10.2
b5c8c27927d3d6102deb24aa194f0550b0248ecd875ed36b633aa858c377741c

docker ps
CONTAINER ID   IMAGE                                         COMMAND                  CREATED         STATUS         PORTS                                             NAMES
b5c8c27927d3   crankoman/elasticsearch_crank_devops:7.10.2   "/var/lib/elasticsea…"   4 seconds ago   Up 3 seconds   9300/tcp, 0.0.0.0:80->9200/tcp, :::80->9200/tcp   affectionate_bose

curl localhost
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "8xtwVEdqRf26yogCLObtkw",
  "version" : {
    "number" : "7.10.2",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "747e1cc71def077253878a59143c1f785afa92b9",
    "build_date" : "2021-01-13T00:42:12.435326Z",
    "build_snapshot" : false,
    "lucene_version" : "8.7.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

---

## Задача 2

В этом задании вы научитесь:

- создавать и удалять индексы,
- изучать состояние кластера,
- обосновывать причину деградации доступности данных.

Ознакомьтесь
с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html)
и добавьте в `Elasticsearch` 3 индекса в соответствии с таблицей:

| Имя   | Количество реплик | Количество шард |
|-------|-------------------|-----------------|
| ind-1 | 0                 | 1               |
| ind-2 | 1                 | 2               |
| ind-3 | 2                 | 4               |

Получите список индексов и их статусов, используя API, и **приведите в ответе** на задание.

Получите состояние кластера `Elasticsearch`, используя API.

Как вы думаете, почему часть индексов и кластер находятся в состоянии yellow?

Удалите все индексы.

**Важно**

При проектировании кластера Elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

<--

Ответ:

Создаем индексы, получаем их статусы. Получаем статус кластера
```commandline
curl -H 'Content-Type: application/json' -X PUT localhost/ind-1 -d '{"settings": {"number_of_shards": 1,"number_of_replicas": 0}}'
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-1"}

curl -H 'Content-Type: application/json' -X PUT localhost/ind-2 -d '{"settings": {"number_of_shards": 2,"number_of_replicas": 1}}'
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-2"}

curl -H 'Content-Type: application/json' -X PUT localhost/ind-3 -d '{"settings": {"number_of_shards": 4,"number_of_replicas": 2}}'
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-3"}

curl localhost/_cat/indices?v=true
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 VC7Uxc5SQjSaxCPYl-rN4Q   1   0          0            0       208b           208b
yellow open   ind-3 qsrZpy94Rduou8rFMbIsng   4   2          0            0       832b           832b
yellow open   ind-2 xQNrffQ1RpOKcM0WyjTyfQ   2   1          0            0       416b           416b

curl localhost/_cluster/health?pretty
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 7,
  "active_shards" : 7,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 41.17647058823529
}

```
Часть индексов и кластер находится в статусе yellow:
1. yellow у нас те индексы где мы указали количество реплик отличных от 0, так реплика должна находится на другой ноде, а нода всего одна
2. кластер yellow ведь шарды назначены, но реплики не назначены, так как они не могут находиться на одной ноде.

Удаляем все индексы и проверяем
```commandline
curl -X DELETE localhost/_all
{"acknowledged":true}

curl localhost/_cat/indices?v=truet/_cat/indices?v=true
health status index uuid pri rep docs.count docs.deleted store.size pri.store.size
```

---

## Задача 3

В этом задании вы научитесь:

- создавать бэкапы данных,
- восстанавливать индексы из бэкапов.

Создайте директорию `{путь до корневой директории с Elasticsearch в образе}/snapshots`.

Используя
API, [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository)
эту директорию как `snapshot repository` с именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html)
состояния кластера `Elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`.

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html)
состояние
кластера `Elasticsearch` из `snapshot`, созданного ранее.

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

Подсказки:

- возможно, вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и
  перезапустить `Elasticsearch`.

<--

Ответ:

docker exec magical_sammet bash -c "mkdir /var/lib/elasticsearch/snapshots"

```
echo path.repo: "/var/lib/elasticsearch/snapshots" >> "$ES_HOME/config/elasticsearch.yml"
docker restart elastic
curl -H 'Content-Type: application/json' -X PUT localhost/_snapshot/netology_backup -d '{"type": "fs","settings": {"location": "/var/lib/elasticsearch/snapshots","compress": true}}'
```
---
