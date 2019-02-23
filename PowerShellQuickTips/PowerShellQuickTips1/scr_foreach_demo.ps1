Get-ChildItem | foreach { "Value is $_" }

Get-ChildItem  | foreach-object { "Value is $_" }

$myarray = Dir

foreach ($val in $myarray)
{ "Value is $val " } 

foreach-Object ($val in $myarray)
{ "Value is $val " } 