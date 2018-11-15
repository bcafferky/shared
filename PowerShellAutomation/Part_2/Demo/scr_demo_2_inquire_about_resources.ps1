
Import-Module AzureRM -Force -Verbose

Add-AzureRmAccount | Select-Object Environment  # Log In

Login-AzureRMAccount

# Logout-AzureRmAccount

Get-AzureRmSubscription | Select-Object Name, State

Get-AzureRmContext | Select-Object Environment

Get-AzureRmVM | Format-Table Name,ResourceGroupName,Location -AutoSize

# Note:  ExcludeProperty only works when Property is used.  

Get-AzureRmResource -ResourceName MLExpbpc1 -ResourceGroupName rg_ml | SELECT-OBJECT -Property * -ExcludeProperty "SubscriptionId"

Find-AzureRmResource -ResourceNameContains mlex | SELECT-OBJECT -Property * -ExcludeProperty "SubscriptionId"


