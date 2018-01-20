# Linear Regression Explained...

miles_to_boston <- 50

moving_towards_boston <- miles_to_boston:0

moving_away_from_franklin <- 0:miles_to_boston

plot(moving_away_from_franklin, moving_towards_boston,            # plot the variables 
        xlab="From Franklin", ylab="Boston",
        col = "blue",
        main = "Franklin to Boston")              # y???axis label

abline(lm(moving_away_from_franklin ~ moving_towards_boston), col = 'red')


#  Example of linear modeling...

# https://www.mathsisfun.com/data/least-squares-regression.html

hours_sunshine <- c(2,3,5,7,9)

cones_sold <- c(4,5,7,10,15)

# Prelin=minary analysis...
boxplot(hours_sunshine, col = 'lightblue', main = 'Hours of Sunshine')
boxplot(cones_sold, col = 'lightblue', main = 'Cones Sold')

summary(hours_sunshine)


# What's the correlation?
cor(cones_sold, hours_sunshine)

# Let's plot this...
plot(hours_sunshine, cones_sold,    
     xlab="hrs of sunshine", ylab="Ice Cream Cones SOld",
     col = "purple",
     main = "Sunshine to Cone Sales")  

linear_model <- lm(cones_sold ~ hours_sunshine)
# Now add the line...
abline(linear_model, col = "blue", lwd=3)

#  Show the residuals...
# calculate residuals and predicted values...
res <- signif(residuals(linear_model), 5)
pre <- predict(linear_model) # plot distances between points and the regression line
segments(hours_sunshine, cones_sold, hours_sunshine, pre, col="red")

summary(linear_model)

# With data frames...
#  Using the iris data set...

plot(iris$Petal.Length, iris$Sepal.Length)
abline(lm(iris$Sepal.Length ~iris$Petal.Length))



