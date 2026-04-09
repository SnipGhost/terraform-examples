terraform {
    required_providers {
        vkcs = {
            source = "vk-cs/vkcs"
            version = "< 1.0.0"
        }
    }
}

provider "vkcs" {
    username = var.provider_username
    password = var.provider_password
    project_id = "ce33222329e64fdea5a371af79b1b746"
    region = "RegionOne"
    auth_url = "https://msk.cloud.vk.com/infra/identity/v3/" 
}
