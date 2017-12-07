# data.frames....

# Creating a data.frame explicitly...
state_code = c("CT", "ME", "MA", "NH", "RI", "VT")
population <- c(3576452, 1331479, 6811779, 1334795, 1056426, 624594 )
houseseats <- c(5, 2, 9, 2, 2, 1)

# Note: stringasfactors = FALSE so we don't get factors... 
ne_state_data <- data.frame(state_code,population, houseseats, stringsAsFactors = FALSE)
ne_state_data

ne_state_data$state_code

# Use RStudio Session menu to change the 
# working directory to where the data files are.

# Set the working folder where the data file is...
# datapath <- paste0(Sys.getenv("HOME"), "/IntroductionToR/Data")
# setwd(datapath)

# run the set folder script....

# Confirm the data file path is correct?
getwd()

# Creating a data.frame implicitly...

salesdata <- read.csv("sales.csv",header=T,sep=",",stringsAsFactors = FALSE)
salesdata

# What class is this?
class(salesdata)

# Get information about the data.frame...
str(salesdata)

# Just show the first few rows...
head(salesdata)
tail(salesdata)

# Get the number of rows and columns...
dim(salesdata)

# read.csv can use column headers as column names...
summary(salesdata$TotalSales)
plot(salesdata$TotalSales)
hist(salesdata$TotalSales, col = 'blue')


#
#####################################
#  Slicing & Filtering              #
#####################################

# Column slicing...
salesdata["TotalSales"]
salesdata[1]
class(salesdata["TotalSales"])
salesdata[,"TotalSales"]
salesdata[c("LastName", "TotalSales")]
# We get a data.frame back...
class(salesdata[c("LastName", "TotalSales")])

# Slicing out rows...
salesdata[,2]
salesdata[1:3,]
class(salesdata[1:3,])

# As we have seen, we can filter on rows...
salesdata[salesdata$TotalSales > 120,]

#####################################################
# No headings.  Columns are automatically named...  #
#####################################################
salesdata <- read.csv("sales_noheadings.csv",header=F,sep=",", stringsAsFactors = FALSE)
salesdata

names(salesdata) <- c('SalesPersonID','FirstName', 'LastName', 'TotalSales', 'AsOfDate', 'SentDate', 'EmployeeID')
salesdata

# Assigning row names.
# A way to easily reference rows...
rownames(salesdata) <- salesdata$EmployeeID
salesdata

# Can use as an alternate key or just a short hand...
salesdata['108',]

# Making referencing a data frame easier...
attach(salesdata)

TotalSales
mean(TotalSales)

# It's handled by the search path...
# You must be careful of one object hiding another, i.e. masking.
# Be careful of multiple data frames with same column name.

search()

#
#########################################
# Data Frame Shaping...                 #
#########################################

salesdata <- read.csv("sales.csv",header=T,sep=",", stringsAsFactors = FALSE)
salesdata

# Updating a value...
salesdata[SalesPersonID == 6, 'TotalSales'] <- 2000
salesdata[SalesPersonID == 6, 'TotalSales'] 

# Adding a new column to a data.frame...
salesdata$TaxAmount = salesdata$TotalSales * .07  # 7 % tax rate
salesdata

# Removing a column...
salesdata$TaxAmount = NULL
salesdata

# Adding rows to a data.frame...
salesdata <- rbind(salesdata, list(30, 'Sal', 'Amanda', 3000, '3/27/2014', '7/8/2014'))
salesdata

# Removing a row...
salesdata[-6,]

#  Sorting...
salesdata[order(salesdata$LastName, salesdata$FirstName),]

# Using with...
#   with eliminates the need to prefix each column
#   with the data.frame name just for the function.
salesdata[with(salesdata, order(LastName, FirstName)), ]


#####################################################
# Dealing with Missing Data...                      #
#                                                   #
# NULL is not for data frame column values.  NULL   #
# means the column does not exist.                  #
#                                                   #
# NA is a special value meaning the value is not    #
# known, like the NULL values in a database.        #
#####################################################
salesdata <- read.csv("sales_missingdata.csv",header=T,sep=",",stringsAsFactors = FALSE)
salesdata

is.na(salesdata$TotalSales)

salesdata <- read.csv("sales_missingdata.csv",header=T,sep=",", na.strings=c("","NA", "NULL"), stringsAsFactors = FALSE)
salesdata

# Skipping NA values...
sum(salesdata$TotalSales)
sum(salesdata$TotalSales, na.rm=TRUE)

