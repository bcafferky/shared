<#
      Module:   umd_azureautomationdemo 

      Purpose:  Functions for Azure automation demo.

      Author:   Bryan Cafferky   2017-04-10

      Warning:  This code is for demostration only and should not be used
                for production.  No warrantees are implied and this code
                is provided as is. 

#>

function Get-AzureResourceTags 
{ 
<#
        .DESCRIPTION
        Displays the list of tags on a resource.

        .PARAMETER resourcename
        Name of resource.

        .PARAMETER resourcegroup
        Name of resource group.

        .EXAMPLE
        Get-AzureResourceTags -ResourceName 'myresource' -ResourceGroupName 'myrg'

        .NOTES
        Supports PowerShell common parameters such as Verbose. 
#>

 [CmdletBinding()]
       param (
             [string]$resourcename,
             [string]$resourcegroup
             )

   # Get the tags...
   (Get-AzureRmResource -ResourceName $storagename -ResourceGroupName $resourcegroup).Tags

}

function New-udfAzureBlob {
#
# Warning:  This code is for demostration only and should not be used
#           for production.  No warrantees are implied and this code
#           is provided as is. 
#
[CmdletBinding()]
param (
         [Parameter(Mandatory=$true)]
         [string]$ResourceGroupName,
         [Parameter(Mandatory=$true)]
         [string]$StorageAccountName,
         [Parameter(Mandatory=$true)]
         [string]$Location,
         [Parameter(Mandatory=$true)]
         [string]$SubscriptionName,
         [Parameter(Mandatory=$true)]
         [string]$ContainerName,
         [Parameter(Mandatory=$true)]
         [ValidateSet("Standard_LRS","Standard_ZRS","Standard_GRS", "Standard_RAGRS", "Premium_LRS")] 
         [string]$SkuName
   )

   <#  Sku Name Values:

        Standard_LRS. Locally-redundant storage. 
        Standard_ZRS. Zone-redundant storage.
        Standard_GRS. Geo-redundant storage. 
        Standard_RAGRS. Read access geo-redundant storage. 
        Premium_LRS. Premium locally-redundant storage.
   #>

   Write-Verbose "Creating storage acccount: $StorageAccountName."  
   # Create a new storage account.
   New-AzureRMStorageAccount -ResourceGroupName $ResourceGroupName –StorageAccountName $StorageAccountName -Location $Location -SkuName $SkuName -Kind Storage 
 
   Start-Sleep -s 30 

   # Set a default storage account.  
   Write-Verbose "Setting the default storage account: $StorageAccountName."  
   Set-AzureRmCurrentStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName

   # Create a new container.
   Write-Verbose "Creating new container: $ContainerName."
   New-AzureStorageContainer -Name $ContainerName -Permission Off 
   
}

<#

New-udfAzureBlob -ResourceGroupName    "rgbryan" `
                 -StorageAccountName   "bcafferkystorage3" `
                 -Location             "eastus" `
                 -SubscriptionName     "Microsoft Azure Internal Consumption" `
                 -ContainerName        "bcafferkycontainter3" `
                 -SkuName              Standard_LRS -Verbose
#>
                 

function Invoke-HelloWorld 
{
    Write-Output "Hello World!"
}

# Invoke-HelloWorld 