import-module umd_azureautomationdemo

. .\AzureLogin.ps1

Get-AzureResourceTags -ResourceName 'myresource' -ResourceGroupName 'myrg'
