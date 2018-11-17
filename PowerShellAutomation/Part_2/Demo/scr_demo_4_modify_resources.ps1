#
# Warning:  This code is for demostration only and should not be used
#           for production.  No warrantees are implied and this code
#           is provided as is. 
#

<#
    Changing Resources...

    Note:  -Force parameter suppresses the confirmation dialog box.



#>

Clear-Host

$resourcegroup = 'rgbryan'
$storagename = 'bcafferkystorage1'

# Clear out the tags...
Set-AzureRmResource -Tag @{  } -Force -ResourceName $storagename -ResourceGroupName $resourcegroup -ResourceType Microsoft.Storage/storageAccounts | SELECT-OBJECT -Property * -ExcludeProperty "SubscriptionId"


# Create new tags...
Set-AzureRmResource -Tag @{ Dept="IT"; Environment="Test" } -Force -ResourceName $storagename -ResourceGroupName $resourcegroup -ResourceType Microsoft.Storage/storageAccounts | SELECT-OBJECT -Property * -ExcludeProperty "SubscriptionId"


# Adding more tages to a resource with tags...
$tags = (Get-AzureRmResource -ResourceName $storagename -ResourceGroupName $resourcegroup).Tags
$tags
$tags += @{Status="Approved"}
$tags

Set-AzureRmResource -Tag $tags -Force -ResourceName $storagename -ResourceGroupName $resourcegroup -ResourceType Microsoft.Storage/storageAccounts | SELECT-OBJECT -Property * -ExcludeProperty "SubscriptionId"


# Get the tags...
(Get-AzureRmResource -ResourceName $storagename -ResourceGroupName $resourcegroup).Tags



