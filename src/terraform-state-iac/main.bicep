/* Deployment scope */
targetScope = 'subscription'

/* Paramters */
@minLength(1)
@description('Primary location for all resources')
param location string

@minLength(3)
@maxLength(3)
@description('Index for the name of the resource group and the resources')
param index string

@minLength(3)
@description('Base name for the name of the resource group and the resources')
param baseName string

/* Resource group */
resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: 'rg-${baseName}-${location}-${index}'
  location: location
}

/* Resources */
module resources './resources.bicep' = {
  name: 'resources'
  scope: resourceGroup
  params: {
    location: location
    baseName: baseName
  }
}

/* Outputs */
output resource_group_name string = resourceGroup.name
output storage_account_name string = resources.outputs.storage_account_name
