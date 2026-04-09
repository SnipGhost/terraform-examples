variable "provider_username" {
    description = "Your VKCS provider account username"
    type        = string
    sensitive   = true
}

variable "provider_password" {
    description = "Your VKCS provider account password"
    type        = string
    sensitive   = true
}

variable "availability_zone" {
    description = "Availability zone for all resources"
    type        = string
    default     = "GZ1"
}

variable "disk_size" {
    description = "Root (bootable) volume size"
    type        = string
    default     = "10"
}

variable "volume_type" {
    description = "Root (bootable) volume type"
    type        = string
    default     = "ceph-ssd"
}

variable "keypair_name" {
    description = "Account keypair name"
    type        = string
}

variable "service_port" {
    description = "Service HTTP port"
    type        = number
    default     = 80
}

variable "service_allowed_network" {
    description = "Service allowed network prefix"
    type        = string
    default     = "0.0.0.0/0"
}
