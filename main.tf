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

resource "azurerm_resource_group" "resource_group_connectivity" {
  name     = "rg-prod-lz-connectivity"
  location = "Sweden Central"
  tags     = var.tags_prod_connectivity
}

resource "azurerm_resource_group" "resource_group_management" {
  name     = "rg-prod-lz-management"
  location = "Sweden Central"
  tags     = var.tags_prod_management
}

resource "azurerm_resource_group" "resource_group_identity" {
  name     = "rg-prod-lz-identity"
  location = "Sweden Central"
  tags     = var.tags_prod_identity
}

resource "azurerm_resource_group" "resource_group_app-registration-monitoring" {
  name     = "rg-test-lz-app-registration-monitoring"
  location = "Sweden Central"
  tags     = var.tags_test_app-registration-monitoring
}