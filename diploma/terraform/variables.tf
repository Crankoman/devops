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
