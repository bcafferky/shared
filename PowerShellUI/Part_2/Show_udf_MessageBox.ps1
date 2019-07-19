<#
https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-messagebox
#>

function Show-udfMessageBox
{ 
   [CmdletBinding()]
      param (
      [Parameter(Mandatory=$true,ValueFromPipeline=$false)] 
      [string] $message,
      [Parameter(Mandatory=$true,ValueFromPipeline=$false)]
      [string] $title,
      [Parameter(Mandatory=$true,ValueFromPipeline=$false)]
      [ValidateSet(“ABORTRETRYIGNORE”,”CANCELTRYCONTINUE”,”HELP”, "OK", "OKCANCEL", "RETRYCANCEL", "YESNO", "YESNOCANCEL")] 
      [string] $type 
      )

        $msgboxtype = @{ 
           ABORTRETRYIGNORE  = 0x00000002L; # The message box contains: Abort, Retry, and Ignore.
           CANCELTRYCONTINUE = 0x00000006L; # The message box contains: Cancel, Try Again, Continue. Use this message box type instead of MB_ABORTRETRYIGNORE.
           HELP              = 0x00004000L; # Adds a Help button to the message box. 
           OK                = 0x00000000L; # The message box contains one push button: OK. This is the default.
           OKCANCEL          = 0x00000001L; # The message box contains two push buttons: OK and Cancel.
           RETRYCANCEL       = 0x00000005L; # The message box contains two push buttons: Retry and Cancel.
           YESNO             = 0x00000004L; # The message box contains two push buttons: Yes and No.
           YESNOCANCEL       = 0x00000003L; # The message box contains two push buttons: Yes, No, and Cancel.
         }
        
        Write-Output $type

        RETURN [System.Windows.Forms.MessageBox]::Show($message , $title, 'YESNO')
    
}

<#
    Show-udfMessageBox -message 'Hello to you' -title 'Greetings' -type 'YESNOCANCEL'
#>