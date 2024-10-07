terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
  required_version = ">= 0.14"
}

provider "azurerm" {
  features {}
}

resource "azurerm_subnet" "firewall" {
  name                 = var.subnet.name
  resource_group_name  = var.subnet.resource_group_name
  virtual_network_name = var.subnet.virtual_network_name
  address_prefixes     = var.subnet.address_prefixes
}
