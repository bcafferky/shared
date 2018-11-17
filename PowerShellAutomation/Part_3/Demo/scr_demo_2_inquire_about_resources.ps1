<#
   For demo purposes only. Not for production use.

   Inquire about Azure resources.
#>

Import-Module AzureRM -Force -Verbose

Add-AzureRmAccount | Select-Object Environment  # Log In

Login-AzureRMAccount  # An alias to log into Azure

# Logout-AzureRmAccount

Get-AzureRmSubscription | Select-Object State

Get-AzureRmContext | Select-Object Environment

#  To work you must force a Terminating error.  We use the Error Action Stop...
#     Info from https://github.com/PoshCode/PowerShellPracticeAndStyle/issues/37

try     {
            
            Get-AzureRMVM -Name 'myvm' -ResourceGroupName myrg -ErrorAction Stop
        }
catch   { 
            Write-Output   'Error - statment failed.  Information to follow: '
            $PSCmdlet.ThrowTerminatingError($_)
        }
finally { Write-Output   'Have a nice day.'}


# Note:  ExcludeProperty parameter only works when Property parameter is used.  

Get-AzureRmResource -ResourceName MLExpbpc1 -ResourceGroupName rg_ml -ErrorAction Continue | SELECT-OBJECT -Property * -ExcludeProperty "SubscriptionId"

Find-AzureRmResource -ResourceNameContains mlex | SELECT-OBJECT -Property * -ExcludeProperty "SubscriptionId"


