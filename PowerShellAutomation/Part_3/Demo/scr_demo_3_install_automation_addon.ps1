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

# Check if you have the right PowerShellGet version.
Get-Module PowerShellGet -list | Select-Object Name,Version,Path

# Install the PowerShell Azure Module...
# Must run this with elevated privileges.

# If your don't have PowerShellGet, you can get it with the statement below...
#  Install-Module PowerShellGet -Force

Install-Module AzureAutomationAuthoringToolkit -Scope CurrentUser 

Import-Module AzureAutomationAuthoringToolkit 
