#  Create a new visualization...
library(MASS)
library(rpart)
boxplot(dataset$SalesAmount ~ dataset$SalesYear, col=c("blue","red", "green", "purple"), xlab = "Sales Amount")
