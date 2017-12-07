#  xapply functions where x = return type...

#  apply set of functions help perform
#  functions on different types of data structures...

#  apply works on arrays
var <- matrix(1:20, ncol = 4)
apply(var,2,sum) # sum columns

mylist = list(1:5,5:20,1:6,7:12)
lapply(mylist, mean)


#  parameters are variable
#    First parameter = variable to process
#    Second parameter = 1 for row/2 for column
#    Third parameter = function
apply(var,2,sum) # sum columns
apply(var,1,sum) # sum rows

# Different apply functions take different types
# of input and return different types of output.
mylist = list(1:5,5:20,1:6,7:12)

# This will not work...
mean(mylist)

# But this does...
lapply(mylist, mean)

# https://www.rdocumentation.org/packages/base/versions/3.0.3/topics/lapply

# list in and
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
# compute the list mean for each list element

# list out...
lapply(x, mean)

# median and quartiles for each list element
lapply(x, quantile, probs = 1:3/4)

# sapply returns a vector or matrix as needed
sapply(x, quantile)  # returns a matrix
sapply(mylist, sum)  # returns a vector

i39 <- sapply(3:9, seq) # list of vectors
sapply(i39, fivenum)
vapply(i39, fivenum,
       c(Min. = 0, "1st Qu." = 0, Median = 0, "3rd Qu." = 0, Max. = 0))

# Recap...
#   apply for input and output of arrays
#  lapply for input and output of lists
#  sapply for list input but matrix or vector return
# 

