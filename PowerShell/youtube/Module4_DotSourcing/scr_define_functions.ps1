<#
        Function with parameters.  Because there are input
        parameters, it is not so good for straight forward
        execution anymore.

        Param attribute adds support for common parameters.
#>

function Out-udfUserMessage {
[CmdletBinding()]
Param
    (
        [String]$Name,
        [Int]$Age
    )

     Write-Output "Hi $Name.  You are $age years old."
     Write-Debug "Here is a debug message."
     Write-Verbose "Here is a verbose message."

}

function Out-udfCarefulMessage {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
Param ()

    If ($pscmdlet.ShouldProcess("Deleting Testfile.txt")) 
    {
     Remove-Item testfile.txt
    }

}

