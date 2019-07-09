function Out-udfHTML ([string] $p_headingbackcolor, [switch] $AlternateRows)
{
<#
   For demo purposes only.
#>

  If ($AlternateRows) {$tr_alt = "TR:Nth-Child(Even) {Background-Color: #dddddd;}"}

   $format = @"
   <style>
   TABLE {border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}
   TH {border-width: 1px;padding: 3px;border-style: solid;border-color: black;background-color: $p_headingbackcolor;}
   $tr_alt
   TD {border-width: 1px;padding: 3px;border-style: solid;border-color: black;}
   </style>
"@

   RETURN $format

}

# Remove-Module "sqlps"

<#
Get-ChildItem | Select-Object -Property name, LastWriteTime  | ConvertTo-HTML -Head (Out-udfHTML "lightblue" -AlternateRows) -Pre "<h1>File List</h1>" -Post ("<h1>As of " + (Get-Date) + "</h1>") | Out-File MyReport.HTML
Invoke-Item  MyReport.HTML 
#>
