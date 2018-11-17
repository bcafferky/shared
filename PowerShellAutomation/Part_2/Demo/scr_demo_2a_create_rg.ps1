#  Create a resource group to hold our stuff...

$resourceGroup = 'rgbcafferkyposh'

New-AzureRmResourceGroup -Name $resourceGroup -Location 'East US 2' -Verbose | SELECT-OBJECT -Property * -ExcludeProperty "SubscriptionId"


Remove-AzureRMResourceGroup -Name $resourceGroup 
     
