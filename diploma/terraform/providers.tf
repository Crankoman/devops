# Параметры подключения провайдера YC
provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
}


# Подключаем провайдер YC
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"

  # Terraform S3 backend
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "diploma-bucket-mrg"
    region                      = "ru-central1-a"
    key                         = "tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}



