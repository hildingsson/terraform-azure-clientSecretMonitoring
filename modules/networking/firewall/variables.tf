variable "subnet" {
  type = object({
    name                 = optional(string)
    resource_group_name  = optional(string)
    virtual_network_name = optional(string)
    address_prefixes     = optional(list(string))
  })
}
