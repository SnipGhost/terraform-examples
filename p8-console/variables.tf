variable "env" {
  type    = string
  default = "test"
}
variable "data_list" {
  type = list(string)
}
variable "env_map" {
  type = map(string)
}
variable "vms" {
  type = list(object({
    name       = string
    interfaces = list(map(string))
  }))
}
