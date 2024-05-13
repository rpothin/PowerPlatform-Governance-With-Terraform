terraform {
  required_providers {
    powerplatform = {
      source  = "microsoft/power-platform"
      version = "2.0.2-preview"
    }
  }

  backend "azurerm" {
    use_oidc = true
  }
}

provider "powerplatform" {
  use_oidc = true
}

# Fetch the details of the current Azure subscription
data "azurerm_subscription" "current" {}

# Create an Azure resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "powerplatform_billing_policy" "pay_as_you_go" {
  name     = var.billing_policy_display_name
  location = var.location
  status   = "Enabled"
  billing_instrument = {
    resource_group  = azurerm_resource_group.rg.name
    subscription_id = data.azurerm_subscription.current.subscription_id
  }
}