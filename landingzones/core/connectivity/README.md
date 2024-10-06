# Terraform Module: Connectivity

## Overview

This Terraform module is designed to manage the connectivity resources within the Azure landing zone. It includes the creation and configuration of virtual networks, subnets, and other related resources.

## Features

- Creation of Virtual Networks (VNets)
- Subnet configuration
- Network Security Groups (NSGs)
- Route Tables
- Peering configurations

## Requirements

- Terraform >= 0.12
- Azure Provider >= 2.0

## Usage

```hcl
module "connectivity" {
  source = "path/to/this/module"

  resource_group_name = "example-rg"
  location            = "East US"
  vnet_name           = "example-vnet"
  address_space       = ["10.0.0.0/16"]

  subnets = [
    {
      name           = "subnet1"
      address_prefix = "10.0.1.0/24"
    },
    {
      name           = "subnet2"
      address_prefix = "10.0.2.0/24"
    }
  ]

  tags = {
    environment = "dev"
    project     = "example"
  }
}
```

## Inputs

| Name                | Description                                      | Type   | Default | Required |
|---------------------|--------------------------------------------------|--------|---------|----------|
| `resource_group_name` | The name of the resource group                   | `string` | n/a     | yes      |
| `location`          | The Azure region where resources will be created | `string` | n/a     | yes      |
| `vnet_name`         | The name of the virtual network                  | `string` | n/a     | yes      |
| `address_space`     | The address space for the virtual network        | `list(string)` | n/a | yes      |
| `subnets`           | A list of subnets to be created                  | `list(object)` | n/a | yes      |
| `tags`              | A map of tags to assign to the resources         | `map(string)` | `{}` | no       |

## Outputs

| Name           | Description                         |
|----------------|-------------------------------------|
| `connectivity_resource_group_name`      | The name of the Resource Group used for Connectivity resources |
| `connectivity_resource_group_id`   | The ID of the Resource Group used for Connectivity resource  |

## Authors

This module is maintained by the [Your Organization] team.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.