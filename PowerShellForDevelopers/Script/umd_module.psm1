<#  Things to note:
       - Function/cmdlet naming conventions.
       - Comment tags.
       - CmdletBinding attribute.
       - Function definition and use.
       - Parameter default values.

       $env:PSModulePath

       Best place to put modules...
       \Documents\WindowsPowerShell\Modules

       Each module must be in a folder of the same name as the module.
       Module scripts have .psm1 extensions.
#>

function Out-UdfSpeech  
{ 
 <#
     .SYNOPSIS 
     Speaks the string passed to it.

     .DESCRIPTION
     This function uses the SAPI interface to speak.

     .PARAMETER $speakit
     The string to be spoken.

     .INPUTS
     This function does not support piping.

     .OUTPUTS
     Describe what this function returns.

     .EXAMPLE
     Out-UdfSpeach 'Something to be said.'

     .LINK
     www.SAPIHelp.com.

#>
[CmdletBinding()]
        param (
              [string]$speakit = 'What do you want me to say?'
          )
  #  Fun using SAPI - the text to speech thing....    

  $speaker = new-object -com SAPI.SpVoice

  $speaker.Speak($speakit, 1) | out-null

}

# Get-Help Out-UdfSpeech

<#  Example call...

Get-Help Out-UdfSpeech
Out-UdfSpeech 
Out-UdfSpeech 'It is a beautiful day!'

#>  

<# Things to note...
   - Leveraging Windows to support user interaction.
   - Using cmdlets in assigning parameter default values.
   - Using environment variables.
   - CmdletBinding and Write-Verbose.
#>
Function Get-UdfFileName
{  
[CmdletBinding()]
        param (
              [string]$InitialDirectory = (Join-Path -Path $env:HOMEDRIVE -ChildPath $env:HOMEPATH) 
          )

 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "All files (*.*)| *.*"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename

 Write-Verbose "You selected $OpenFileDialog ."
}

<# Example Call...
  Get-UdfFileName -Verbose
#>


<# Things to note...
   - Combining functions.
   - Using PS variables.
   - Nesting cmdlets withing parentheses.
   - Using a module.
   - $PSScriptRoot
   - Creating a script module.
#>
Function Out-UdfSpeakFileContents
{  
[CmdletBinding()]
        param (
              [string]$InitialDirectory = ($PSScriptRoot) 
          )

       [string]$speech = Get-Content (Get-UdfFileName -InitialDirectory $InitialDirectory)
       Out-UdfSpeech $speech

}

<# Example Call...
  Out-UdfSpeakFileContents
#>

function Invoke-UdfSQLStatement
{ 
 [CmdletBinding()]
        param (
              [string]$Server,
              [string]$Database,
              [string]$SQL,
              [switch]$IsSelect
          )

  Write-Verbose "open connecton"

  $conn = new-object System.Data.SqlClient.SqlConnection("Data Source=$Server;Integrated Security=SSPI;Initial Catalog=$Database");

  $conn.Open()

  $command = new-object system.data.sqlclient.Sqlcommand($SQL,$conn)

  if ($IsSelect) 
  { 
     
     $adapter = New-Object System.Data.sqlclient.SqlDataAdapter $command
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

<# Example call 
Invoke-UdfSQLStatement -Server '(local)' -Database 'Development' -SQL 'select top 10 * from dbo.orders' -IsSelect 
#>

