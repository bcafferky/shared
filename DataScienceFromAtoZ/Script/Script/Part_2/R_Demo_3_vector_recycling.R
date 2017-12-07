#  Vector recycling...
v1 <- c(1,2,3,4,5,6)
v2 <- c(6,5,4,3,2,1)
v3 <- c(1,8)

v1 + v2

v1 + v3
v3 + v1

# Comparing vectors...
v1 > v2 
  
v1[FALSE]
v1[TRUE]

# Logicals of True say Get it and False says leave it...
v1[c(TRUE,FALSE,TRUE,FALSE,TRUE,FALSE)]

v1[v1 > v2]  # Powerful filtering method

# Recycling...
v1[v1 > v3]

# V3 elements have to be reused to match the length of the v1 vector...

# V1   v3

# 1     1   - False
# 2     8   - False
# 3     1   - True
# 4     8   - False
# 5     1   - True
# 6     8   - False

#  Recycling does not work if the short vector is not a mutiple of the larger...

#  Will get an error below...
v1 = c(1,2,3,4,5)
v2 = c(1,8)

v1[v1 > v2]
