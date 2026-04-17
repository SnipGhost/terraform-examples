data "vkcs_networking_network" "extnet" {
    sdn        = "sprut"
    external   = true
}

resource "vkcs_networking_router" "this" {
    name       = "${var.name}-router"
    sdn        = "sprut"
    external_network_id = data.vkcs_networking_network.extnet.id
}

resource "vkcs_networking_router_interface" "this" {
    router_id  = vkcs_networking_router.this.id
    subnet_id  = var.subnet_id
}
