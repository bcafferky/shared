<#
     Clean Up of Data Factory/IR Objects

1) Remove the Integration Runtime.
2) Remove the Data Factory.
3) Remove the SSISDB database.
4) Remove the SQL Server instance.

#>

#### Remove the IR ####

Get-AzureRmDataFactoryV2IntegrationRuntime -ResourceGroupName $ResourceGroupName `
 -DataFactoryName $DataFactoryName `
 -Name $AzureSSISName 

# Stop the IR...
Stop-AzureRmDataFactoryV2IntegrationRuntime -DataFactoryName $DataFactoryName `
    -Name $AzureSSISName -ResourceGroupName $ResourceGroupName                                             

# Remove the IR...
Remove-AzureRmDataFactoryV2IntegrationRuntime -ResourceGroupName $ResourceGroupName `
-DataFactoryName $DataFactoryName -Name $AzureSSISName -Force

# Remove the Data Factory...
Remove-AzureRmDataFactory -ResourceGroupName $ResourceGroupName -Name $DataFactoryName
