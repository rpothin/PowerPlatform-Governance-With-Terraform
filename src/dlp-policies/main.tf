terraform {
  required_providers {
    powerplatform = {
      source  = "microsoft/power-platform"
      version = "2.0.2-preview"
    }
  }

  backend "azurerm" {
    container_name = "terraformstate"
    key            = "dlp-policies.terraform.tfstate"
    use_oidc = true
  }
}

provider "powerplatform" {
  use_oidc = true
}

# Fetch all connectors to dynamically generate non-business and blocked connectors
data "powerplatform_connectors" "all_connectors" {}

# Variables are now centralized in the variables.tf file for better structure and reusability
# Referencing variables from variables.tf for DLP policy configuration
resource "powerplatform_data_loss_prevention_policy" "my_policy" {
  display_name                      = var.display_name
  default_connectors_classification = "Blocked"
  environment_type                  = var.environment_type
  environments                      = var.environments

  # Business connectors are directly taken from the tfvars file
  business_connectors     = var.business_connectors

  # Dynamically generate non-business connectors based on the business connectors specified
  non_business_connectors = [for conn in data.powerplatform_connectors.all_connectors.connectors : {
    id                           = conn.id
    name                         = conn.name
    default_action_rule_behavior = ""
    action_rules                 = [],
    endpoint_rules               = []
  } if conn.unblockable == true && !contains([for bus_conn in var.business_connectors : bus_conn.id], conn.id)]

  # Dynamically generate blocked connectors based on the business connectors specified
  blocked_connectors      = [for conn in data.powerplatform_connectors.all_connectors.connectors : {
    id                           = conn.id
    default_action_rule_behavior = ""
    action_rules                 = [],
    endpoint_rules               = []
  } if conn.unblockable == false && !contains([for bus_conn in var.business_connectors : bus_conn.id], conn.id)]

  # Custom connectors patterns are directly taken from the tfvars file
  custom_connectors_patterns = var.custom_connectors_patterns
}
