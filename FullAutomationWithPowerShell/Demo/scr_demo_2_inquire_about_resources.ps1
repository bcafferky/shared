

Import-Module AzureRM

Add-AzureRmAccount | Select-Object Environment  # Log In

# Logout-AzureRmAccount

Get-AzureRmBillingInvoice

Get-AzureRmSubscription | Select-Object Name, State

Select-AzureRmSubscription -SubscriptionName "Microsoft"

Get-AzureRmContext | Select-Object Environment

Get-AzureRmVM | Format-Table Name,ResourceGroupName,Location -AutoSize

# Note:  ExcludeProperty only works when Property is used.  

Get-AzureRmResource -ResourceName MLExpbpc1 -ResourceGroupName rg_ml | SELECT-OBJECT -Property * -ExcludeProperty "SubscriptionId"

Find-AzureRmResource -ResourceNameContains mlex


