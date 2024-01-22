###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "public_key" {
  type    = string
  default = ""
}

variable ssh_public_key {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8swvFYAaYlCE0Kh8YrokY+MNB0fp0OPefbytHqEkGrTWUnB74nBbiKj1gLxc15+BpFlbywP8MgRmFPHWAampy+CEZt/npYe73MnCgHKMTXynuzU5F1kIj1fb1E29RcXVIpvLHRtha4Af0hx9uIHw3Pee1V58VFPKHdubuLHzy8lXwXcWv4XbaDamHUh3//QddtGhBCKx1VOY6PuIK21z6BTjrTytbsIVQZYmFNmU8ylEu01PKCq3Ivoqih6QaOHmDzVshZNpQ+9NkHHtJbd36FQoddrohTlUvcb8hkf5FaCaGePIsbBPCv0QftuKyOUleAUy9TNxlk1KZE/UTIUgoJb9sU58CkRfy/z8+rAiUkDinlEdkLhUlXyMmd9tAsHujGTZZZFKbDnw37TplPC/TR7i7N2AtYEiYACIjAe0OVOfcgQrZJsj5sryrcFZxBRdfdoJTw7azGxTN71CD3plvuRfT9TvAWfNdOm/X8WYl5vs0VcbucRcv1jh5zq2vW00= root@4SER-1670916090.4server.su"
}