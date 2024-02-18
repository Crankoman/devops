variable "token" {
  type = string
}

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "bucket_name" {
  type    = string
  default = "diploma-bucket-mrg"
}

variable "a_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "b_zone" {
  type    = string
  default = "ru-central1-b"
}

variable "d_zone" {
  type    = string
  default = "ru-central1-d"
}

variable "vpc_name" {
  type    = string
  default = "net"
}
