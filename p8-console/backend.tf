terraform {
  backend "s3" {
    bucket = "mcs0411372075"
    key    = "states/p8/terraform.tfstate"
    region = "ru-msk"
    endpoints = {
      s3 = "https://hb.ru-msk.vkcloud-storage.ru"
    }

    # Common for S3-compatible storages
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true

    # Recommended, but SSE not supported
    encrypt      = true
    use_lockfile = true
  }
}
