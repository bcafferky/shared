#  R is all about matrices (n dimensions)


#########
#    Matrix  - 2 dimensions 
#########
#  But wait!  We can do multimensional arrays (matrix) too...
mymat = matrix(c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15),nrow=3)
mymat
# mymat = matrix(c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15),ncol=5)

# Give names to columns...
colnames(mymat) <- c("First","Second","Third", "Fourth", "Five")

mymat[,'Second']

#  These return vectors...
mymat[2,3]
mymat[,3]
mymat[3,]

#  class returns the object type..
class(mymat)
class(mymat[,3])

# But this returns a matrix...
mymat[c(2,3),]
class(mymat)

# Use the cast function as.type to convert data types...
as.matrix(mymat[,3])

# And actions still act on the array...
mymat / 2

# Add to the matix...
mymat <- matrix(c(mymat, 16, 17, 18),nrow=3)
mymat

myv2 <- c("A","B","C","D")  # String vector...
myv2

#######
#     List = Vector of objects of any type
#######

# Let's create a list...
mylist <- list(mymat,myv2)

mylist  # A collection of objects.

class(mylist)
mylist * 2

mylist[[1]] * 2

# Lists are used to create classes....

# S3 style object classess...

