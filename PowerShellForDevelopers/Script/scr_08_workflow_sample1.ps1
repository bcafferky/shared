workflow myworkflow 
{
  sequence {
     Write-Verbose  "This "
     Write-Verbose  "Runs "
     Write-Verbose  "In Sequence."
     }

 #  Checkpoint-Workflow
 #  Suspend-Workflow
   parallel
   {     
     "first parallel statement"
     Get-Date
   }

   $collection = "this","is","a","collection"

   foreach -parallel ($item in $collection)
   {
      "Item is collection: $item"
   }

}

Clear-Host 

myworkflow -Verbose 

#myworkflow -AsJob -JobName XWF

# Get-Job 9
# Receive-Job -ID 9 -Keep

#  See the workflow XAML definition...
# (Get-Command myworkflow).XamlDefinition

# https://www.simple-talk.com/sysadmin/powershell/automating-day-to-day-powershell-admin-tasks---jobs-and-workflow/?utm_source=ssc&utm_medium=publink&utm_content=automatingpstasks

# myworkflow -AsJob | Register-ScheduledJob -ScriptBlock {myworkflow} -Name BryWF1 -RunNow 
