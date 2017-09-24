<# 
    Create Service Principal

    - An application account used to run automation tasks.

    - Can do automated log in.
#>

Import-Module umd_azure -Force

Add-AzureRmAccount

$ApplicationDisplayName = "PSIgnite1xSP"   # change to your needs
$ResourceGroupName = 'BryanRG'          # change to your needs
 
#  Returns the Application object...
New-udfAzureServicePrincipal -ApplicationDisplayName $ApplicationDisplayName `
 -Password ('somesstuff?' + (Get-Random).ToString()) -Verbose  

<#
    Stores:
        - ApplicationID
        - TenantID
        - Password
        
#>

<#  
    Log in with the Service Principal...
#>

New-udfAzureRmVMLoginServicePrincipal -ApplicationDisplayName $ApplicationDisplayName -Verbose    


<#  
    Using the Service Prinipal in Batch - GetVM...

    ServicePrincipal for Unattended execution
#>
$scriptblk = {
  Import-Module umd_azure -Force;

  $ApplicationDisplayName = "PSIgnite1xSP"
  New-udfAzureRmVMLoginServicePrincipal -ApplicationDisplayName $ApplicationDisplayName -Verbose    
  
  Get-AzureRmVM | Format-Table 
} 

Start-Job -Name AzureJob -ScriptBlock $scriptblk

Get-Job 

Receive-Job -Name AzureJob -Keep 

Remove-Job -ID 9

