terraform {
    required_providers {
        vkcs = {
            source = "vk-cs/vkcs"
            version = "< 1.0.0"
        }
    }
}

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

provider "vkcs" {
    username = var.provider_username
    password = var.provider_password
    project_id = "ce33222329e64fdea5a371af79b1b746"
    region = "RegionOne"
    auth_url = "https://msk.cloud.vk.com/infra/identity/v3/" 
}
