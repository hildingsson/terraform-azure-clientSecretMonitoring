terraform {
  required_version = ">= 0.14.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}
