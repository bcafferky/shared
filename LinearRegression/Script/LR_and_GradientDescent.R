install.packages("ISLR")
install.packages("glmnet")
library(glmnet)
library(ISLR)

#######################################################################################
# Data preparation 
####################################################################################### 
data(Hitters)
summary(Hitters) ## Summary of Major League Baseball Data
dim(Hitters) ## 322 observations with 20 variables 
Hitters = na.omit(Hitters) ## remove variables with NAs; 
                           ## new dimension: 263 observations; 20 variables
                
#generate training data 
#set.seed(123)
#n = nrow(Hitters) ## sample size
#train = sample(seq(n), round(n*0.75), replace = FALSE) ## 75% data goes into model training 
x = model.matrix(Salary~.-1,data=Hitters) ##convert factor variables to dummy variables
y = Salary 

#######################################################################################
# LASSO 
#######################################################################################
fit.lasso=glmnet(x,y)
cv.lasso=cv.glmnet(x,y)
coef(cv.lasso)

#lasso.tr=glmnet(x[train,],y[train])
#pred=predict(lasso.tr,x[-train,])
#rmse= sqrt(apply((y[-train]-pred)^2,2,mean))
#######################################################################################
# Ridge
#######################################################################################
fit.ridge=glmnet(x,y,alpha=0)
cv.ridge=cv.glmnet(x,y,alpha=0)
coef(cv.ridge)