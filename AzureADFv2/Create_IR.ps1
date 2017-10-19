<#

  https://docs.microsoft.com/en-us/azure/data-factory/

  https://docs.microsoft.com/en-us/azure/data-factory/create-azure-ssis-integration-runtime

  Blog on ADFv2...

  https://www.purplefrogsystems.com/paul/2017/09/whats-new-in-azure-data-factory-version-2-adfv2/

  Other Notes:

  - Create a SQL Server instance to hold the SSISDB.
  - Do NOT create an SSISDB database.  The PowerShell cmdlet to create the IR will do that.

  - You must create a fire wall rule for your client IP address on the Azure SQL Server.
  - In SSMS, you must connect to the SSDB database specifically using the OPTIONS settings.

#>

#  Install the modules - Requires elevated priviledges - First time only!!!
Install-Module AzureRM -Force                  # AzureRM module
Install-Module AzureRM.DataFactoryV2           # Preview module

# Import the module...
Import-Module AzureRM -Force

# Remove-Module AzureRM -Force

Import-Module AzureRM.DataFactoryV2 -Force -Verbose

# List the cmdlets...
Clear-Host
Get-Command -Module AzureRM.DataFactoryV2 

# Log into your Azure account...
Add-AzureRmAccount 

$resourceprefix = "adfv2c"

#  Set variables...
$SubscriptionName = "Visual Studio Enterprise"
$ResourceGroupName = $resourceprefix + "RG"
# Data factory name. Must be globally unique
$DataFactoryName = $resourceprefix + "demodf2" 
# In public preview, only EastUS amd EastUS2 are supported.
$DataFactoryLocation = "EastUS" 

# Azure-SSIS integration runtime information. This is a Data Factory compute resource for running SSIS packages
$AzureSSISName = $resourceprefix + "SSISIR2"
$AzureSSISDescription = "Demo SSIS IR"
# In public preview, only EastUS and NorthEurope are supported.
$AzureSSISLocation = "EastUS" 
 # In public preview, only Standard_A4_v2, Standard_A8_v2, Standard_D1_v2, Standard_D2_v2, Standard_D3_v2, Standard_D4_v2 are supported
$AzureSSISNodeSize = "Standard_A4_v2"
# In public preview, only 1-10 nodes are supported.
$AzureSSISNodeNumber = 1
# In public preview, only 1-8 parallel executions per node are supported.
$AzureSSISMaxParallelExecutionsPerNode = 1

# SSISDB info
$SSISSQLServer = $resourceprefix + "sqlserver"
$SSISDBServerEndpoint = $SSISSQLServer + ".database.windows.net"
# $SSISDBServerAdminUserName = "bxx"
# $SSISDBServerAdminPassword = "xxxx"
# Pricing tier of you Azure SQL server. For example S0, S3 etc. 
$SSISDBPricingTier = "s0" 

# Create a Resource Group...
$tags = @{ desc = "ADFv2 Demo"; type = "Test"}
New-AzureRMResourceGroup -Name $ResourceGroupName -Location "EastUS" -Tag $tags
Get-AzureRMResourceGroup -Name $ResourceGroupName 
AzureRMResourceGroup -Name $ResourceGroupName       # Get is the default verb!

$sscredential = Get-Credential

New-AzureRmSqlServer -ServerName $SSISSQLServer `
                     -SqlAdministratorCredentials $sscredential `
                     -ResourceGroupName $ResourceGroupName -Location $AzureSSISLocation 

Get-AzureRmSqlServer -ServerName $SSISSQLServer -ResourceGroupName $ResourceGroupName

                     
#  Enable the SQL Server firewall rule...
#     https://docs.microsoft.com/en-us/azure/sql-database/scripts/sql-database-create-and-configure-database-powershell

$clientip = '73.119.171.40'

$serverfirewallrule = New-AzureRmSqlServerFirewallRule -ResourceGroupName $ResourceGroupName `
    -ServerName $SSISSQLServer `
    -FirewallRuleName "AllowedClientIPs" -StartIpAddress $clientip -EndIpAddress $clientip

