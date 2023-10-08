# Домашнее задание к занятию 12 «GitLab»

## Подготовка к выполнению


1. Или подготовьте к работе Managed GitLab от yandex cloud [по инструкции](https://cloud.yandex.ru/docs/managed-gitlab/operations/instance/instance-create) .
Или создайте виртуальную машину из публичного образа [по инструкции](https://cloud.yandex.ru/marketplace/products/yc/gitlab ) .
2. Создайте виртуальную машину и установите на нее gitlab runner, подключите к вашему серверу gitlab  [по инструкции](https://docs.gitlab.com/runner/install/linux-repository.html) .

3. (* Необязательное задание повышенной сложности. )  Если вы уже знакомы с k8s попробуйте выполнить задание, запустив gitlab server и gitlab runner в k8s  [по инструкции](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/gitlab-containers). 

4. Создайте свой новый проект.
5. Создайте новый репозиторий в GitLab, наполните его [файлами](./repository).
6. Проект должен быть публичным, остальные настройки по желанию.

<-- Ответ

![2023-10-08_02-18-04.png](img%2F2023-10-08_02-18-04.png)
https://crankoman.gitlab.yandexcloud.net/crankoman/my-gitlab

---

## Основная часть

### DevOps

В репозитории содержится код проекта на Python. Проект — RESTful API сервис. 
Ваша задача — автоматизировать сборку образа с выполнением python-скрипта:

1. Образ собирается на основе [centos:7](https://hub.docker.com/_/centos?tab=tags&page=1&ordering=last_updated).
2. Python версии не ниже 3.7.
3. Установлены зависимости: `flask` `flask-jsonpify` `flask-restful`.
4. Создана директория `/python_api`.
5. Скрипт из репозитория размещён в /python_api.
6. Точка вызова: запуск скрипта.
7. При комите в любую ветку должен собираться docker image с форматом имени hello:gitlab-$CI_COMMIT_SHORT_SHA . Образ должен быть выложен в Gitlab registry или yandex registry.   

<-- Ответ

`.gitlab-ci.yml`
```yaml
image: docker:24.0.6
services:
  - "docker:24.0.6-dind"


stages:          # List of stages for jobs, and their order of execution
  - build
  - deploy

build-job:       # This job runs in the build stage, which runs first.
  stage: build
  script:
    - docker build --squash -t $CI_REGISTRY/$CI_PROJECT_PATH/hello:gitlab-$CI_COMMIT_SHORT_SHA .
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
    - docker push $CI_REGISTRY/$CI_PROJECT_PATH/hello:gitlab-$CI_COMMIT_SHORT_SHA
  except:
    - main
deploy-job:      # This job runs in the deploy stage.
  stage: deploy  # It only runs when *both* jobs in the test stage complete successfully.
  script:
    - docker build -t $CI_REGISTRY/$CI_PROJECT_PATH/python-api:latest .
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
    - docker push $CI_REGISTRY/$CI_PROJECT_PATH/python-api:latest
  only:
    - main
```

```dockerfile
FROM centos:7
EXPOSE 5290 5290
RUN yum -y groupinstall "Development Tools" \
    && yum -y install openssl-devel bzip2-devel libffi-devel \
    && curl -O https://www.python.org/ftp/python/3.8.18/Python-3.8.18.tgz \
    && tar xvf Python-3.8.18.tgz \
    && rm -f Python-3.8.18.tgz \
    && cd Python-3.8*/ \
    && ./configure && make -j2 && make install \
    && rm -rf ../Python-3.8*
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
COPY python-api.py python-api.py
CMD ["python3", "python-api.py"]
```

`requirements.txt`
```text
flask
flask_restful
flask_jsonpify
```

![2023-10-08_04-18-44.png](img%2F2023-10-08_04-18-44.png)

---

### Product Owner

Вашему проекту нужна бизнесовая доработка: 
нужно поменять JSON ответа на вызов метода GET `/rest/api/get_info`, 
необходимо создать Issue в котором указать:

1. Какой метод необходимо исправить.
2. Текст с `{ "message": "Already started" }` на `{ "message": "Running"}`.
3. Issue поставить label: feature.


<-- Ответ

![2023-10-08_04-23-19.png](img%2F2023-10-08_04-23-19.png)

---

### Developer

Пришёл новый Issue на доработку, вам нужно:

1. Создать отдельную ветку, связанную с этим Issue.
2. Внести изменения по тексту из задания.
3. Подготовить Merge Request, влить необходимые изменения в `master`, проверить, что сборка прошла успешно.

<-- Ответ
![screencapture-crankoman-gitlab-yandexcloud-net-crankoman-my-gitlab-merge-requests-4-2023-10-08-14_29_22.png](img%2Fscreencapture-crankoman-gitlab-yandexcloud-net-crankoman-my-gitlab-merge-requests-4-2023-10-08-14_29_22.png)
---

### Tester

Разработчики выполнили новый Issue, необходимо проверить валидность изменений:

1. Поднять докер-контейнер с образом `python-api:latest` и проверить возврат метода на корректность.
2. Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый.

<-- Ответ
![screencapture-crankoman-gitlab-yandexcloud-net-crankoman-my-gitlab-issues-1-2023-10-08-14_27_49.png](img%2Fscreencapture-crankoman-gitlab-yandexcloud-net-crankoman-my-gitlab-issues-1-2023-10-08-14_27_49.png)
![2023-10-08_14-26-56.png](img%2F2023-10-08_14-26-56.png)
---

## Итог

В качестве ответа пришлите подробные скриншоты по каждому пункту задания:

- файл gitlab-ci.yml;
- Dockerfile; 
- лог успешного выполнения пайплайна;
- решённый Issue.

<-- Ответ



---