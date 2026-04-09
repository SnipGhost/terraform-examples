# Создаем security group (SDN)
resource "openstack_networking_secgroup_v2" "secgroup_http" {
  name        = "www"
  description = "security group for http 80"
}

# Создаем security group rule (ingress tcp/80)
resource "openstack_networking_secgroup_rule_v2" "secgroup_http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_http.id
  description       = ""
}

# Ищем образ по имени (Glance)
data "openstack_images_image_v2" "debian" {
  name        = "debian-13-202602051630.gite7a38aaf"
  most_recent = true
}

# Создаем root volume из image (Cinder)
resource "openstack_blockstorage_volume_v3" "test_volume" {
  name              = "test-volume"
  availability_zone = "GZ1"
  volume_type       = "ceph-ssd"
  size              = 10
  image_id          = data.openstack_images_image_v2.debian.id
}

# Ищем flavor по имени (Nova)
data "openstack_compute_flavor_v2" "minimal" {
  name = "STD2-1-1"
}

# (Опционально) получаем сеть по имени, чтобы использовать UUID
data "openstack_networking_network_v2" "internet" {
  name = "internet"
}

# Создаем ВМ (Nova)
resource "openstack_compute_instance_v2" "test_vm" {
  name              = "test-vm"
  availability_zone = "GZ1"

  flavor_id    = data.openstack_compute_flavor_v2.minimal.id
  config_drive = true
  key_pair     = "m-kucherenko"

  # В OpenStack provider обычно указывают имена security groups
  security_groups = ["ssh", openstack_networking_secgroup_v2.secgroup_http.name]

  block_device {
    uuid                  = openstack_blockstorage_volume_v3.test_volume.id
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = false
  }

  network {
    uuid = data.openstack_networking_network_v2.internet.id
    # можно и name = "internet", но uuid надежнее
  }

  # Аналог tags (если поддерживается вашим OpenStack/Nova):
  metadata = {
    tag = "test"
  }
}