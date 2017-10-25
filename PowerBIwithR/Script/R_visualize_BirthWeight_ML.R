library(MASS)
library(rpart)

# Let's convert birthwt string columns to factors...
cols <- c('low', 'race', 'smoke', 'ht', 'ui')
birthwt[cols] <- lapply(birthwt[cols], as.factor)

# Separate training and test data...
set.seed(1)
train <- sample(1:nrow(birthwt), 0.75 * nrow(birthwt))

library(rpart)
birthwtTree <- rpart(low ~ . - bwt, data = birthwt[train, ], 
                     method = 'class')
# Nicer diagram...
library(rattle)
fancyRpartPlot(birthwtTree, main="Birth Weight")








