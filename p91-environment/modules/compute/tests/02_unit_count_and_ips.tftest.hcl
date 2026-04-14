run "plan_count_and_ips" {
  command = plan

  variables {
    env                 = "stage"
    compute_count       = 3
    private_subnet_cidr = "192.168.50.0/24"

    # override'ы (вариант A)
    flavor_id_override              = "fake-flavor-id"
    image_id_override               = "fake-image-id"
    secgroup_default_id_override    = "fake-default-sg-id"
    secgroup_ssh_id_override        = "fake-ssh-sg-id"
  }

  # Количество портов и инстансов должно совпадать с compute_count
  assert {
    condition     = length(resource.vkcs_networking_port.compute) == 3
    error_message = "Должно создаваться 3 порта (по compute_count)"
  }

  assert {
    condition     = length(resource.vkcs_compute_instance.compute) == 3
    error_message = "Должно создаваться 3 инстанса (по compute_count)"
  }

  # Проверяем имена VM
  assert {
    condition     = resource.vkcs_compute_instance.compute[0].name == "stage-vm-0"
    error_message = "Неверное имя для vm-0"
  }

  assert {
    condition     = resource.vkcs_compute_instance.compute[1].name == "stage-vm-1"
    error_message = "Неверное имя для vm-1"
  }

  assert {
    condition     = resource.vkcs_compute_instance.compute[2].name == "stage-vm-2"
    error_message = "Неверное имя для vm-2"
  }

  # Проверяем фиксированные IP (i+10)
  assert {
    condition     = resource.vkcs_networking_port.compute[0].fixed_ip[0].ip_address == "192.168.50.10"
    error_message = "Неверный fixed IP для порта 0"
  }

  assert {
    condition     = resource.vkcs_networking_port.compute[1].fixed_ip[0].ip_address == "192.168.50.11"
    error_message = "Неверный fixed IP для порта 1"
  }

  assert {
    condition     = resource.vkcs_networking_port.compute[2].fixed_ip[0].ip_address == "192.168.50.12"
    error_message = "Неверный fixed IP для порта 2"
  }
}
