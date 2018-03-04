<#
      Module:   umd_azureautomationdemo 

      Purpose:  Functions for Azure automation demo.

      Author:   Bryan Cafferky   2017-04-10

      Warning:  This code is for demostration only and should not be used
                for production.  No warrantees are implied and this code
                is provided as is. 

#>

function Get-AzureResourceTags 
{ 
<#
        .DESCRIPTION
        Displays the list of tags on a resource.

        .PARAMETER resourcename
        Name of resource.

        .PARAMETER resourcegroup
        Name of resource group.

        .EXAMPLE
        Get-AzureResourceTags -ResourceName 'myresource' -ResourceGroupName 'myrg'

        .NOTES
        Supports PowerShell common parameters such as Verbose. 
#>

 [CmdletBinding()]
       param (
             [string]$resourcename,
             [string]$resourcegroup
             )

   # Get the tags...
   (Get-AzureRmResource -ResourceName $storagename -ResourceGroupName $resourcegroup).Tags

}