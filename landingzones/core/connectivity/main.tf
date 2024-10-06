terraform {
  required_version = ">= 0.14.0"

  backend "azurerm" {
    resource_group_name   = "rg-prod-lz-terraform-state"
    storage_account_name  = "stprodjfsnvjrtuhdklnch"
    container_name        = "connectivity-state"
    key                   = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  use_oidc = true
  features {}
}

resource "azurerm_resource_group" "connectivity" {
  name     = "rg-prod-lz-connectivity"
  location = "Sweden Central"
  tags     = var.tags_prod_connectivity
}

module "connectivity_azure_firewall" {
  source = "/home/runner/work/terraform-azure-clientSecretMonitoring/terraform-azure-clientSecretMonitoring/modules/networking/firewall"

  resource_group = {
    name     = "test" #azurerm_resource_group.connectivity.name
    location = "West Europe" #azurerm_resource_group.connectivity.location
  }

  virtual_network = {
    name                = "vnet-firewall-prod-westeu-001"
    address_space       = ["10.0.0.0/24"]
  }

  subnet = {
    name              = "AzureFirewallSubnet"
    address_prefixes  = ["10.0.0.0/26"]
  }
}