terraform {
  required_providers {
    powerplatform = {
      source  = "microsoft/power-platform"
      version = "2.3.1-preview"
    }
  }

  backend "azurerm" {
    use_oidc = true
  }
}

provider "powerplatform" {
  use_oidc = true
}

data "powerplatform_connectors" "all_connectors" {}

import {
  to = powerplatform_data_loss_prevention_policy.policy
  id = var.id
}

resource "powerplatform_data_loss_prevention_policy" "policy" {
  display_name                      = var.display_name
  default_connectors_classification = "Blocked"
  environment_type                  = var.environment_type
  environments                      = var.environments

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

  custom_connectors_patterns = var.custom_connectors
}