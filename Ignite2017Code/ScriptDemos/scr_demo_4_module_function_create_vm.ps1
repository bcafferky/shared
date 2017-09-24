<#
   Author:  Bryan Cafferky  2017-04-13

   Script that uses function New-udfCompleteVMDemo in module umd_azure
   to create an Azure VM with all required related resources.

   $env:PSModulePath

   Default = user's Documents\WindowsPowerShell\Module\

   1) script extension = psm1
   2) module must be in its own folder of module name
   3) script must be the module name

#>

Import-Module umd_azure -Force -Verbose

New-udfCompleteVMDemo -resourceprefix "PSDemo1" `
                      -publisher 'MicrosoftSQLServer' `
                      -offer 'SQL2016SP1-WS2016' `
                      -skus 'SQLDev' `
                      -Verbose
