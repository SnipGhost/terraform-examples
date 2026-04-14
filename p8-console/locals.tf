locals {
  # Flatten all interfaces and compute a "network key" from ip/prefix.
  vm_ifaces = flatten([
    for vm in var.vms : [
      for iface in vm.interfaces : {
        vm_name    = vm.name
        iface_name = iface["name"]
        ip         = iface["ip"]
        prefix     = iface["prefix"]
        network    = cidrsubnet("${iface["ip"]}/${iface["prefix"]}", 0, 0)
      }
    ]
  ])

  # Group interfaces by network
  ifaces_by_network = {
    for n in distinct([for x in local.vm_ifaces : x.network]) :
    n => [for x in local.vm_ifaces : x if x.network == n]
  }

  # For each VM, list other VMs that share at least one network with it
  vm_peers_same_network = {
    for vm in var.vms :
    vm.name => sort(distinct(flatten([
      for iface in vm.interfaces : [
        for x in lookup(
          local.ifaces_by_network,
          cidrsubnet("${iface["ip"]}/${iface["prefix"]}", 0, 0),
          []
        ) : x.vm_name if x.vm_name != vm.name
      ]
    ])))
  }
}

output "ifaces_by_network" {
  value = local.ifaces_by_network
}

output "vm_peers_same_network" {
  value = local.vm_peers_same_network
}
