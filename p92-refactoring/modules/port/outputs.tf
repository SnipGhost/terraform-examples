output "port_id" {
  value = vkcs_networking_port.this.id
}

output "floating_ip" {
  value = vkcs_networking_floatingip.this.fixed_ip
}
