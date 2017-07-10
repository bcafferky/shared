<#  
Script Name:  scr_demo1.ps1

Purpose:  To do cool things.
#>

Clear-Host             # Clear the console screen

$myobj = "bryan"       # No type declaration = object
$myobj

[int]$myage = 33       # Strongly typed as integer

$myage = "Test"

$myage = "25"

$myage.GetType().Name

$myobj.Substring(0,3)  # Objects have methods and properties

"Hi $myobj. `$myage is a nice age." # Expands variables

'Hi $myobj. $myage is a nice age.'  # Does not expand vars


<#  Above note:
- The tilde ` is an escape that supressed variable expansion.
- Double quotes means variables are expanded.
- Automatically displays to the console.
#>

# Variables stay in memory.
# Intellisense


