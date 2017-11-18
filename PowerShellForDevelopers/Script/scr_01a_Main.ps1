# Show how scripts are called.

Clear-Host

Set-Location "D:\DocumentsD\Presentations\PowerShellForDevelopers\"

. .\script1.ps1   # Function stay in memory due to initial dot

.\script2.ps1   # Function does NOT stay in memory

Write-Host "Done"

"Try function stayinmem"
stayinmem "Test"

"Try function runonce"
runonce "Test"

# Use Dir function: to see list of functions in memory.

