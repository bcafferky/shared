# Prerequisites for Data Science Walkthroughs
#
# Step 1: Prepare the data...
#
# Follow the instructions in the following web page...
#    https://msdn.microsoft.com/en-us/library/mt612858.aspx

# Install required R libraries for this walkthrough if they are not installed.   

#  Find packages in normal local folder...
#    C:\Users\BryanCafferky\AppData\Local\Temp\RtmpQj1q0C\downloaded_packages
# and unzip to...
#   C:\Program Files\Microsoft SQL Server\MSSQL13.SS2016\R_SERVICES\library

if (!('ggmap' %in% rownames(installed.packages()))){  
  install.packages('ggmap')  
}  
if (!('mapproj' %in% rownames(installed.packages()))){  
  install.packages('mapproj')  
}  
if (!('ROCR' %in% rownames(installed.packages()))){  
  install.packages('ROCR')  
}  
if (!('RODBC' %in% rownames(installed.packages()))){  
  install.packages('RODBC')  
}  

# Other packages called by ggplot2...
install.packages('ggplot2')
install.packages('digest')
install.packages('gtable')
install.packages('plyr')
install.packages('Rcpp')
install.packages('proto')
install.packages('reshape2')
install.packages('stringr')
install.packages('stringi')
install.packages('magrittr')
install.packages('scales')
install.packages('munsell')
install.packages('colorspace')
install.packages('RgoogleMaps')
install.packages('png')
install.packages('RJSONIO')
install.packages('geosphere')
install.packages('sp')
install.packages('jpeg')
install.packages('maps')
install.packages('rjson')
install.packages('magrittr')

