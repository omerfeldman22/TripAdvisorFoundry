provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "azapi" {}

provider "azuread" {}