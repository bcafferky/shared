# Demo of p value in R
#
# From Statistics: An Introduction Using R by Michael J. Crawley, Wiley, copyright 2015 

t.test.data <- read.csv("C:/Users/BryanCafferky/Documents/BI_UG/Presentations/StatsConcepts/Script/t.test.data.csv")
attach(t.test.data)

# Show the names...
names(t.test.data)

#  Calculate the p value...
t.test(gardenA,gardenB)

# Now show this as a boxplot...
ozone <- (c(gardenA,gardenB))
label <- factor(c(rep("A",10),rep("B",10)))
boxplot(ozone~label,nothces=T,xlab="Garden",ylab="Ozone pphm",col="lightblue")