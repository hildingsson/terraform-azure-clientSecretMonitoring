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

module "azurerm_firewall" {
  source = "../../main.tf"

  resourcegroup = {
    name     = "rg-firewall-prod-westeu-001"
    location = "westeurope"
  }

  virtualnetwork = {
    name                  = "vnet-firewall-prod-westeu-001"
    address_space         = ["10.0.0.0/24"]
    subnet_name           = "AzureFirewallSubnet"
    subnet_address_prefix = ["10.0.0.0/26"]
  }

  publicip = {
    name              = "pip-firewall-prod-westeu-001"
    allocation_method = "Static"
    sku               = "Standard"
  }
}