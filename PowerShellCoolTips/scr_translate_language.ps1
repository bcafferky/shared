<#
    Example of leveraging the built in Windows user interface language 
    localization feature.  

    We create a hashtable which is basically a language word for word dictionary.
    We map a root language like English to each language translation and PowerShell does the rest.

    Each translation dictionary is in a subfolder by language UI Code such as en-US  for English in the US

#>

Set-Location $PSScriptRoot

Clear-Host

Get-UICulture 

" "

# Import-LocalizedData -BindingVariable dayofweek                     # Machine Default - English

# Import-LocalizedData -BindingVariable dayofweek -UICulture de-DE  # German

Import-LocalizedData -BindingVariable dayofweek -UICulture es-ES  # Spanish

"Current language localization set to: "
Get-UICulture 
" "

$dayofweek

" "

$dayofweek.Sunday  
$dayofweek.Monday  
$dayofweek.Tuesday 
$dayofweek.Wednesday  
$dayofweek.Thursday 
$dayofweek.Friday  
$dayofweek.Saturday 
