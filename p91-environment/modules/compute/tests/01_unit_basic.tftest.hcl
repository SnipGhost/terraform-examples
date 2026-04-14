run "plan_basic" {
  command = plan

  variables {
    env                    = "test"
    compute_count          = 1
    private_subnet_cidr    = "10.10.0.0/24"
    availability_zone_name = "GZ1"
    compute_flavor         = "STD2-1-1"

    # override'ы (вариант A)
    flavor_id_override              = "fake-flavor-id"
    image_id_override               = "fake-image-id"
    secgroup_default_id_override    = "fake-default-sg-id"
    secgroup_ssh_id_override        = "fake-ssh-sg-id"
  }

  # Проверяем, что создаются ключевые ресурсы
  assert {
    condition     = resource.vkcs_networking_network.stand.name == "test-net"
    error_message = "Должна создаваться сеть stand"
  }

  assert {
    condition     = resource.vkcs_networking_subnet.stand.name == "test-subnet"
    error_message = "Должна создаваться подсеть stand"
  }

  assert {
    condition     = resource.vkcs_networking_subnet.stand.cidr == "10.10.0.0/24"
    error_message = "CIDR подсети должен совпадать с private_subnet_cidr"
  }

  assert {
    condition     = resource.vkcs_compute_keypair.default_key_pair.name == "test-keypair"
    error_message = "Имя keypair должно быть <env>-keypair"
  }

  assert {
    condition     = resource.vkcs_networking_secgroup.icmp.name == "test-icmp"
    error_message = "Имя ICMP security group должно быть <env>-icmp"
  }

  assert {
    condition     = resource.vkcs_networking_secgroup_rule.icmp.protocol == "icmp"
    error_message = "Правило security group должно быть ICMP"
  }

  assert {
    condition     = resource.vkcs_networking_secgroup_rule.icmp.direction == "ingress"
    error_message = "ICMP правило должно быть ingress"
  }
}
