# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению

1. * Необязательно. Изучите, что такое [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY).
2. Создайте свой публичный репозиторий на GitHub с произвольным именем или используйте старый.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

<-- Ответ

`docker-compose.yml`

```yaml
version: '3.9'
services:
  clickhouse-01:
    image: pycontribs/centos:7
    container_name: clickhouse-01
    restart: unless-stopped
    entrypoint: "sleep infinity"

  vector-01:
    image: pycontribs/centos:7
    container_name: vector-01
    restart: unless-stopped
    entrypoint: "sleep infinity"
```

---

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.

<-- Ответ


`inventory/prod.yml`

```yaml
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_connection: docker
      
vector:
  hosts:
    vector-01:
      ansible_connection: docker
```

---

2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2.

<-- Ответ

```

```
---

3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.

<-- Ответ

```

```
---

4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.

<-- Ответ

```

```

---

5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.

<-- Ответ

```

```

---

6. Попробуйте запустить playbook на этом окружении с флагом `--check`.

<-- Ответ

```

```

---

7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.

<-- Ответ

```

```

---

8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.

<-- Ответ

```

```

---

9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook).

<-- Ответ

```

```

---

10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

<-- Ответ

```

```

---