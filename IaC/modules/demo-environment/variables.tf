variable "environment_name" {
  description = "The prefix of the resources that will be deployed."
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
  description = "The SKU for the resources."
  type        = string
  default     = "S0"
}

variable "password" {
  description = "The password for the created users."
  type        = string
  sensitive   = true
}