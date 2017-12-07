#  R is all about arrays
myvect <- 1:10

myvect

myvect > 3  # Returns logicals or booleans

myvect[myvect > 3]  # Returns elements

myvectbool <- myvect > 3
myvectbool

yourvect <- 20:30
yourvect

# Now let's extract from yourvect using the boolean array from myvect
yourvect[myvectbool]

# Wait...Reverse that...
yourvect[myvectbool==FALSE]

# Taking this a step further
yourvect[yourvect > 22]

yourvect[myvect > 3]

mymat = matrix(1:32,nrow=8)
mymat

#  Find values in column 2 > 10
mymat[mymat[,2] >10,]

v1[b1]

#  Same filter in one line...
mymat[,2][mymat[,2] >10]

# Give names to columns...
colnames(mymat) <- c("First","Second","Third","Fourth")

mymat[,"First"]



