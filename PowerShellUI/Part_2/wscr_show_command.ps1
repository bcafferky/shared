<#
   Link: https://powershell.org/forums/topic/the-inputbox-function/
#>

function New-udfInputBox
{
    param
    (
        [Parameter(Mandatory)]
        [string]$FirstName,
        
        [Parameter(Mandatory)]
        [string]$LastName,

        [Parameter(Mandatory=$true)]
       # [ValidateSet(“Sr”,”Jr”,"III")]
        [string]$Title
    )

    $FirstName, $LastName, $Password
        
}

$inputvars = Show-Command -Name New-udfInputBox 
$inputvars