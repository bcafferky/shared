<#

Author:  Bryan Cafferky 2013-12-17 

Purpose:  Fun with SQL Server.  It's not what you expect.

#>

#  Import the SQL Server module
# remove-module “sqlps”
Import-Module “sqlps” -DisableNameChecking -verbose

Invoke-Sqlcmd -Query "SELECT @@VERSION;" -QueryTimeout 3 -ServerInstance "localhost"

Install-Module sqlserver

# Set where you are in SQL Server...
set-location SQLSERVER:\SQL\BryanCafferkyPC\DEFAULT\Databases\Adventureworks\Tables

Dir
Get-ChildItem | Out-Gridview
# set-location SQLSERVER:\SQL\BryanCafferkyPC\local\Databases\Adventureworks\Tables


# Generate the table create statements...
 foreach ($Item in Get-ChildItem) {$Item.Script() | Out-File -Filepath C:\Users\BryanCafferky\Documents\BI_UG\PowerShell\Examples\Data\Tables.sql -append }

# List tables in the Sales schema...
Get-ChildItem | Where-Object {$_.Schema -eq "Sales"}

# get-help sqlserver > C:\Users\BryanCafferky\Documents\BI_UG\PowerShell\Examples\Data\ps_sqlserver.txt

#  Query the database...
Invoke-Sqlcmd -Query "SELECT top 100 * from person.person;" -QueryTimeout 3 | Out-GridView 

Invoke-Sqlcmd -Query "SELECT top 100 businessentityid, firstname, lastname from person.person;" -QueryTimeout 3 | Out-GridView

# Direct query results to CSV file...
Invoke-Sqlcmd -Query "SELECT top 100 businessentityid, firstname, lastname  from person.person;" -QueryTimeout 3 | Export-CSV "C:\Users\BryanCafferky\Documents\BI_UG\PowerShell\Examples\Data\PersonData.txt" -notype



#  This script creates a Views.sql file that contains the CREATE VIEW statements that are required to recreate all of the views that are defined in 
#  AdventureWorks.
        
Remove-Item C:\Users\BryanCafferky\Documents\BI_UG\PowerShell\Examples\Data\Views.sql
set-location SQLSERVER:\SQL\BryanCafferkyPC\DEFAULT\Databases\Adventureworks\Views

 foreach ($Item in Get-ChildItem) {$Item.Script() | Out-File -Filepath C:\Users\BryanCafferky\Documents\BI_UG\PowerShell\Examples\Data\Views.sql -append }
        
dir 

#set-location SQLSERVER:\SQL\BryanCafferkyPC\DEFAULT\Databases\Adventureworks\Tables
#foreach ($Item in Get-ChildItem) {$Item.datarow()  } | Out-File -Filepath C:\Users\BryanCafferky\Documents\BI_UG\PowerShell\Examples\Data\ViewsData.txt -append }

     
