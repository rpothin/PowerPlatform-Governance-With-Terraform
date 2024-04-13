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

The Bicep infrastructure as code that need to be deployed to manage the Terraform state files related to our Terraform infrastructure as code for Power Platform governance is located in the [src/terraform-state-iac](./src/terraform-state-iac/) folder.

To deploy it, you can follow one of the options below.

##### Option 1: Using the deployment pane from the VS Code extension

From VS Code, with the Bicep extension installed,
1. Right-click on the `main.bicep` file under [src/terraform-state-iac](./src/terraform-state-iac/)
2. Select `Show deployment pane`
3. In the deployment pane, click on the `Pick Scope` button
4. Sign in to Azure
5. Select the Azure subscription where you want to deploy the resources
6. Enter the values for the different parameters
7. Click on the `Validate` button to validate the Bicep file combined with the parameters
8. Click on the `What-If` button to see what resources will be deployed
9. Click on the `Deploy` button to deploy the resources

##### Option 2: Using the Azure CLI

1. Update the `main.bicepparam` file with the values you want to use.
2. In a terminal positioned in the [src/terraform-state-iac](./src/terraform-state-iac/) folder, run the following commands:

```shell
# Install the Bicep CLI
az bicep install
az bicep version

# Connect to Azure
az login

# Set the subscription
az account set --subscription "Your Subscription Name"

# Validate the Bicep file and parameters
az deployment sub validate --location "Your Location" --template-file main.bicep --parameters main.bicepparam

# Check the impact of the deployment
az deployment sub what-if --location "Your Location" --template-file main.bicep --parameters main.bicepparam

# Deploy the resources
az deployment sub create --location "Your Location" --template-file main.bicep --parameters main.bicepparam
```

#### Service principal

> [!NOTE]
> From what I found, the [Creating an App Registration to use the Power Platform Provider](https://microsoft.github.io/terraform-provider-power-platform/guides/app_registration/) page in the documentation of the Terraform provider for Power Platform is the reference regarding how the application registration should be configured.

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