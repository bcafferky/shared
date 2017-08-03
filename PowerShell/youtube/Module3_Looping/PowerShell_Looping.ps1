<#    
      Examples of PowerShell Loops...

      by Bryan Cafferky
#>

# For Loop...
# Iterate a fixed number of times based on a counter.
For ($i=0; $i -lt 5; $i++) {
   Write-Host "The current iteration is $i." 
}

# ForEach Loop...
# Iterates over a collection extracting each element in sequence.
$array = "Bryan", "Joe", "Steve", "Sue", "Mary"
Foreach ($item in $array)
{
   Write-Host "The current name is: $item."
}

# ForEach-Object...
Get-ChildItem  | ForEach-Object { Write-Host ("File Name is: " + $_.FullName) }

# While Loop...
$x = 0
While ($x -lt 5) {
   Write-Host $x
   $X++
}

# Do While Loop...
$val = 0
Do { 
  $val++ 
  Write-Host $val
} While($val -ne 10) 

# Do Util Loop...
$val = 0
Do { 
  $val++ 
  Write-Host $val
} Until($val -eq 5)


# Impicit Loop, the pipe...

Get-Process | Select-Object -Property "Id", "ProcessName", "CPU(s)"

# Do Until Loop...
$val = 0
Do { 
  $val++ 
  Write-Host $val

  If ($val -eq 8) 
  {
    "Interupting Loop"
    Break
  }
} While($val -ne 10) 


# Real World Example...

# While Loop...
$RandomNumber = Get-Random -minimum 1 -maximum 100
$KeepTrying = "Y"
while($KeepTrying.ToUpper() -eq "Y") {
       $Guess = Read-Host "Enter your guess"
       If ($Guess -eq $RandomNumber) 
       {
        "You Win!"
       }
       Else
       {
         "Sorry Wrong Number." 
         $KeepTrying = Read-Host "Want to try again?" 
       }
}
