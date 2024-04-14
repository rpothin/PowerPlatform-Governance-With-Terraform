terraform {
  required_providers {
    powerplatform = {
      source  = "microsoft/power-platform"
      version = "2.0.1"
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

data "powerplatform_connectors" "all_connectors" {}

locals {

  business_connectors = toset([
    {
      action_rules = [
        {
          action_id = "DeleteItem_V2"
          behavior  = "Block"
        },
        {
          action_id = "ExecutePassThroughNativeQuery_V2"
          behavior  = "Block"
        },
      ]
      default_action_rule_behavior = "Allow"
      endpoint_rules = [
        {
          behavior = "Allow"
          endpoint = "contoso.com"
          order    = 1
        },
        {
          behavior = "Deny"
          endpoint = "*"
          order    = 2
        },
      ]
      id = "/providers/Microsoft.PowerApps/apis/shared_sql"
    },
    {
      action_rules                 = []
      default_action_rule_behavior = ""
      endpoint_rules               = []
      id                           = "/providers/Microsoft.PowerApps/apis/shared_approvals"
    },
    {
      action_rules                 = []
      default_action_rule_behavior = ""
      endpoint_rules               = []
      id                           = "/providers/Microsoft.PowerApps/apis/shared_cloudappsecurity"
    }
  ])

  non_business_connectors = toset([for conn
    in data.powerplatform_connectors.all_connectors.connectors :
    {
      id                           = conn.id
      name                         = conn.name
      default_action_rule_behavior = ""
      action_rules                 = [],
      endpoint_rules               = []
    }
    if conn.unblockable == true && !contains([for bus_conn in local.business_connectors : bus_conn.id], conn.id)
  ])

  blocked_connectors = toset([for conn
    in data.powerplatform_connectors.all_connectors.connectors :
    {
      id                           = conn.id
      default_action_rule_behavior = ""
      action_rules                 = [],
      endpoint_rules               = []
    }
  if conn.unblockable == false && !contains([for bus_conn in local.business_connectors : bus_conn.id], conn.id)])
}

resource "powerplatform_data_loss_prevention_policy" "my_policy" {
  display_name                      = "Block All Policy"
  default_connectors_classification = "Blocked"
  environment_type                  = "OnlyEnvironments"
  environments                      = ["Default-7e7df62f-7cc4-4e63-a250-a277063e1be7"]

  business_connectors     = local.business_connectors
  non_business_connectors = local.non_business_connectors
  blocked_connectors      = local.blocked_connectors

  custom_connectors_patterns = toset([
    {
      order            = 1
      host_url_pattern = "https://*.contoso.com"
      data_group       = "Blocked"
    },
    {
      order            = 2
      host_url_pattern = "*"
      data_group       = "Ignore"
    }
  ])
}