locals {
  resource_group_names = toset([for i in range(var.environments_amount) : "${var.base_name}${i + 1}"])
}

module "demo_environment" {
  source = "./modules/demo-environment"

  for_each = local.resource_group_names

  environment_name = each.key
  location         = var.location
  data_location = var.data_location
  ai_services_sku = var.ai_services_sku
  password         = var.password
}
