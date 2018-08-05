<#
    Highlights...

    1) Providers (Drives, Functions, Variables, etc... Get-PSProvider
    2) Show-GridView
    3) Cool function stuff
        - WhatIf and Confirm
        - Common Parameters Support
    4) Parameter validation
    4) Transcription 

#>

# Set the current folder to where the script is located...
Set-Location $PSScriptRoot

function Invoke-udfSomethingCool 
{ 
<#
        .DESCRIPTION
        Function to do something cool.

        .PARAMETER statecode
        State Code.

        .EXAMPLE
        Invoke-udfSomethingCool -StateCode 'MA' -HowMany 14 -Really True

        .NOTES
        Supports PowerShell common parameters such as Verbose. 
#>

# You need CmdletBinding to get the Common Parameters...
 [CmdletBinding(SupportsShouldProcess=$True, ConfirmImpact=’High’)]
        param (
              [parameter(mandatory=$true, HelpMessage="Enter a string value.")]
              [ValidateSet(“CT”,”MA”,"NH",”RI”,"VT")]
              [string]$StateCode,
              [ValidateRange(2,15)]
              [int]$HowMany = 2,
              [parameter(mandatory=$true)]
              [ValidateScript({ Invoke-udfDateCheck $_ })]
              [DateTime]$When,
              [Switch]$CreateTranscript
  
          )

    Clear-Host
   
    Write-Verbose "You entered: `$StateCode is $StateCode and `$CreateTranscript is $CreateTranscript"

    IF ($CreateTranscript)
    {
       [string]$logfilename = "mytranscipt_" + (Get-Date).tostring("MMddyyyyHHmmss") + ".txt"
       Start-Transcript -Path $logfilename
     }
    Else
    {
        Write-Verbose "Transcript is not being recorded."
    }

    Write-Output "Doing some work..."

    "somejunk" > ($PSScriptRoot + "\outputfile.txt")

    IF (Test-Path ($PSScriptRoot + "\outputfile.txt")) {
        Remove-Item ($PSScriptRoot + "\outputfile.txt") 
       }

    # If doing a transcription, stop it now...
    IF ($CreateTranscript)
    {
       Stop-Transcript
    }
}

function Invoke-udfDateCheck ([DateTime] $p_date)
{
 <#  Be careful not to display messages in a function with a return value.
     The message is returned as well as the intended return value. 
 #>

   # Write-Host $p_date.Year  #  Don't do this!!!

   #  Note:  Comparison operators use coded values!!! 
   IF ($p_date.Year -lt 2018) {
      Return $false
   }
   ELSE {
     Return $true
   }
}


# Show-Command Invoke-udfSomethingCool

# Invoke-udfSomethingCool -Statecode "MA" -HowMany 13 -CreateTranscript -When '01/01/2018' -Verbose

# Invoke-udfSomethingCool -Statecode "MA" -HowMany 13 -When '01/01/2018' -Verbose -WhatIf


# Help Invoke-udfSomethingCool -Detailed
