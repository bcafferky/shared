<#
    Call scripts without dot sourcing and then with.

    Author: Bryan Cafferky

    Parent Script!!!
#>

Set-Location $PSScriptRoot

# Call script by dot sourcing...
# Note:  First . is to do the dot sourcing (load and keep) and the second for local folder.
Clear-Host
$var1 = 'thisthing'

. .\return_values.ps1
$var1
$var2

# Calling a script and getting a single return value...
Clear-Host
$retval = . .\return_values.ps1
$retval

# Calling a script and getting an object back...
$retval2 = . .\return_values2.ps1
$retval2 
