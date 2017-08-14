<#  
      Dot sourcing to load function definitions into memory.
#>

Set-Location $PSScriptRoot

# Call script by dot sourcing...
Clear-Host
. .\scr_define_functions.ps1  

Out-udfUserMessage "Robin" 44

Out-udfUserMessage "Karen" 30 -Debug
Out-udfUserMessage "Karen" 30 -Verbose

<#  The SupportsShouldProcess parameter in the function 
    adds WhatIf and Confirm common parameter support
    so we can verifiy a potentially risky action before
    doing it. 
#>

# Example of WhatIf...
Stop-Process -Name notepad -WhatIf

Out-udfCarefulMessage -WhatIf

# Example of Confirm...
Stop-Process -Name notepad -Confirm

Out-udfCarefulMessage -Confirm 

Out-udfCarefulMessage 
