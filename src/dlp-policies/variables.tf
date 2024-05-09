# Define variables for the DLP policy configuration, including the business connectors group.
variable "display_name" {
  description = "The display name of the DLP policy."
  type        = string
}

variable "environment_type" {
  description = "Default environment handling for the policy (AllEnvironments, ExceptEnvironments, OnlyEnvironments)."
  type        = string
  default     = "OnlyEnvironments"
}

variable "environments" {
  description = "A list of environment IDs to apply the DLP policy to."
  type        = list(string)
}

variable "business_connectors" {
  description = "A set of business connectors configurations."
  type        = set(object({
    id                           = string
    name                         = string
    default_action_rule_behavior = string
    action_rules                 = list(object({
      action_id = string
      behavior  = string
    }))
    endpoint_rules               = list(object({
      behavior = string
      endpoint = string
      order    = number
    }))
  }))
}

variable "custom_connectors" {
  description = "A set of custom connectors configurations."
  type        = set(object({
    order            = number
    host_url_pattern = string
    data_group       = string
  }))
}
