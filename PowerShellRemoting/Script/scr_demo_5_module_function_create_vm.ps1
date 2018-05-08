<#
   Author:  Bryan Cafferky  2017-04-13

   Script that uses function New-udfCompleteVMDemo in module umd_azure
   to create an Azure VM with all required related resources.

   Code is for demonstration purposes only and should only be used for demonstration
   purposes, not on production systems. 

   Add Network firewall rule 5986 inbound to allow.


#>

# $env:PSModulePath

Import-Module umd_azure -Force -Verbose

# New-udfCompleteVMDemo -resourceprefix "bcafferkypref1" -Verbose

Import-Module AzureRM

New-udfCompleteVMDemo -resourceprefix "bpc4vm" -publisher 'MicrosoftSQLServer' -offer 'SQL2016SP1-WS2016' -skus 'SQLDev'

Get-AzureRMVM

