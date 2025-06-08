terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.32.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "2.4.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "3.4.0"
    }
  }

  required_version = ">= 1.0"
}