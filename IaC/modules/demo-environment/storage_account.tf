resource "azurerm_storage_account" "demo" {
  name                     = "${var.environment_name}sa"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.demo.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  shared_access_key_enabled = true
  public_network_access_enabled = true
  allow_nested_items_to_be_public = true
  local_user_enabled = true
}