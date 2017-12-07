#  Load a CSV file into a data frame...

# paste() adds a space between each parameter but paste0 does not...
samplepath = paste0(Sys.getenv("HOMEDRIVE"), Sys.getenv("HOMEPATH"), "\\Documents\\BI_UG\\Presentations\\R_Programming\\")

# Use forward slash as separator to avoid needed double backslash (escape seqence)
setwd(samplepath)

# Confirm we are in the right folder...
getwd()

# Load the data...
mydata <- read.csv("storesales.csv")  # read csv file 

#  Confirm this was returned as a data.frame...
class(mydata)

# Display the data...
mydata

# We can access data by using the subscript (row and column)

# Get row 2, column 3...
mydata[2,3]

# Get row 2...
mydata[2,]

# Get column 3...
#  Factors - not a string.

mydata[,3]