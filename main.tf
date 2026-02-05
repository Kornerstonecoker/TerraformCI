terraform {
    required_version = ">=1.14.4"
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "~>3.43.0"
      }
    }
    cloud { 
      organization = "simon-dev-environment" 
      workspaces { 
        name = "TerraformCI" 
      } 
    } 
}

provider "azurerm" {
    features {}
    # skip_provider_registration = true
}


resource "azurerm_resource_group" "rg" {
  name = "tf-free-rg"
  location = "westeurope"
}

resource "azurerm_storage_account" "storage" {
    name = "st${random_string.suffix.result}" #to ensure uniqueness
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = "LRS" #cheapest
}

resource "random_string" "suffix" {
    length = 6
    upper = false
    numeric = true
    special = false
}

