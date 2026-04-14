locals {
  env = contains(["default", "dev"], terraform.workspace) ? "dev" : "prod"
  vms = { for i in range(var.compute_count) :
    i => {
      name = "${local.env}-vm-${i}",
      ip   = cidrhost(var.private_subnet_cidr, i + 10)
    }
  }
  # vms = {
  #   vm1 = { name = "${local.env}-vm-0", ip = "192.168.10.10" }
  #   vm2 = { name = "${local.env}-vm-1", ip = "192.168.10.11" }
  #   vm3 = { name = "${local.env}-vm-2", ip = "192.168.10.12" }
  # }
}

data "vkcs_compute_flavor" "default" {
  name = var.compute_flavor
}

data "vkcs_images_image" "ubuntu" {
  visibility = "public"
  default    = true
  properties = {
    mcs_os_distro  = "ubuntu"
    mcs_os_version = "24.04"
  }
}

resource "vkcs_compute_keypair" "default_key_pair" {
  name = "${local.env}-keypair"
}

resource "vkcs_compute_instance" "compute" {
  for_each          = local.vms
  name              = each.value.name
  availability_zone = var.availability_zone_name
  flavor_id         = data.vkcs_compute_flavor.default.id
  key_pair          = vkcs_compute_keypair.default_key_pair.name
  config_drive      = "true"

  block_device {
    uuid                  = data.vkcs_images_image.ubuntu.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-ssd"
    volume_size           = 10
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    port = vkcs_networking_port.compute[each.key].id
  }
}

output "instance_ip" {
  value = [for i in vkcs_compute_instance.compute : i.access_ip_v4]
}

# To list value use: terraform output -raw private_key
output "private_key" {
  value     = vkcs_compute_keypair.default_key_pair.private_key
  sensitive = true
}
