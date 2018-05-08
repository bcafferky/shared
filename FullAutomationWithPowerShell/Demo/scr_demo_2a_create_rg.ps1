#  Create a resource group to hold our stuff...

$resourceGroup = 'bcafferkyrg'

New-AzureRmResourceGroup -Name $resourceGroup -Location 'East US 2' -Verbose
     
