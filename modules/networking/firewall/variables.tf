variable "resource_group" {
  type = object({
    name     = optional(string)
    location = optional(string)
  })
  
}

variable "virtualnetwork" {
  type = object({
    name          = optional(string)
    address_space = optional(list(string))
  })
}

variable "subnet" {
  type = object({
    name = optional(string)
    address_prefixes = optional(list(string))
  })
}
