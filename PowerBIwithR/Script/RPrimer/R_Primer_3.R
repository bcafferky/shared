#  Author:  Bryan Cafferky
#
#   Purpose:  Fun with Vectors.
#

##########
#  It all comes down to vectors...
#########

# Single element vector...
v <- 5
v

# 
v1 <- rnorm(15)  # Note the <- instead of = 
v1

class(v1)

v3 <- c("A","B","C","D")  # String vector...
v3

class(v3)

#  R inheritantly applies functions to the array...
#  R is vectorized!
mean(v1)
sum(v1) 
summary(v1)

#  No - I really mean always and automatically...
v1 * 2
v1 / 2
v1 + 5

# Matrix...
mymat = matrix(c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15),nrow=3)
mymat

mymat * 2

mymat[,1]

mymat > 5 # returnds logicals...

mymat[mymat > 5]  # filter with the logicals...

# Arrays...

myarray <- array(1:24, dim=c(3,4,2))
myarray


# Take-A-Ways
#
# No scalar variables - only vectors or objects built on vectors.
# Operations process the vector without the need to iterate.







