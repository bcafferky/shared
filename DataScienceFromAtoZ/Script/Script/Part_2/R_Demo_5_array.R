# Arrays...

myarray <- array(1:24, dim=c(3,4,2))

myarray

class(myarray)

class(myarray[1,,])  # Row 1 in both sets...

myarray[,2,]  # Column 2 both sets...

myarray[,,2]  # Rows and columns in 2nd set...

myarray[1,3,2]  # Row 1, column 3, set 2

