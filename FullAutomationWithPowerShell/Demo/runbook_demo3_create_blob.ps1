. .\AzureLogin.ps1

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

New-udfAzureBlob -ResourceGroupName    $ResourceGroupName `
                 -StorageAccountName   $StorageAccountName `
                 -Location             $Location `
                 -SubscriptionName     "Microsoft Azure Internal Consumption" `
                 -ContainerName        $ContainerName `
                 -SkuName              Standard_LRS -Verbose
