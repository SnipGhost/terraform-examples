# Create a port
resource "vkcs_networking_port" "this" {
    name = "${var.name}-port"
    admin_state_up = "true"
    network_id = var.network_id
    fixed_ip {
        subnet_id =  var.subnet_id
        ip_address = var.ip_address
    }
    security_group_ids = var.security_groups
    full_security_groups_control = true
}

resource "vkcs_networking_floatingip" "this" {
  pool    = "internet"
  port_id = vkcs_networking_port.this.id
}
