# Создаем ВМ
resource "vkcs_compute_instance" "test_vm" {
  name            = "test-vm"
  availability_zone = var.availability_zone
  tags            = ["test"]

  # flavor_name     = "STD2-1-1"
  flavor_id       = data.vkcs_compute_flavor.minimal.id

  config_drive    = "true"
  key_pair        = var.keypair_name

  security_group_ids = [
    "ssh", "my_service"
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
