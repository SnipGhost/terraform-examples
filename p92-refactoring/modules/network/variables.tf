variable "name" {
  description = "Resource name prefix"
  type = string
}

variable "subnet_cidr" {
  type = string
  default = "192.168.10.0/24"
}