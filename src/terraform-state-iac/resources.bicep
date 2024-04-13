/* Deployment scope */
targetScope = 'resourceGroup'

/* Parameters */
@minLength(1)
@description('Primary location for all resources')
param location string = resourceGroup().location

@minLength(3)
@description('Base name for the name of the resource group and the resources')
param baseName string

/* Resources */
/* Storage account */
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'st${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
      name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
      accessTier: 'Hot'
      encryption: {
          keySource: 'Microsoft.Storage'
          services: {
              blob: {
                  enabled: true
              }
          }
      }
  }
}

/* Blob service */
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  name: 'default'
  parent: storageAccount
}

/* Container */
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: baseName
  properties: {
      publicAccess: 'None'
  }
}

/* Output */
output storage_account_name string = storageAccount.name
output container_name string = container.name
