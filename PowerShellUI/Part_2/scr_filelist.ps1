<#
Author: Bryan Cafferky for Demo only.  Not intended for Production use.

Purpose:  Display a file's content. 

#>

# start the filename variable off with a value so the loop will execute...
$fileselected = "x"

While ($fileselected) {

    $fileselected = Get-ChildItem '*.txt' | Out-Gridview -Title "Select a File to Delete..." -OutputMode Single

    # If will return False if the user clicks the Cancel button...
    If ($fileselected) {
       Get-Content -ReadCount 10 $fileselected | Write-Output
       }
    
}



