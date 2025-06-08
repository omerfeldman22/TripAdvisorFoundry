variable "subscription_id" {
  description = "The subscription ID in which the resources will be created."
  sensitive   = true
}

variable "base_name" {
  description = "The prefix of the resource group where the resources will be deployed."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
  default     = "Sweden Central"
}

variable "data_location" {
  description = "The Azure region where the data will be stored for the communication service."
  type        = string
  default     = "Europe"
}

variable "ai_services_sku" {
  description = "The SKU for the AI Services."
  type        = string
  default     = "S0"
}

variable "environments_amount" {
  description = "The number of environments to create."
  type        = number
  default     = 8
}

variable "password" {
  description = "The password for the created users."
  type        = string
  sensitive   = true
}