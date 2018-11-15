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

Get-AzureRMVM | ForEach-Object {
    IF ($_.tags.Values -eq "dev" ) {    
       "VM: " + $_.Name + "  ResourceGroupName: " +  $_.ResourceGroupName
       "     Tags: " 
       $_.tags
    }  
}

(Get-AzureRMVM).Tags.Count

# Shut down Development VMs 
Get-AzureRMVM | ForEach-Object {
    IF ($_.tags.Values -eq "dev" ) {    
       "Shutting down : " + $_.Name
       Stop-AzureRmVM -Name $_.Name -ResourceGroupName $_.ResourceGroupName -Force
    } 
}

(Get-AzureRMVM).Tags.Count

<#
      Removing Resources....
#>

Remove-AzureRmResource -ResourceName mystoragename -ResourceType Microsoft.Storage/storageAccounts -ResourceGroupName TestRG1

Remove-AzureRmResourceGroup -Name TestRG1



