# Azure Firewall Module

This module deploys an Azure Firewall along with its associated resources such as Resource Group, Virtual Network, Subnet, Public IP, and Firewall Policy.

## `main.tf`

### Terraform Configuration

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0"
    }
  }
  required_version = ">= 0.14"
}
```

### Provider Configuration

```hcl
provider "azurerm" {
  features {}
}
```

### Resource Definitions

- **Resource Group**

  ```hcl
  resource "azurerm_resource_group" "firewall" {
    name     = var.resourcegroup.name
    location = var.resourcegroup.location
  }
  ```

- **Virtual Network**

  ```hcl
  resource "azurerm_virtual_network" "firewall" {
    name                = var.virtualnetwork.name
    address_space       = var.virtualnetwork.address_space
    resource_group_name = azurerm_resource_group.firewall.name
    location            = azurerm_resource_group.firewall.location
  }
  ```

- **Subnet**

  ```hcl
  resource "azurerm_subnet" "firewall" {
    for_each = { for idx, fw in var.firewall_policy_rule_collection_groups : idx => fw }
    
    name                 = each.value.name
    resource_group_name  = azurerm_resource_group.firewall.name
    virtual_network_name = azurerm_virtual_network.firewall.name
    address_prefixes     = each.value.address_prefixes
  }
  ```

- **Public IP**

  ```hcl
  resource "azurerm_public_ip" "firewall" {
    name                = var.publicip.name
    location            = azurerm_resource_group.firewall.location
    resource_group_name = azurerm_resource_group.firewall.name
    allocation_method   = var.publicip.allocation_method
    sku                 = var.publicip.sku
  }
  ```

- **Firewall**

  ```hcl
  resource "azurerm_firewall" "firewall" {
    name                = var.firewall.name
    location            = azurerm_resource_group.firewall.location
    resource_group_name = azurerm_resource_group.firewall.name
    sku_name            = var.firewall.sku_name
    sku_tier            = var.firewall.sku_tier
    firewall_policy_id  = azurerm_firewall_policy.firewall.id

    ip_configuration {
      name                 = var.firewall.ip_configuration.name
      subnet_id            = azurerm_subnet.firewall.id
      public_ip_address_id = azurerm_public_ip.firewall.id
    } 
  }
  ```

- **Firewall Policy**

  ```hcl
  resource "azurerm_firewall_policy" "firewall" {
    name                = var.firewall_policy.name
    resource_group_name = azurerm_resource_group.firewall.name
    location            = azurerm_resource_group.firewall.location
  }
  ```

- **Firewall Policy Rule Collection Group**

  ```hcl
  resource "azurerm_firewall_policy_rule_collection_group" "firewall" {
    for_each = { for idx, fw in var.firewall_policy_rule_collection_groups : idx => fw }

    name               = each.value.name
    priority           = each.value.priority
    firewall_policy_id = azurerm_firewall_policy.firewall.id

    dynamic "network_rule_collection" {
      for_each = each.value.firewall_network_rule_collections

      content {
        name     = network_rule_collection.value.name
        priority = network_rule_collection.value.priority
        action   = network_rule_collection.value.action

        dynamic "rule" {
          for_each = network_rule_collection.value.rules
          content {
            name                  = rule.value.name
            source_addresses      = rule.value.source_addresses
            destination_ports     = rule.value.destination_ports
            destination_addresses = rule.value.destination_addresses
            protocols             = rule.value.protocols
          }
        }
      }
    }

    dynamic "application_rule_collection" {
      for_each = each.value.firewall_application_rule_collections

      content {
        name     = application_rule_collection.value.name
        priority = application_rule_collection.value.priority
        action   = application_rule_collection.value.action

        dynamic "rule" {
          for_each = application_rule_collection.value.rules
          content {
            name             = rule.value.name
            source_addresses = rule.value.source_addresses
            destination_urls = rule.value.destination_urls
            protocols {
              type = rule.value.type
              port = rule.value.port
            }
          }
        }
      }
    }
  }
  ```

## `variables.tf`

### Variables

- **Resource Group**

  ```hcl
  variable "resourcegroup" {
    type = object({
      name     = optional(string)
      location = optional(string)
    })
  }
  ```

- **Virtual Network**

  ```hcl
  variable "virtualnetwork" {
    type = object({
      name          = optional(string)
      address_space = optional(list(string))
    })
  }
  ```

- **Subnet**

  ```hcl
  variable "subnet" {
    type = object({
      name = optional(string)
      address_prefixes = optional(list(string))
    })
  }
  ```

- **Public IP**

  ```hcl
  variable "publicip" {
    type = object({
      name              = optional(string)
      allocation_method = optional(string)
      sku               = optional(string)
    })
  }
  ```

- **Firewall**

  ```hcl
  variable "firewall" {
    type = object({
      name     = optional(string) 
      sku_name = optional(string)
      sku_tier = optional(string)
      ip_configuration = object({
        name = optional(string)
      })
    })
  }
  ```

- **Firewall Policy**

  ```hcl
  variable "firewall_policy" {
    type = object({
      name = optional(string)
    })
  }
  ```

- **Firewall Policy Rule Collection Groups**

  ```hcl
  variable "firewall_policy_rule_collection_groups" {
    type = list(object({
      name     = string
      priority = number
      firewall_network_rule_collections = list(object({
        name     = string
        priority = number
        action   = string
        rules = list(object({
          name                  = string
          source_addresses      = list(string)
          destination_ports     = list(string)
          destination_addresses = list(string)
          protocols             = list(string)
        }))
      }))
      firewall_application_rule_collections = list(object({
        name     = string
        priority = number
        action   = string
        rules = list(object({
          name                  = string
          source_addresses      = list(string)
          destination_urls      = list(string)
          protocols = list(object({
            type = list(string)
            port = list(string)
          }))
        }))
      }))
    }))
  }
  ```
