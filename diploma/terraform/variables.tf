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

variable "vm_resources" {
  type = map(any)
  default = {
    default = {
      "cpu_cores"     = 2
      "memory"        = 2
      "core_fraction" = 20
    }
    master = {
      "cpu_cores"     = 2
      "memory"        = 2
      "core_fraction" = 20
    }
    worker = {
      "cpu_cores"     = 2
      "memory"        = 2
      "core_fraction" = 20
    }
  }
}

