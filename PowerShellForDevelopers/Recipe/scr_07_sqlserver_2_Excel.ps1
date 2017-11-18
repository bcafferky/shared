#  Check if the SQL module is loaded and if not, load it.

<#
if(-not(Get-Module -name "sqlps")) 
    {
      Import-Module "sqlps" 
    }
#>

set-location SQLSERVER:\SQL\DESKTOP-TG2VLSU\Default\Databases\Adventureworks2016\Tables

$territoryrs = Invoke-Sqlcmd -Query "SELECT [StateProvinceID],[TaxType],[TaxRate],[Name] FROM [Sales].[SalesTaxRate];" -QueryTimeout 3 

$excel = New-Object -ComObject Excel.Application

$excel.Visible = $true

$workbook = $excel.Workbooks.Add()

$sheet = $workbook.ActiveSheet

$counter = 0

foreach ($item in $territoryrs) {

 $counter++

    $sheet.cells.Item($counter,1) = $item.StateProvinceID
    $sheet.cells.Item($counter,2) = $item.TaxType
    $sheet.cells.Item($counter,3) = $item.TaxRate
    $sheet.cells.Item($counter,4) = $item.Name
}

$filename = Read-Host "Enter file name to save to"

#  Exporting Excel data is as easy as...
$sheet.SaveAs("D:\DocumentsD\Presentations\PowerShellForDevelopers\$filename", 6)
