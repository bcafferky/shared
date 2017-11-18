
<#
if(-not(Get-Module -name "sqlps")) {
          Import-Module "sqlps"
          }
#>

$qry = "
SELECT e1.[BusinessEntityID] as EmpID
      ,e1.[FirstName] + ' ' + e1.[MiddleName] + ' ' + e1.[LastName] as Name
      ,e1.[JobTitle]
      ,VacationHours
      ,[AddressLine1]
      ,[City]
      ,[StateProvinceName]
      ,[PostalCode]
      ,[CountryRegionName]
  FROM [AdventureWorks2016].[HumanResources].[vEmployee]            e1
  join [AdventureWorks2016].[HumanResources].[vEmployeeDepartment]  e2
    on e1.BusinessEntityID = e2.BusinessEntityID
  join [AdventureWorks2016].[HumanResources].[Employee]  e3
    on e1.BusinessEntityID = e3.BusinessEntityID"

set-location SQLSERVER:\SQL\DESKTOP-TG2VLSU\Default\Databases\Adventureworks2016\
  
$list =  Invoke-Sqlcmd -Query $qry -QueryTimeout 25 | out-gridview -Title "Select records to reset"  -PassThru | Out-GridView -Title "Confirm Selection..." -PassThru

foreach ($item in $list) 
{ 
      $sql = "update [HumanResources].[Employee] set [VacationHours] = [VacationHours] + 40 where BusinessEntityID = " + $item.EmpID + ";"
      
      Invoke-Sqlcmd -Query $sql -QueryTimeout 25 
  
}

Invoke-Sqlcmd -Query $qry -QueryTimeout 25 | out-gridview -Title "Vacation Hours Updated..." 

