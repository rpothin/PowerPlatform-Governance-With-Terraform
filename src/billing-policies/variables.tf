variable "resource_group_name" {
  description = "The name of the Azure resource group."
  type        = string
}

variable "location" {
  description = "The location of the Azure resource group and the Billing policy."
  type        = string
}

variable "billing_policy_display_name" {
  description = "The display name of the Billing policy."
  type        = string
}