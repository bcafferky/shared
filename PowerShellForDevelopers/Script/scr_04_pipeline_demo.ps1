
# Roll your own piping...

#  Question - Is this an advanced function?
function Out-UdfPipeline
{

  # Called only once, before the pipeline is started.
  begin
  {
   "`nWe are going to start and there is no pipeline yet."
   #  Let do something initialization like...
   [int]$mycount = 0
  }

  # Called for each row of the pipeline.
  process 
  {
   $_     # $_ is a reserved temp variable of the current pipeline item.
   $mycount++
  }

  # Called only once, after the pipeline is exhausted. 
  end
  {
   "`nThere are $mycount items."
  }

}

Clear-Host

Get-ChildItem | Out-UdfPipeline
