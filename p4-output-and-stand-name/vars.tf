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

variable "provider_project" {
    description = "Your VKCS provider project ID"
    type        = string
}

variable "provider_region" {
    description = "Your VKCS provider region name or ID"
    type = string
    default = "RegionOne"
}

variable "provider_auth_url" {
    description = "Your VKCS provider auth URL"
    type = string
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

variable "stand_name" {
    description = "Resource name prefix for stand"
    type        = string
}
