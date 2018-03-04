<#
           Determining the image properties
#> 

# List publishers...
Get-AzureRmVMImagePublisher -Location 'eastus' | 
Where-Object {$_.PublisherName -Like "Micro*"}

# List Offers for the publisher...
Get-AzureRmVMImageOffer -Location 'eastus' -PublisherName 'MicrosoftSQLServer'

# List sku for offer...
Get-AzureRmVMImageSku -Location 'eastus' -PublisherName 'MicrosoftSQLServer' `
                      -Offer 'SQL2016SP1-WS2016'

# List Images...
Get-AzureRmVMImage -Location 'eastus' -PublisherName 'MicrosoftSQLServer' `
                   -Offer 'SQL2016SP1-WS2016' -Skus 'SQLDEV' 
                
Get-AzureRmVMImage -Location 'eastus' -PublisherName "MicrosoftWindowsServer" `
                   -Offer "WindowsServer" -Skus "2012-R2-Datacenter" #pick




 