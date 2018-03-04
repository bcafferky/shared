function New-udfAzureBlob {
#
# Warning:  This code is for demostration only and should not be used
#           for production.  No warrantees are implied and this code
#           is provided as is. 
#
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

New-udfAzureBlob -R "BryanRG" "bryanstoragex2" "eastus" "b3799fcd-83f4-4e79-95b2-1c4a21f2d67e" "bryancontainerx2" "Standard_LRS"

<#
New-udfAzureBlob -ResourceGroupName    "BryanRG" `
                 -StorageAccountName   "bryanstorage8" `
                 -Location             "eastus" `
                 -SubscriptionName     "b3799fcd-83f4-4e79-95b2-1c4a21f2d67e" `
                 -ContainerName        "bryancontainter8" `
                 -SkuName              Standard_LRS -Verbose
#>
                 

# New-AzureStorageContainer -Name "xxx" -Permission Off

<#

# Upload a blob into a container.
Set-AzureStorageBlobContent -Container $ContainerName -File $ImageToUpload

# List all blobs in a container.
Get-AzureStorageBlob -Container $ContainerName

# Download blobs from the container:
# Get a reference to a list of all blobs in a container.
$blobs = Get-AzureStorageBlob -Container $ContainerName

# Create the destination directory.
New-Item -Path $DestinationFolder -ItemType Directory -Force  

# Download blobs into the local destination directory.
$blobs | Get-AzureStorageBlobContent –Destination $DestinationFolder

#>