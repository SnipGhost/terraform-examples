locals {
  secgroup_default_id = coalesce(var.secgroup_default_id_override, try(data.vkcs_networking_secgroup.default.id, null))
  secgroup_ssh_id     = coalesce(var.secgroup_ssh_id_override, try(data.vkcs_networking_secgroup.ssh.id, null))
}

resource "vkcs_networking_secgroup" "icmp" {
  name        = "${local.env}-icmp"
  description = "security group for icmp"
}

resource "vkcs_networking_secgroup_rule" "icmp" {
  direction         = "ingress"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = vkcs_networking_secgroup.icmp.id
}

data "vkcs_networking_secgroup" "ssh" {
  name = "ssh"
}

data "vkcs_networking_secgroup" "default" {
  name = "default"
}

resource "vkcs_networking_network" "stand" {
  name = "${local.env}-net"
  sdn  = "sprut"
}

resource "vkcs_networking_subnet" "stand" {
  name       = "${local.env}-subnet"
  network_id = vkcs_networking_network.stand.id
  cidr       = var.private_subnet_cidr
}

resource "vkcs_networking_port" "compute" {
  for_each       = local.vms
  name           = "${each.value.name}-port"
  admin_state_up = "true"
  network_id     = vkcs_networking_network.stand.id
  fixed_ip {
    subnet_id  = vkcs_networking_subnet.stand.id
    ip_address = each.value.ip
  }
  full_security_groups_control = true

  # For tests mocking:
  # security_group_ids = [
  #   data.vkcs_networking_secgroup.default.id,
  #   data.vkcs_networking_secgroup.ssh.id,
  #   vkcs_networking_secgroup.icmp.id
  # ]
  security_group_ids = [
    local.secgroup_default_id,
    local.secgroup_ssh_id,
    vkcs_networking_secgroup.icmp.id
  ]
}