# Enable Azure Services access to the SQL Server... 
New-AzureRmSqlServerFirewallRule -ResourceGroupName $ResourceGroupName `
                                 -ServerName $SSISSQLServer `
                                 -AllowAllAzureIPs                      

Get-AzureRmSqlServer -ResourceGroupName $ResourceGroupName

# Create fire wall rule to allow access to IP Address...

<# 
     Test Connection to SQL Server or use SSMS
#>

$SSISDBServerAdminUserName = "userid"
$SSISDBServerAdminPassword = "password"

$SSISDBConnectionString = "Data Source=" + $SSISDBServerEndpoint + ";User ID="+ $SSISDBServerAdminUserName +";Password="+ $SSISDBServerAdminPassword
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $SSISDBConnectionString;
Try
{
    $sqlConnection.Open();
}
Catch [System.Data.SqlClient.SqlException]
{
    Write-Warning "Cannot connect to your Azure SQL DB logical server/Azure SQL MI server, exception: $_"  ;
    Write-Warning "Please make sure the server you specified has already been created. Do you want to proceed? [Y/N]"
    $yn = Read-Host
    if(!($yn -ieq "Y"))
    {
        Return;
    } 
}

# Select the subscription...

Select-AzureRmSubscription -SubscriptionName $SubscriptionName

<# 
      Create a new new data factory...
#>

Set-AzureRmDataFactoryV2 -ResourceGroupName $ResourceGroupName `
                         -Location $DataFactoryLocation `
                         -Name $DataFactoryName 

<#
      Create the SSIS IR...
#>

Set-AzureRmDataFactoryV2IntegrationRuntime  -ResourceGroupName $ResourceGroupName `
                                            -DataFactoryName $DataFactoryName `
                                            -Name $AzureSSISName `
                                            -Type Managed `
                                            -CatalogServerEndpoint $SSISDBServerEndpoint `
                                            -CatalogAdminCredential $sscredential `
                                            -CatalogPricingTier $SSISDBPricingTier `
                                            -Description $AzureSSISDescription `
                                            -Location $AzureSSISLocation `
                                            -NodeSize $AzureSSISNodeSize `
                                            -NodeCount $AzureSSISNodeNumber `
                                            -MaxParallelExecutionsPerNode $AzureSSISMaxParallelExecutionsPerNode 



<#  
    Set SQL Server fire wall rule to allow the ADFv2 IR to access it...
#>

Get-AzureRmDataFactoryV2IntegrationRuntime -Name $AzureSSISName -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName

Get-AzureRmDataFactoryV2 -Name $DataFactoryName -ResourceGroupName $ResourceGroupName

#  Start the SSIS IR...
write-host("##### Starting your Azure-SSIS integration runtime. This command takes 20 to 30 minutes to complete. #####")
Start-AzureRmDataFactoryV2IntegrationRuntime -ResourceGroupName $ResourceGroupName `
                                             -DataFactoryName $DataFactoryName `
                                             -Name $AzureSSISName `
                                             -Force

write-host("##### Completed #####")
write-host("If any cmdlet is unsuccessful, please consider using -Debug option for diagnostics.")    

<#
Stop-AzureRmDataFactoryV2IntegrationRuntime -ResourceGroupName $ResourceGroupName `
                                             -DataFactoryName $DataFactoryName `
                                             -Name $AzureSSISName `
                                             -Force
#>


<#
      Remove the resources...
#>

Get-AzureRmDataFactoryV2IntegrationRuntime -ResourceGroupName $ResourceGroupName `
 -DataFactoryName $DataFactoryName `
 -Name $AzureSSISName 
                                             
Stop-AzureRmDataFactoryV2IntegrationRuntime -DataFactoryName $DataFactoryName -Name $AzureSSISName -ResourceGroupName $ResourceGroupName 

Remove-AzureRmDataFactoryV2IntegrationRuntime -ResourceGroupName $ResourceGroupName `
-DataFactoryName $DataFactoryName -Name $AzureSSISName -Force

# Remove the data factory...
Remove-AzureRmDataFactoryV2 -ResourceGroupName $ResourceGroupName `
-DataFactoryName $DataFactoryName  -Force
