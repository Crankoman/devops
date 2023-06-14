variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "platform name"
}

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "platform name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "platform id"
}

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image family"
}



variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "platform id"
}

variable "vm_db_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image family"
}

variable "vm_web_resources" {
  type = map(any)
  default = {
    "cpu_cores"    = 2
    "memory"       = 1
	"core_fraction" = 5
  }
}

variable "vm_db_resources" {
  type = map(any)
  default = {
    "cpu_cores"    = 2
    "memory"       = 2
	"core_fraction" = 20
  }
}

variable "metadata" {
  type = map(any)
  default = {
    "serial-port-enable" = 1
    "ssh-keys"           = "your_public_key"
  }
}