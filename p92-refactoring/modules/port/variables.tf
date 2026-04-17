variable "name" {
  description = "Resource name prefix"
  type = string
}

variable "subnet_id" {
  type = string
}

variable "network_id" {
  type = string
}

variable "ip_address" {
  type = string
}

variable "security_groups" {
  description = "Security group ID list"
  type = list(string)
}