# data.frames....

setwd("D:/Users/Bryan/Documents/GitHub/Professional/Documents/Presentations/PowerBIwithR/Data/")

getwd()

salesdata <- read.csv("sales.csv",header=T,sep=",")

salesdata
class(salesdata)

#  Strings become factors...
salesdata[,2]

salesdata[salesdata$TotalSales > 120,]


