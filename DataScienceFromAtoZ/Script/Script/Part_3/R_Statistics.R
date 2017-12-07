##########################################
#      Getting Summary Statistics        #
##########################################

# quartiles are the 3 points that divide the
# data into 4 equal groups...
summary(mtcars$wt)
boxplot(mtcars$wt, col =  'lightblue')

library(psych)

# trimmed = mean without the outliers
# mad     = median absolute deviation
#           like sd but without the squaring
# kurtosis = peakeness
describe(mtcars$wt)  # For one column
describe(mtcars)     # For all columns


### Mode ###

# There is no built in mode function.
#
# Found this mode calculation at the link below...
#    https://www.tutorialspoint.com/r/r_mean_median_mode.htm

# Create the function.
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Create the vector with numbers.
v <- c(2,1,2,3,1,2,3,4,1,5,5,3,2,3)

# Calculate the mode using the user function.
result <- getmode(v)
print(result)

#### End of Mode ####

############################
#    Distribution          #
############################

data()

hist(Nile)   # close to normal distribution

hist(ChickWeight$weight, col='magenta')  # Skews to left

#
##############################################
#   Using Standard Units to Compare Values   #
##############################################

# Use rnorm to generate a normal distribution...
NumberOfValues <- 1000

EUSales <- rnorm(NumberOfValues, mean = 500)
hist(EUSales, col = 'lightgreen')

USSales <- rnorm(NumberOfValues, mean = 2000)
hist(USSales, col = 'magenta')

# 1 - Find the mean...
avg_eu <- sum(EUSales)/NumberOfValues
avg_us <- sum(USSales)/NumberOfValues
avg_eu
avg_us

# 2 - Find the difference from the mean of each value
#     and square it...
diff_eu <- (EUSales - avg_eu)^2
diff_eu
diff_us <- (USSales - avg_us)^2
diff_us

# 3 - Add up the values from step 2...
diff_tot_eu <- sum(diff_eu) 
diff_tot_eu
diff_tot_us <- sum(diff_us) 
diff_tot_us

# 4 - Divide the total from step 3 by the number of values...
diff_avg_eu <- diff_tot_eu / NumberOfValues  # variance
diff_avg_eu
diff_avg_us <- diff_tot_us / NumberOfValues  # variance
diff_avg_us

# 5 - Take the square root of the result of step 4...
sd_eu <- sqrt(diff_avg_eu)  # standard deviation
sd_us <- sqrt(diff_avg_us)  # standard deviation
sd_eu
sd_us

# New sales figures come in.
# Who had the larger sales growth over average?

NewEUSales <- 502
NewUSSales <- 2002

# Convert each amount to standard units...
(NewEUSales - avg_eu)/sd_eu
(NewUSSales - avg_us)/sd_us

# EU had a larger sales growth, it is more
# standard units over the mean.


#################################################
#   Why R May Not Give You the Same Results...  #
#################################################
#
# See blog below for explanation...
# https://stackoverflow.com/questions/28637908/why-is-the-var-function-giving-me-a-different-answer-than-my-calculated-varian

#  Biased versus not biased.
#  Full population vs. sample...

# What we got above...
sd_eu

# R's answer...

#  Issue with standard deviation in R...
sd(EUSales)

# Corrected for degrees of freedom...
sd(EUSales) * sqrt(999/1000)

# Variance is affected too...

diff_avg_eu # What we got...

# R's answer...
var(EUSales)

# Sample selection being accounted for...
diff_tot_eu / 999

# Or to get to what diff_tot_eu has...
var(EUSales)*(999/1000)


#
#2.059418
#> (NewUSSales - avg_us)/sd_us
#[1] 1.918094


