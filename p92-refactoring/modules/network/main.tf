resource "vkcs_networking_network" "this" {
    name       = "${var.name}-net"
    sdn        = "sprut"
}

resource "vkcs_networking_subnet" "this" {
    name       = "${var.name}-subnet"
    network_id = vkcs_networking_network.this.id
    cidr       = var.subnet_cidr
}
