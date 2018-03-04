. .\AzureLogin.ps1

# List resources
Get-AzureRmVM | Format-Table Name,ResourceGroupName,Location -AutoSize 