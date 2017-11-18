<#  
Script Name:  scr_basic.ps1

Purpose:  To do cool things.
#>

Clear-Host             # Clear the console screen

$myobj = "bryan"       # No type declaration = object

[int]$myage = 33       # Strongly typed as integer

$myobj.Substring(1,3)  # Objects have methods and properties

"Hi $myobj. `$myage is a nice age."

"Hi $myobj. $myage is a nice age."

<#  Above note:
- The tilde ` is an escape that supressed variable expansion.
- Double quotes means variables are expanded.
- Automatically displays to the console.
#>

# Variables stay in memory.
# Intellisense

