#  Simple script to demo RStudio... 

# R Studio Notes:

# - R Studio drop down menus and toolbar
# - Tabs to provide transparency.
# - Working directory matters.

a <- 42
A <- a * 2  # R is case sensitive
print(a)
cat(A, "\n") # "84" is concatenated with "\n" and displayed

if(A>a) # true, 84 > 42
{
  cat(A, ">", a)
} 

autodf <- mtcars

boxplot(autodf$mpg, col="purple")

#  A basic Excel like data frame editor...
# edit(autodf)


