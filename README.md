<p align="center">
    <h1 align="center">
        Power Platform Governance with Terraform
    </h1>
    <h3 align="center">
        A sandbox to try and explore the Terraform provider for Power Platform
    </h3>
</p>

<p align="center">
    <a href="https://github.com/rpothin/PowerPlatform-Governance-With-Terraform/blob/main/LICENSE" alt="Repository License">
        <img src="https://img.shields.io/github/license/rpothin/PowerPlatform-Governance-With-Terraform?color=yellow&label=License" /></a>
    <a href="#watchers" alt="Watchers">
        <img src="https://img.shields.io/github/watchers/rpothin/PowerPlatform-Governance-With-Terraform?style=social" /></a>
    <a href="#forks" alt="Forks">
        <img src="https://img.shields.io/github/forks/rpothin/PowerPlatform-Governance-With-Terraform?style=social" /></a>
    <a href="#stars" alt="Stars">
        <img src="https://img.shields.io/github/stars/rpothin/PowerPlatform-Governance-With-Terraform?style=social" /></a>
</p>

## 🏡 What is the PowerPlatform-Governance-With-Terraform project?

The PowerPlatform-Governance-With-Terraform project is a sandbox to try and explore the Terraform provider for Power Platform.

The goal is to see if the Terraform provider can be effectively used to automate the governance of Power Platform environments.

## 📖 Log book

### Workspace setup

#### Azure Resource Group for Terraform state



#### Service principal

> [!NOTE]
> From what I found, the [Creating an App Registration to use the Power Platform Provider](https://microsoft.github.io/terraform-provider-power-platform/guides/app_registration/) page in the documentation of the Terraform provider for Power Platform is the reference regarding how the service principal should be configured.

1. Create an application registration in [Entra ID](https://entra.microsoft.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade)
2. Once the application registration is created, go to `API Permissions`
3. Add the following permissions

- Dynamics CRM | user_impersonation
- PowerApps Service | User
- Power Platform API
  - AppManagement.ApplicationPackages.Install
  - AppManagement.ApplicationPackages.Read
  - Licensing.BillingPolicies.Read
  - Licensing.BillingPolicies.ReadWrite

> [!NOTE]
> If you don't find the `Power Platform API` API permission, you can follow [this documentation](https://learn.microsoft.com/en-us/power-platform/admin/programmability-authentication-v2#step-2-configure-api-permissions).

4. Under `Expose an API`, add the documented configuration
5. Run the [**New-PowerAppManagementApp**](https://docs.microsoft.com/en-us/powershell/module/microsoft.powerapps.administration.powershell/new-powerappmanagementapp) PowerShell command of the [**Microsoft.PowerApps.Administration.PowerShell**](https://docs.microsoft.com/en-us/powershell/module/microsoft.powerapps.administration.powershell) PowerShell module specifying the **Application (client) ID** of the app registration created in the previous step

```shell
> Add-PowerAppsAccount
> New-PowerAppManagementApp -ApplicationId 00000000-0000-0000-0000-000000000000
```

## 💡 Ideas

- [ ] Automate the workspace setup using a Polyglot Notebook - _allowing to combine code and documentation in the same place_

## ❗ Code of Conduct

I, **Raphael Pothin** ([@rpothin](https://github.com/rpothin)), as creator of this project, am dedicated to providing a welcoming, diverse, and harrassment-free experience for everyone.
I expect everyone visiting or participating in this project to abide by the following [**Code of Conduct**](CODE_OF_CONDUCT.md).
Please read it.

## 📝 License

All files in this repository are subject to the [MIT](LICENSE) license.

## 📚 Resources

### Terraform provider for Power Platform

- [Documentation](https://microsoft.github.io/terraform-provider-power-platform/)
- [Main repo](https://github.com/microsoft/terraform-provider-power-platform)
- [Quickstarts](https://github.com/microsoft/power-platform-terraform-quickstarts)

### Terraform learning

- [Terraform - Get started - Azure](https://developer.hashicorp.com/terraform/tutorials/azure-get-started)