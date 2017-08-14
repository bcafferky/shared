<#  
      Dot sourcing passing parameters...
#>

Set-Location $PSScriptRoot

Clear-Host

# Call script by dot sourcing...
# Note:  First . is to do the dot sourcing (load and keep) 
# and the second for local folder.
. .\scr_take_some_parameters.ps1 "Tom" 33 "C:\"

# Breaking the validation rules...
. .\scr_take_some_parameters.ps1 "Bryan" 99 "C:\" -Verbose

# We have advanced function (common parameter support) too!
. .\scr_take_some_parameters.ps1 "Tom" 35 "C:\" -Verbose

