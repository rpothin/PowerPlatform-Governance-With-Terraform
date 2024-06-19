terraform {
  required_providers {
    powerplatform = {
      source  = "microsoft/power-platform"
      version = "2.4.1-preview"
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

output "all_connectors" {
  value = data.powerplatform_connectors.all_connectors.connectors
  description = "All Power Platform connectors"
}