output "instance_ip" {
  value = vkcs_compute_instance.test_vm.access_ip_v4
}

output "router_ip" {
  value = vkcs_networking_router.test_router.external_fixed_ips
}

output "floating_ip" {
  value = vkcs_networking_floatingip.associated_fip.address
}

# To list value use: terraform output -raw private_key
output "private_key" {
  value = vkcs_compute_keypair.default_key_pair.private_key
  sensitive = true
}
