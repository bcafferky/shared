<#

   Problem:  

   - Local PowerShell ISE does not tightly integrate with Azure.
   - With local ISE, I have to store credentials on my machine.
   - Running PowerShell scripts (runbooks) on Azure is more
     secure and has nice features like assets (shared credentials,
     modules, variables) and other runbooks.

   - However, developing scripts in the portal is awkwward.

   **** Answer - The PowerShell ISE Azure Add On ***

   https://azure.microsoft.com/en-us/blog/announcing-azure-automation-powershell-ise-add-on/

#>

Install-Module AzureAutomationAuthoringToolkit -Scope CurrentUser 

Import-Module AzureAutomationAuthoringToolkit 
