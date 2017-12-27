# data.frames....

mtcars

class(mtcars)

cars <- mtcars

cars[,2]

cars[2:5,]

head(cars)

tail(cars)

str(cars)

# paste() adds a space between each parameter but paste0 does not...
samplepath = paste0(Sys.getenv("HOMEDRIVE"), Sys.getenv("HOMEPATH"), "\\Documents\\R_DataScience_AtoZ\\DATA\\")
setwd(samplepath)

getwd()

salesdata <- read.csv("sales.csv",header=T,sep=",")

class(salesdata)

#  Strings become factors...
salesdata[[2]]
salesdata[,2]

salesdata[salesdata$TotalSales > 120,]




