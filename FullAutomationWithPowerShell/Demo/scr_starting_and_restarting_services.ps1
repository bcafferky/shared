#
# Warning:  This code is for demostration only and should not be used
#           for production.  No warrantees are implied and this code
#           is provided as is. 
#

Add-AzureRmAccount

# Get-AzureVM does not work with Resource Manager...
Get-AzureRmVM   #  Get's list of VMs and properties...

Get-AzureRMVM | Select-Object -Property ServiceName  # None

Get-AzureRmVM -Name "demo5VM" -ResourceGroupName "Demo5RG"  # More details...

Start-AzureRmVM -Name "Demo" -ResourceGroupName "Demo"

Get-AzureRmVM  | Start-AzureRmVM #  Cannot cancel PowerShell command once started.

<#
      Removing Resources....
#>

Remove-AzureRmResource -ResourceName mystoragename -ResourceType Microsoft.Storage/storageAccounts -ResourceGroupName TestRG1

Remove-AzureRmResourceGroup -Name TestRG1



