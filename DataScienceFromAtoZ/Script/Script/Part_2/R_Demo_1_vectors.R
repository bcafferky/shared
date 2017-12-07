#  Author:  Bryan Cafferky
#
#   Purpose:  Fun with Vectors.
#

##########
#  It all comes down to vectors...
#########

v <- 5
v

v1 <- rnorm(15)  # Note the <- instead of = 
v1

#  Combining vectors...
v2 <- 1:5
v2

v3 <- c(v1,v2)  # Casts to compatible type.  Be careful on this!
v3

# More on vectors...
myvect <- c(1,2,3,4,5)

myvect

#  R inheritantly applies functions to the array...
#  R is vectorized!
mean(myvect)
sum(myvect) 
summary(myvect)

#  Issue with standard deviation in R...
sd(myvect)

# SD by hand...
sqrt(((1-3)^2 + (2-3)^2 + (3-3)^2 + (4-3)^2 + (5-3)^2) / 5 ) 

#  No - I really mean always and automatically...
myvect * 2
myvect / 2
myvect + 5

# Include a label on the output...
cat("The mean of your vector is = ", mean(myvect))

myv2 <- c("A","B","C","D")  # String vector...
myv2

# Take-A-Ways
#
# No scalar variables - only vectors or objects built on vectors.
# Operations process the vector without the need to iterate.







