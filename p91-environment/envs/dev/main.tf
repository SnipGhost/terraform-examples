module "compute" {
  source = "../../modules/compute"

  env                 = var.env
  compute_count       = var.compute_count
  private_subnet_cidr = var.private_subnet_cidr
  provider_auth_url   = var.provider_auth_url
  provider_username   = var.provider_username
  provider_password   = var.provider_password
  provider_project    = var.provider_project
  provider_region     = var.provider_region
}
