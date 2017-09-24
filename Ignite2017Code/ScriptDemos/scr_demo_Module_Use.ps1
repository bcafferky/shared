#  Import our custom PowerShell Module...
Import-Module umd_azure -Force

$Myconfig = Get-udfConfig  # Returns the Configuration Object

$Myconfig.emailaccount

Invoke-udfAzureRMLogin -azureaccountname ($Myconfig.azureaccount) -Verbose
