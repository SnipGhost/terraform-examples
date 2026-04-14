run "apply_smoke" {
  command = apply

  variables {
    env                 = "it"
    compute_count       = 1
    private_subnet_cidr = "10.20.0.0/24"
  }

  # Проверяем, что output instance_ip имеет 1 элемент (compute_count=1)
  assert {
    condition     = length(output.compute_vkcs_compute_instance_ip) == 1
    error_message = "instance_ip должен содержать 1 IP"
  }

  # private_key sensitive, но в тесте можно проверить что не пустой (если провайдер возвращает)
  assert {
    condition     = output.default_vkcs_compute_keypair_private_key != ""
    error_message = "private_key не должен быть пустым"
  }
}
