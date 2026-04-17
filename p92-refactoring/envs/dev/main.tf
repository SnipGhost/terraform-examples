locals {
  env = "dev"
  subnet_cidr = "192.168.10.0/24"
  ips = [10, 11, 12]
}

module "network" {
  source = "../../modules/network"
  name = local.env
  subnet_cidr = local.subnet_cidr
}

module "router" {
  source = "../../modules/router"
  name = local.env
  subnet_id = module.network.subnet_id
}

data "vkcs_networking_secgroup" "ssh" {
  name = "ssh"
}

data "vkcs_networking_secgroup" "default" {
  name = "default"
}

module "port" {
  for_each = {for ip in local.ips : ip => ip}
  source = "../../modules/port"
  name = local.env
  network_id = module.network.network_id
  subnet_id = module.network.subnet_id
  ip_address = cidrhost(local.subnet_cidr, 10)
  security_groups = [data.vkcs_networking_secgroup.ssh.id, data.vkcs_networking_secgroup.default.id]
}
