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

data "powerplatform_data_loss_prevention_policies" "all_dlp_policies" {}

output "all_dlp_policies" {
  value = data.powerplatform_data_loss_prevention_policies.all_dlp_policies
  description = "All DLP policies"
}