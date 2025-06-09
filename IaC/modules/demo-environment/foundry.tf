resource "azurerm_ai_services" "demo" {
  name                = "${var.environment_name}-foundry"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo.name
  sku_name            = "S0"
  custom_subdomain_name = "${var.environment_name}-foundry"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_ai_foundry" "demo" {
  name                = "${var.environment_name}-hub"
  location            = azurerm_ai_services.demo.location
  resource_group_name = azurerm_resource_group.demo.name

  storage_account_id = azurerm_storage_account.demo.id
  key_vault_id       = azurerm_key_vault.demo.id

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_ai_foundry_project" "demo" {
  name = "${var.environment_name}-project"

  location           = var.location
  ai_services_hub_id = azurerm_ai_foundry.demo.id

  identity {
    type = "SystemAssigned"
  }
}

locals {
  models = {
    "gpt-4o-mini" = {
      name     = "gpt-4o-mini"
      version  = "2024-07-18"
      capacity = 120
    }
  }
}

resource "azurerm_cognitive_deployment" "models" {
  for_each = local.models

  name                 = each.key
  cognitive_account_id = azurerm_ai_services.demo.id
  rai_policy_name      = "Microsoft.DefaultV2"

  model {
    format  = "OpenAI"
    name    = each.value.name
    version = each.value.version
  }

  sku {
    name     = "GlobalStandard"
    capacity = each.value.capacity
  }
}