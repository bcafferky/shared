Add-AzureRmAccount

# Get-AzureVM does not work with Resource Manager...
Get-AzureRmVM   #  Get's list of VMs and properties...

Get-AzureRMVM | Select-Object -Property Name  # None

Get-AzureRmVM -Name "BryanSQLServer" -ResourceGroupName "BryanRG"  # More details...

Start-AzureRmVM -Name "BryanSQLServer" -ResourceGroupName "BryanRG"

Stop-AzureRmVM -Name "BryanSQLServer" -ResourceGroupName "BryanRG"

Get-AzureRmVM  | Start-AzureRmVM #  Cannot cancel PowerShell command once started.

Get-AzureRmVM  | Stop-AzureRmVM #  Always turn off your VMs when not using!

<#
      Removing Resources....
#>

Remove-AzureRmResource -ResourceName mystoragename -ResourceType Microsoft.Storage/storageAccounts -ResourceGroupName TestRG1

Remove-AzureRmResourceGroup -Name TestRG1



