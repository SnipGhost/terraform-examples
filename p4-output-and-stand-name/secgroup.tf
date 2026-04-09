# Создаем security group
resource "vkcs_networking_secgroup" "secgroup_service" {
  name        = "my_service"
  description = "security group for http"
}

# Создаем securiry group rule
resource "vkcs_networking_secgroup_rule" "secgroup_service" {
  direction         = "ingress"
  port_range_min    = var.service_port
  port_range_max    = var.service_port
  protocol          = "tcp"
  remote_ip_prefix  = var.service_allowed_network
  security_group_id = vkcs_networking_secgroup.secgroup_service.id
  description       = ""
}
