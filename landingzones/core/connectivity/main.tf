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

module "connectivity_azure_firewall" {
  source = "/home/runner/work/terraform-azure-clientSecretMonitoring/terraform-azure-clientSecretMonitoring/modules/networking/firewall"

  resource_group = {
    name     = "rg-prod-lz-connectivity"
    location = "West Europe"
    tags     = {
      CanBeDeleted = "True"
      Environment  = "Production"
      Owner        = "Jimmy Hildingsson"
      Deployment   = "GitHub Actions"
      CodeStack    = "Terraform"
      Workload     = "Connectivity"
    }
  }

  virtual_network = {
    name                = "vnet-firewall-prod-westeu-001"
    address_space       = ["10.0.0.0/24"]
  }

  /*subnet = {
    name              = "AzureFirewallSubnet"
    address_prefixes  = ["10.0.0.0/26"]
  }*/
}