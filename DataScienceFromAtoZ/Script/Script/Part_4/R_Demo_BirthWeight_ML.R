library(MASS)
library(rpart)

# Borrowed heavily from:
#   http://blog.revolutionanalytics.com/2013/06/plotting-classification-and-regression-trees-with-plotrpart.html
#   https://www.r-bloggers.com/using-decision-trees-to-predict-infant-birth-weights/

# About the data...
help(birthwt)  # brings up documentation.

str(birthwt)   # see the column details.

head(birthwt)  # view first few rows.

hist(birthwt$bwt, col='blue')  # Histogram 

table(birthwt$low)

attach(birthwt)
bw_subset <- subset(birthwt, select = c(age,lwt) )
boxplot(bw_subset,col=c("blue","red"),ylab="Centimeters")

library(psych)
pairs.panels(birthwt[,c('age','lwt','race','smoke','low')])

# Categorical data in statistics are called factors.
# These descriptive looking values are actually numeric.
#   Example:  1 = High, 2 = Medium, 3 = Low.

# Factors are often stored as strings in data so we 
# need to convert them to factors to use in a model.
# Let's convert birthwt string columns to factors...
cols <- c('low', 'race', 'smoke', 'ht', 'ui')
birthwt[cols] <- lapply(birthwt[cols], as.factor)

# Next, let us split our dataset so that we have a training set and a testing set.
# Since low = bwt <= 2.5, we exclude bwt from the model, and since it is a classification task, we specify method = 'class'. Let???s take a look at the tree.

# Separate training and test data...
set.seed(1)
train <- sample(1:nrow(birthwt), 0.75 * nrow(birthwt))
test = birthwt[-train, ]

# Now, let us build the model. We will use the rpart function for this.
library(rpart)
birthwtTree <- rpart(low ~ . - bwt, data = birthwt[train, ], 
                     method = 'class')
# Nicer diagram...
library(rattle)
fancyRpartPlot(birthwtTree, main="Birth Weight")

# Stats
summary(birthwtTree)

# Try the model...
#   - next to train is used to get the non training rows.
birthwtPred <- predict(birthwtTree, test, type = 'class')

library(gmodels)
CrossTable(x = test$low, y =  birthwtPred, prop.chisq=FALSE)

#
######################
#     2nd Model      #
######################

library(class)

trainLabels <- birthwt[train, 1]
testLabels <- birthwt[-train, 1]

newdata <- birthwt[-train,c('age','lwt','race','smoke','ptl','ht','ui','ftv')]

birthwt_pred2 <- knn(train = birthwt[train, ], test = birthwt[-train, ], cl = trainLabels, k=2)
birthwt_pred2

library(gmodels)
CrossTable(x = testLabels, y = birthwt_pred2, prop.chisq=FALSE)









