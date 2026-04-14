terraform {
  required_providers {
    vkcs = {
      source  = "vk-cs/vkcs"
      version = "< 1.0.0"
    }
  }

  # backend config: backend.hcl
  backend "s3" {}
}
