<#
        Script with parameters.  Because there are input
        parameters, it is not so good for straight forward
        execution anymore.

        Param attribute adds support for common parameters.
#>

Param
    (
        [parameter(Mandatory=$true)]
        [ValidateSet(“Tom”,”Dick”,”Jane”)]
        [String]
        $Name
    ,
        [ValidateRange(21,65)]
        [Int]
        $Age
    ,
        [ValidateScript({Test-Path $_ })]
        [string]
        $Path
    )

Write-Output "Wow $Name.  You are $age years old."
Write-Output "File Path: $Path Verified"
Write-Verbose "Just a verbose message."