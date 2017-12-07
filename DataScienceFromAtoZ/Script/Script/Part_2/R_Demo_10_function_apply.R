
myvect = 1:10

class(myvect)

myfunct <- function (x)  { x / 2 }

#  Custom functions are vectorized...
myfunct(myvect)

#  For matrix or other array use apply...
mymatrix <- matrix(c(1,2,3,4,5,6,7,8), nrow = 2)
#  Returns results as a matrix...
apply(mymatrix,2,myfunct)

#  Returns results as a list...
lapply(myvect, myfunct)
