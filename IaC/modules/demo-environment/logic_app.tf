data "azurerm_managed_api" "acsemail" {
    name                = "acsemail"
    location            = var.location
}


resource "azurerm_api_connection" "acsemail" {
  name                = "${var.environment_name}-acsemail"
  resource_group_name = azurerm_resource_group.demo.name
  managed_api_id      = data.azurerm_managed_api.acsemail.id
  display_name        = "${var.environment_name}-acsemail"

  parameter_values = {
    api_key = azurerm_communication_service.demo.primary_connection_string
  }

  lifecycle {
    ignore_changes = ["parameter_values"]
  }
}

resource "azurerm_logic_app_workflow" "demo" {
  name = "${var.environment_name}-mailer"
  enabled                            = true
  location                           = var.location
  
  parameters = {
    "$connections" = "{\"acsemail\":{\"connectionId\":\"${azurerm_api_connection.acsemail.id}\",\"connectionName\":\"${var.environment_name}-acsemail\",\"id\":\"${data.azurerm_managed_api.acsemail.id}\"}}"
  }
  resource_group_name = azurerm_resource_group.demo.name

  workflow_parameters = {
    "$connections" = "{\"defaultValue\":{},\"type\":\"Object\"}"
  }
  workflow_schema  = "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#"
  workflow_version = "1.0.0.0"

  depends_on = [ azurerm_api_connection.acsemail, data.azurerm_managed_api.acsemail ]
}

resource "azurerm_logic_app_trigger_custom" "trigger" {
  name         = "When_a_HTTP_request_is_received"
  logic_app_id = azurerm_logic_app_workflow.demo.id

  body = jsonencode({
                "type": "Request",
                "kind": "Http",
                "inputs": {
                    "method": "POST",
                    "schema": {
                        "type": "object",
                        "properties": {
                            "to": {
                                "type": "string"
                            },
                            "title": {
                                "type": "string"
                            },
                            "content": {
                                "type": "string"
                            }
                        }
                    }
                },
                "description": "HTTP Trigger that receives the following body and sends mail with content and title"
            
  })

}

resource "azurerm_logic_app_action_custom" "step_2" {
  body = jsonencode({
    inputs = {
      body = {
        content = {
          html    = "<p class=\"editor-paragraph\">@{triggerBody()?['content']}</p>"
          subject = "@triggerBody()?['title']"
        }
        importance = "Normal"
        recipients = {
          to = [{
            address = "@triggerBody()?['to']"
          }]
        }
        senderAddress = "DoNotReply@${azurerm_email_communication_service_domain.demo.from_sender_domain}"
      }
      host = {
        connection = {
          name = "@parameters('$connections')['acsemail']['connectionId']"
        }
      }
      method = "post"
      path   = "/emails:sendGAVersion"
      queries = {
        api-version = "2023-03-31"
      }
    }
    runAfter = {}
    type     = "ApiConnection"
  })
  logic_app_id = azurerm_logic_app_workflow.demo.id
  name         = "Send_email"
  depends_on = [
    azurerm_logic_app_workflow.demo,
  ]
}

resource "azurerm_logic_app_action_custom" "step_3" {
  body = jsonencode({
    inputs = {
      body       = "good"
      statusCode = 200
    }
    kind = "Http"
    runAfter = {
      Send_email = ["Succeeded"]
    }
    type = "Response"
  })
  logic_app_id = azurerm_logic_app_workflow.demo.id
  name         = "Response"
  depends_on = [
    azurerm_logic_app_workflow.demo,
    azurerm_logic_app_action_custom.step_2
  ]
}
