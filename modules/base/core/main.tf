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

resource "azurerm_resource_group" "base" {
  name     = var.resource_group.name
  location = var.resource_group.location
  tags     = var.resource_group.tags
}

resource "azurerm_virtual_network" "base" {
  name                = var.virtual_network.name
  address_space       = var.virtual_network.address_space
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
}