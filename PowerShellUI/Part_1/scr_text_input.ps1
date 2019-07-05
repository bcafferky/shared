<#
    Built-In approaches to a user interface
#>

<#  
     Writing different types of messages.
#>

Clear-Host

$myname = 'Bryan'

Write-Output "It's a nice day $myname."

Write-Warning 'It may rain later $myname.' 

# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-error?view=powershell-6
Write-Error -Message 'User not authorized' -ErrorId 99 -Category AuthenticationError

# Progress bar
for ($i = 0; $i -le 100; $i+=20 )
{
    Write-Progress -Activity "Search in Progress" -Status "$i% Complete:" -PercentComplete $i;
    Start-Sleep 1
}

Get-ChildItem | 
  Format-Table -AutoSize -Property Name, Length -GroupBy Mode 

# Gridview is cool!
Get-ChildItem | Out-GridView -Title "File List"


<# 
Getting user input..
#>

# Simple text based input...
$uservalue = Read-Host 'Enter your name' 
Write-Output $uservalue

[int]$uservalue = Read-Host 'Enter your age' 
Write-Output $uservalue



# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/convertto-securestring?view=powershell-6
$uservalue = Read-Host 'Enter your password' -AsSecureString 
Write-Output $uservalue

# Secure input...
$credin = Get-Credential 
Write-Output $credin