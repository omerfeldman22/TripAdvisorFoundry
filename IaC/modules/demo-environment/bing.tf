resource "azapi_resource" "bing_search" {
  type                      = "microsoft.bing/accounts@2020-06-10"
  name                      = "${var.environment_name}-bing"
  location                  = "global"
  parent_id                 = azurerm_resource_group.demo.id
  schema_validation_enabled = false

  body = {
    kind = "Bing.Grounding"
    sku = {
      name = "G1"
    }
  }

  response_export_values = ["properties.endpoint"]
}