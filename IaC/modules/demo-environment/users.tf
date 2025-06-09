data "azuread_domains" "current" {
  only_initial = true
}

resource "azuread_user" "demo" {
  user_principal_name = "${var.environment_name}@${data.azuread_domains.current.domains.0.domain_name}"
  display_name        = var.environment_name
  mail_nickname       = var.environment_name
  password            = var.password
}

resource "azurerm_role_assignment" "demo" {
  scope                = azurerm_resource_group.demo.id
  role_definition_name = "Contributor"
  principal_id         = azuread_user.demo.object_id
}

resource "azurerm_role_assignment" "ai_user" {
  scope                = azurerm_ai_services.demo.id
  role_definition_name = "Azure AI User"
  principal_id         = azuread_user.demo.object_id
}

data "azuread_group" "demo" {
  display_name = "foundry-agents-demo-group"
}


resource "azuread_group_member" "demo" {
  group_object_id  = data.azuread_group.demo.object_id
  member_object_id = azuread_user.demo.object_id
}
