# Create an array named $myArray that contains the ten numeric (int) values:1,2,3,4,5,6,7,8,9,10; 

$myArray = 1,2,3,4,5,6,7,8,9,10; 

[int] $sum = 0; 

# Looping...
ForEach ($val in $myArray) 
{
   Write-Host "Index with value: $val"; 
   $sum = $sum + $val; 
} 

Write-Host "The sum is: $sum";

# Doing comparisons...
IF ($sum -gt 40)
{
  Write-Host "Wow!  That's a big number"
}
ELSE
{
    Write-Host "Ok.  Not such a big number."
}

# Doing comparisons...
IF ($sum -gt 40 -and $myArray.Count > 6 )
{
  Write-Host "Greater than 40 and Count more than 6"
}
ELSE
{
    Write-Host "Condition not met"
}


<#  Point of confusion:

    Foreach alias for ForEach-Object
    vs.
    ForEach statement which does not accept pipeline
#>

$myArray | ForEach-Object { "Value is $_ " }
  