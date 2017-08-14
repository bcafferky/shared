function Invoke-UdfSpeech
{ 
 [CmdletBinding()]
        param (
              [string]$speakit ='A default thing to say.'
          )

   Write-Verbose $speakit
  
   $speaker = New-Object -com SAPI.SpVoice

   $speaker.Speak($speakit, 1 ) | out-null
  
}

# Example of calling the function...
Invoke-UdfSpeech "PowerShell is awesome!" -Verbose  # Verbose supported due to CmdletBinding
