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

# New-udfAzureBlob -R "BryanRG" "bryanstoragex2" "eastus" "b3799fcd-83f4-4e79-95b2-1c4a21f2d67e" "bryancontainerx2" "Standard_LRS"

# New-udfAzureBlob -SkuName Standard_GRS   

<#

New-AzureRmResourceGroup -Name 'rg_bcafferkybpc2' -Location 'East US 2' -Verbose

Get-AzureRMSubscription

New-udfAzureBlob -ResourceGroupName    "rg_bcafferkybpc2" `
                 -StorageAccountName   "bcafferkybpc1" `
                 -Location             "eastus" `
                 -SubscriptionName     "Microsoft Azure Internal Consumption" `
                 -ContainerName        "bcafferkycontainterbpc1" `
                 -SkuName              Standard_LRS -Verbose 
#>
                 

