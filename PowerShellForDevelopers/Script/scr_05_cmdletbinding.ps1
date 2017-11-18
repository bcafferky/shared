#  Function to call the Windows OpenFile Common Dialog...

function Get-UdfFileName
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

 Write-Verbose "You selected $OpenFileDialog."
 Write-Verbose "`$VerbosePreference overriden to: $VerbosePreference."

 Write-Debug "Debugging - `$DebugPreference overriden to: $DebugPreference."

 Write-Host "This will always write to the console."

}

# verbose and debug messages are ignored.
Get-UdfFileName 

# show verbose messages.
Get-UdfFileName -Verbose 

# show verbose messages and process the debug statements.
Get-UdfFileName -Verbose -Debug

<# Example Call...
  Get-UdfFileName -Verbose -Debug

  Verbose is great for testing and getting extr information.
  See: $VerbosePreference

  Debug is good for debugging.  See $DebugPreference

#>