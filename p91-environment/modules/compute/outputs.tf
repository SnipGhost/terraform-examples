output "compute_vkcs_compute_instance_ip" {
  value = [for i in vkcs_compute_instance.compute : i.access_ip_v4]
}

# To list value use: terraform output -raw default_vkcs_compute_keypair_private_key
output "default_vkcs_compute_keypair_private_key" {
  value     = vkcs_compute_keypair.default_key_pair.private_key
  sensitive = true
}
