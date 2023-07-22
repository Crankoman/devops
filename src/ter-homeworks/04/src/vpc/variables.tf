variable "vpc_name" {
  type    = string
  default = "vpc"
  description = "vpc description"
}

variable "subnets" {
  description    = "vpc_subnets description"
  type = map(object({
    zone = string
    cidr = string
  }))
}

variable "labels" {
  type        = map(string)
  description = "Labels to mark resources."
  default     = {}
}