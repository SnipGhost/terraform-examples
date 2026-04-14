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
  type        = string
  default     = "RegionOne"
}

variable "provider_auth_url" {
  description = "Your VKCS provider auth URL"
  type        = string
}

variable "env" {
  type = string
}

variable "availability_zone_name" {
  description = "AZ name"
  type        = string
  default     = "GZ1"
}

variable "compute_flavor" {
  description = "Flavor name"
  type        = string
  default     = "STD2-1-1"
}

variable "private_subnet_cidr" {
  description = "Private subnet cidr"
  type        = string
  default     = "192.168.10.0/24"
}

variable "compute_count" {
  description = "Compute VMs count"
  type        = number
  default     = 1
}

# For tests mocking >

variable "flavor_id_override" {
  description = "Optional: use explicit flavor_id instead of data source"
  type        = string
  default     = null
}

variable "image_id_override" {
  description = "Optional: use explicit image id instead of data source"
  type        = string
  default     = null
}

variable "secgroup_default_id_override" {
  description = "Optional: use explicit default secgroup id instead of data source"
  type        = string
  default     = null
}

variable "secgroup_ssh_id_override" {
  description = "Optional: use explicit ssh secgroup id instead of data source"
  type        = string
  default     = null
}
