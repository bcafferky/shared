<#
   Author:  Bryan Cafferky  2017-04-13

   Script that uses function New-udfCompleteVMDemo in module umd_azure
   to create an Azure VM with all required related resources.

   Code is for demonstration purposes only and should only be used for demo
   puposes, not on production systems. 

#>

Import-Module umd_azure -Force -Verbose

# New-udfCompleteVMDemo -resourceprefix "bcafferkypref1" -Verbose

New-udfCompleteVMDemo -resourceprefix "bcaffpref2" -publisher 'MicrosoftSQLServer' -offer 'SQL2016SP1-WS2016' -skus 'SQLDev'
