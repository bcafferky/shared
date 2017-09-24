Import-Module AzureRM -Verbose

Add-AzureRmAccount

Get-AzureRmSubscription | Select-Object -Property Environment, SubscriptionName

Clear-Host

# Get-AzureRmVM | Format-Table Name,ResourceGroupName,Location -AutoSize
Get-AzureRmVM | Out-GridView

Get-AzureRmResource  -ResourceGroupName BryanRG -ResourceName bryanrgdiag536

Find-AzureRmResource -ResourceNameContains bryan

