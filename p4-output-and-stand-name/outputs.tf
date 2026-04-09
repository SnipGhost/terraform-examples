output "instance_ip" {
  value = vkcs_compute_instance.test_vm.access_ip_v4
}

# To list value use: terraform output -raw private_key
output "private_key" {
  value = vkcs_compute_keypair.default_key_pair.private_key
  sensitive = true
}
