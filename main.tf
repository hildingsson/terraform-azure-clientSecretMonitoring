terraform {
  required_version = ">= 0.14.0"

  backend "azurerm" {
    resource_group_name   = "rg-prod-lz-terraform-state"
    storage_account_name  = "stprodjfsnvjrtuhdklnch"
    container_name        = "terraform-state"
    key                   = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.99.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  use_oidc = true
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

resource "azurerm_resource_group" "resource_group_web-application" {
  name     = "rg-prod-lz-web-application"
  location = "Sweden Central"
  tags     = var.tags_prod_web-application
}