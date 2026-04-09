# Создаем security group
resource "vkcs_networking_secgroup" "secgroup_http" {
  name        = "www"
  description = "security group for http 80"
}

# Создаем securiry group rule
resource "vkcs_networking_secgroup_rule" "secgroup_http" {
  direction         = "ingress"
  port_range_max    = 80
  port_range_min    = 80
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = vkcs_networking_secgroup.secgroup_http.id
  description       = ""
}

# Используем data-ресурс для поиска образа по имени
data "vkcs_images_image" "debian" {
  name = "debian-13-202602051630.gite7a38aaf"
}

# Создаем root volume
resource "vkcs_blockstorage_volume" "test_volume" {
  name              = "test-volume"
  availability_zone = "GZ1"
  volume_type       = "ceph-ssd"
  size              = "10"
  image_id          = data.vkcs_images_image.debian.id
}

# Используем data-ресурс для поиска шаблона ресурсов по имени
data "vkcs_compute_flavor" "minimal" {
  name = "STD2-1-1"
}

# Создаем ВМ
resource "vkcs_compute_instance" "test_vm" {
  name            = "test-vm"
  availability_zone = "GZ1"
  tags            = ["test"]

  # flavor_name     = "STD2-1-1"
  flavor_id       = data.vkcs_compute_flavor.minimal.id

  config_drive    = "true"
  key_pair        = "m-kucherenko"

  security_group_ids = [
    "ssh", "www"
  ]
  
  block_device {
    uuid                  = vkcs_blockstorage_volume.test_volume.id
    source_type           = "volume"
    # volume_size           = "10"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = false
  }

  network {
    name = "internet"
  }
}

