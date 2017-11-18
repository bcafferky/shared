<#
   Author:  Bryan Cafferky 
   
   Purpose:  Demostrate piping.
#>

Clear-Host

Get-ChildItem | Out-GridView

$mylist = Get-ChildItem | Sort-Object -Property Name -Descending


foreach ($item in $mylist)
{
    "The file name is " + $item.Name
}

# Get files with the letter A in the name.
$mylist | Select-Object -Property LastWriteTime, Name | Where-Object -Property Name -Like "*a*"
