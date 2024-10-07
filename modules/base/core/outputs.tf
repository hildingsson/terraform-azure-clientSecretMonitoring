output "base-resource-group" {
  value       = {
    name     = azurerm_resource_group.base.name
    location = azurerm_resource_group.base.location
    tags     = azurerm_resource_group.base.tags
  }
  description = "value of the base resource group"
}

output "base-virtual-network" {
  value       = {
    name          = azurerm_virtual_network.base.name
    address_space = azurerm_virtual_network.base.address_space
  }
  description = "value of the base virtual network" 
}