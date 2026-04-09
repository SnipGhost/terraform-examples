# Get external network with Internet access
data "vkcs_networking_network" "extnet" {
    sdn        = "sprut"
    external   = true
}

# Create a network
resource "vkcs_networking_network" "test_network" {
    name       = "${var.stand_name}-net"
    sdn        = "sprut"
}

# Create a subnet
resource "vkcs_networking_subnet" "test_subnet" {
    name       = "${var.stand_name}-subnet"
    network_id = vkcs_networking_network.test_network.id
    cidr       = var.private_subnet
}

# Create a router
resource "vkcs_networking_router" "test_router" {
    name       = "${var.stand_name}-router"
    sdn        = "sprut"
    external_network_id = data.vkcs_networking_network.extnet.id
}

# Connect the network to the router
resource "vkcs_networking_router_interface" "test_iface" {
    router_id  = vkcs_networking_router.test_router.id
    subnet_id  = vkcs_networking_subnet.test_subnet.id
}

# Create a port
resource "vkcs_networking_port" "test_port" {
    name = "${var.stand_name}-port"
    admin_state_up = "true"
    network_id = vkcs_networking_network.test_network.id
    fixed_ip {
        subnet_id =  vkcs_networking_subnet.test_subnet.id
        ip_address = "192.168.7.7"
    }
    security_group_ids = [
        data.vkcs_networking_secgroup.ssh.id,
        vkcs_networking_secgroup.secgroup_service.id
    ]
}

# Allocate a floating IP with a port
resource "vkcs_networking_floatingip" "associated_fip" {
  pool    = "internet"
  port_id = vkcs_networking_port.test_port.id
}
