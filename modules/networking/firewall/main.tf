terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0"
    }
  }
  required_version = ">= 0.14"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "firewall" {
  name     = var.resourcegroup.name
  location = var.resourcegroup.location
}

resource "azurerm_virtual_network" "firewall" {
  name                = var.virtualnetwork.name
  address_space       = var.virtualnetwork.address_space
  resource_group_name = azurerm_resource_group.firewall.name
  location            = azurerm_resource_group.firewall.location
}

resource "azurerm_subnet" "firewall" {
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.firewall.name
  virtual_network_name = azurerm_virtual_network.firewall.name
  address_prefixes     = each.value.address_prefixes
}
