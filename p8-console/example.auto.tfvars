data_list = ["hello", "world", "!"]

env_map = {
  "dev"   = "test",
  "stage" = "pre-prod",
  "prod"  = "",
}

vms = [
  {
    "name" = "first",
    "interfaces" = [
      {
        "name"   = "eth0"
        "ip"     = "192.168.8.81"
        "prefix" = "24"
      },
      {
        "name"   = "eth1"
        "ip"     = "172.27.0.1"
        "prefix" = "16"
      },
    ]
  },
  {
    "name" = "second",
    "interfaces" = [
      {
        "name"   = "enp3s0"
        "ip"     = "192.168.8.82"
        "prefix" = "24"
      },
    ]
  },
  {
    "name" = "third",
    "interfaces" = [
      {
        "name"   = "eth0"
        "ip"     = "192.168.7.83"
        "prefix" = "24"
      },
    ]
  },
]
