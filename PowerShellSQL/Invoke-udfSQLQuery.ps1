#  Function to provide simple way to run a query to a SQL Server database...
function Invoke-udfSQLQuery
{ 

 #  Caution:  Code just meant for demonstration.  Verify code before using.
 
 #  Function to provide simple way to run a query to a SQL Server database...

 # See https://mcpmag.com/articles/2018/12/10/test-sql-connection-with-powershell.aspx
 # for how the Credential password is obtained for the connection.

 [CmdletBinding()]
        param (
              [string] $SQLServer       ,   # SQL Server
              [string] $SQLDatabase     ,   # SQL Server Database.
              [string] $SQLQuery        ,   # SQL Query
              [switch] $IsSelect        ,   # True if the is a select query, returns data.
              [switch] $UseCredential   
          )

  Clear-Host

  if ($UseCredential) {
     $cred = Get-Credential 
     $user = $cred.UserName
     $pw = $cred.GetNetworkCredential().Password
     $conn = new-object System.Data.SqlClient.SqlConnection("Data Source=$sqlserver;Initial Catalog=$sqldatabase;Uid=$user;Pwd=$pw;")      
  }
  else {
     $conn = new-object System.Data.SqlClient.SqlConnection("Data Source=$sqlserver;Integrated Security=SSPI;Initial Catalog=$sqldatabase")
  }
  
  $command = new-object system.data.sqlclient.sqlcommand($sqlquery,$conn)

  $conn.Open()

  if ($IsSelect) { 
      $adapter = New-Object System.Data.sqlclient.sqlDataAdapter $command
      $dataset = New-Object System.Data.DataSet
      $adapter.Fill($dataset) | Out-Null
      $conn.Close()
      RETURN $dataset.tables[0] 
  }
  Else
  {
     $command.ExecuteNonQuery()
     $conn.Close()
  }

}

<#

# Using integrated security...

Invoke-UdfSQLQuery -sqlserver '(local)' -IsSelect `
  -sqldatabase 'AdventureWorks2016' `
  -sqlquery 'select top 10 * from person.person'  | Out-GridView

# Using credentials...

Invoke-UdfSQLQuery -sqlserver '(local)' -IsSelect `
  -sqldatabase 'AdventureWorks2016' `
  -sqlquery 'select top 10 * from person.person'   `
  -UseCredential | Out-GridView 

Invoke-UdfSQLQuery -sqlserver '(local)' -IsSelect `
  -sqldatabase 'AdventureWorks2016' `
  -sqlquery 'select top 10 * from person.person'   | 
  ConvertTo-HTML -Head (Out-udfHTML "lightblue" -AlternateRows) -Pre "<h1>Person List</h1>" -Post ("<h1>As of " + (Get-Date) + "</h1>") | Out-File MyReport.HTML
Invoke-Item  MyReport.HTML 

Invoke-UdfSQLQuery -sqlserver '(local)' `
  -sqldatabase 'AdventureWorks2016' `
  -sqlquery 'delete from person.person where BusinessEntityID = 1'  
 

#>