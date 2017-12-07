# From http://www.statmethods.net/graphs/scatterplot.html

attach(mtcars)

plot(wt, mpg, main="Scatterplot Example",
     xlab="Car Weight ", ylab="Miles Per Gallon ", pch=19) 

# Add fit lines
abline(lm(mpg~wt), col="red") # regression line (y~x)

#  Let's see that line smooted out using the lowess function...
lines(lowess(wt,mpg), col="blue") # lowess line (x,y) 

"Output some message."  # Writes to console.

# 1 - Console is where we can enter R commands interactively.
# 2 - Script messages are written to the console.
# 3 - Graphic output goes to the Plots tab.
# 4 - Each script is contained in a separate tab.
# 5 - Run selected script lines (control + ENTER) or entire script (control + SHIFT + S)
# 6 - Code completion to help complete command. Like Intellisense.
# 7 - Environment, History, and Presentation.
# 8 - Files, Plots, Packages, Help, and Viewer.
# 9 - Menu bar.
# 10- Import datasets.
# 11- Install packages.
# 12- Global options.
# 13- View/Edit datasets.
#       View(iris)
#       elements <- data.frame()
       elements <- edit(elements)
# 14- Help. ?command and menu.
# 15- Publishing with R.

#  install.packages("stringi",type="win.binary")


