# Дипломный проект Муртазина Р.Г., группа DEVOPS-24 #

## Цели: ##

1. Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.
2. Запустить и сконфигурировать Kubernetes кластер.
3. Установить и настроить систему мониторинга.
4. Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.
5. Настроить CI для автоматической сборки и тестирования.
6. Настроить CD для автоматического развёртывания приложения.

Описание самого задания [задание на дипломную практику](./task.md)

### 1. Создание облачной инфраструктуры ###

Для подгтовки облачной инфрастуктуры использем terraform и платформу Yandex.Cloud.
0. Готовим предпологаемую [схему будущего решения](./Схема.drawio). 
1. Создаем сервисный аккаунт в Yandex.Cloud с минимальными, но достаточными правами (`admin` в специальном каталоге `diploma`).
   Создаем папку `yc resource-manager folder create --name diploma`
   Создаем аккаунт `yc iam service-account create --name diploma-sa --folder-name diploma` 
   и назначаем права `yc resource-manager folder add-access-binding diploma --role admin --subject serviceAccount:aje*`
   получаем ключ `yc iam key create --folder-name diploma --service-account-name diploma-sa --output key.json`

2. Готовим terraform который создаст специальную сервисную учетку и S3 бакет для terraform backend в основном проекте [в отдельной папке](./preparation/) и запускаем его
    Результат:

`terraform apply --auto-approve`
<details>
    <summary>подробнее</summary>

```shell
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.backend-conf will be created
  + resource "local_file" "backend-conf" {
      + content              = (sensitive value)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "../terraform/backend.key"
      + id                   = (known after apply)
    }

  # null_resource.example will be created
  + resource "null_resource" "example" {
      + id = (known after apply)
    }

  # yandex_iam_service_account.tf-sa will be created
  + resource "yandex_iam_service_account" "tf-sa" {
      + created_at = (known after apply)
      + folder_id  = (known after apply)
      + id         = (known after apply)
      + name       = "tf-sa"
    }

  # yandex_iam_service_account_static_access_key.tf-key will be created
  + resource "yandex_iam_service_account_static_access_key" "tf-key" {
      + access_key           = (known after apply)
      + created_at           = (known after apply)
      + encrypted_secret_key = (known after apply)
      + id                   = (known after apply)
      + key_fingerprint      = (known after apply)
      + secret_key           = (sensitive value)
      + service_account_id   = (known after apply)
    }

  # yandex_resourcemanager_folder_iam_member.tf-sa-editor will be created
  + resource "yandex_resourcemanager_folder_iam_member" "tf-sa-editor" {
      + folder_id = "b1gfdkd3hs1u4b3d75ri"
      + id        = (known after apply)
      + member    = (known after apply)
      + role      = "editor"
    }

  # yandex_storage_bucket.s3-backet will be created
  + resource "yandex_storage_bucket" "s3-backet" {
      + access_key            = (known after apply)
      + bucket                = "diploma-bucket-mrg"
      + bucket_domain_name    = (known after apply)
      + default_storage_class = (known after apply)
      + folder_id             = (known after apply)
      + force_destroy         = true
      + id                    = (known after apply)
      + secret_key            = (sensitive value)
      + website_domain        = (known after apply)
      + website_endpoint      = (known after apply)

      + anonymous_access_flags {
          + list = false
          + read = false
        }
    }

Plan: 6 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_iam_service_account.tf-sa: Creating...
yandex_iam_service_account.tf-sa: Creation complete after 2s [id=ajeojd3c14kdhu5ff7s7]
yandex_resourcemanager_folder_iam_member.tf-sa-editor: Creating...
yandex_resourcemanager_folder_iam_member.tf-sa-editor: Creation complete after 3s [id=b1gfdkd3hs1u4b3d75ri/editor/serviceAccount:ajeojd3c14kdhu5ff7s7]
yandex_iam_service_account_static_access_key.tf-key: Creating...
null_resource.example: Creating...
null_resource.example: Provisioning with 'local-exec'...
null_resource.example (local-exec): Executing: ["/bin/sh" "-c" "yc iam key create --folder-name diploma --service-account-name tf-sa --output ../terraform/key.json"]
yandex_iam_service_account_static_access_key.tf-key: Creation complete after 2s [id=ajeb4va4p201dttmh682]
yandex_storage_bucket.s3-backet: Creating...
null_resource.example (local-exec): id: ajeu890n8pg7sgc6gcr6
null_resource.example (local-exec): service_account_id: ajeojd3c14kdhu5ff7s7
null_resource.example (local-exec): created_at: "2024-02-18T13:07:50.000436976Z"
null_resource.example (local-exec): key_algorithm: RSA_2048

null_resource.example: Creation complete after 3s [id=9201043436021380133]
yandex_storage_bucket.s3-backet: Creation complete after 7s [id=diploma-bucket-mrg]
local_file.backend-conf: Creating...
local_file.backend-conf: Creation complete after 0s [id=8d42cd261bfb489bd1f36f0ea54277836ecfa277]

Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
```
</details>

3. Готовим [основновной манифест](./terraform/) terraform с VPC и запускаем его
    Результат:

4. Проверяем `terraform destroy` и `terraform apply`
    Результат:
    


---
### 2. Создание Kubernetes кластера

---
### 3. Создание тестового приложения

---
### 4. Подготовка cистемы мониторинга и деплой приложения

---
### 5. Установка и настройка CI/CD

---