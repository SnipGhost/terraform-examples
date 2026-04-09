# Создаем ВМ
resource "vkcs_compute_instance" "test_vm" {
  name            = "${var.stand_name}-vm"
  availability_zone = var.availability_zone
  tags            = ["test"]

  # flavor_name     = "STD2-1-1"
  flavor_id       = data.vkcs_compute_flavor.minimal.id

  config_drive    = "true"
  key_pair        = vkcs_compute_keypair.default_key_pair.name

  security_group_ids = [
    data.vkcs_networking_secgroup.ssh.id,
    vkcs_networking_secgroup.secgroup_service.id
  ]
  
  block_device {
    uuid                  = vkcs_blockstorage_volume.test_volume.id
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = false
  }

  network {
    name = "internet"
  }
}
