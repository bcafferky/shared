# Call script by dot sourcing...
# Note:  First . is to do the dot sourcing (load and keep) and the second for local folder.
Clear-Host
$var1 = 'thisthing'

. .\return_values.ps1
$var1
$var2