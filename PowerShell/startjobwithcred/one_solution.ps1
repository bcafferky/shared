<#
   Code to run a job with credentials.

   Bryan Cafferky  2017-10-15

#>

$init = { Import-Module umd_genericquery }

$job = { GenericSqlQuery }

$creds = Get-Credential 

Start-Job -InitializationScript $init `
          -ScriptBlock $job -Credential $creds | Wait-Job | Receive-Job
          