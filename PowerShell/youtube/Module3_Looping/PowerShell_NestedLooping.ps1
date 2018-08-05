# For Loop...
# Iterate a fixed number of times based on a counter.
Clear-Host

For ($i=0; $i -lt 5; $i++) {
   # Write-Host "The current iteration is $i." 

    For ($y=0; $y -lt 4; $y++) {
        Write-Output "The outer loop variable `$i is $i and the inner loop variable `$y = $y."
    }
}