library(MASS)
library(rpart)

setwd("D:/Users/Bryan/Documents/GitHub/shared/shared/PowerBIwithR/Script")

# Let's convert birthwt string columns to factors...
cols <- c('low', 'race', 'smoke', 'ht', 'ui')
birthwt[cols] <- lapply(birthwt[cols], as.factor)

# Separate training and test data...
set.seed(1)
train <- sample(1:nrow(birthwt), 0.75 * nrow(birthwt))

#
######################
#  Create the model  #
######################

library(class)

rm(newbwdata)

trainLabels <- birthwt[train, 1]
newbwdata <- readRDS("newbwdata.Rda")

inbw <- subset(birthwt, select = c(age,lwt,race,smoke,ptl,ht,ui,ftv) )

birthwt_pred <- knn(train = inbw[train, ], test = newbwdata, cl = trainLabels, k=2)

newbwdata$low <- birthwt_pred

rm(birthwt_pred)
rm(inbw)










