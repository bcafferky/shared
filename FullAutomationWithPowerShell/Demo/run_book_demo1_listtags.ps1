# . .\AzureLogin.ps1

Add-AzureRmAccount

# List resources
Get-AzureRmVM | Format-Table Name,ResourceGroupName,Location -AutoSize 

Get-Module -Name AzureRM.Compute

Get-Command -Module AzureRM.Compute
