<#
    Call scripts without dot sourcing and then with.

    Author: Bryan Cafferky
#>
Clear-Host

Set-Location $PSScriptRoot
"Script Root is: $PSScriptRoot"

Remove-Variable var1,var2 -ErrorAction SilentlyContinue

# Call script without dot sourcing...
# Note:  .\ is needed to run scripts in the current folder.
.\return_values.ps1      # Runs the code but retains nothing in memory!
"Back in parent script."
$var1
$var2