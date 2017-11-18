function Out-udfHTML ([string] $p_headingbackcolor, [switch] $AlternateRows)
{

If ($AlternateRows) {$tr_alt = "TR:Nth-Child(Even) {Background-Color: #dddddd;}"}

# Here string example...
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

set-location "D:\DocumentsD\Presentations\PowerShellForDevelopers\"

$instates = Import-CSV "D:\DocumentsD\Presentations\PowerShellForDevelopers\Data\state_table.csv"

# Megapipe example...
$instates | Select-Object -Property name, abbreviation, country, census_region_name  | 
Where-Object -Property census_region_name -eq "Northeast" | 
ConvertTo-HTML -Head (Out-udfHTML "lightblue" -AlternateRows) -Pre "<h1>State List</h1>" -Post ("<h1>As of " + (Get-Date) + "</h1>") | 
Out-File MyReport.HTML
Invoke-Item  MyReport.HTML 
