#  Author:  Bryan Cafferky
#
#   Purpose:  To do stuff.
#

#  Help tab to get to documents.
#
#  Built in available packages.
#
#  R comes with built in data to play with...

#  List available built-in datasets...
data()

# Examples...
AirPassengers

plot(AirPassengers)

class(AirPassengers)

mode(AirPassengers)   #  what is the data type of each element?

hist(AirPassengers, col='blue')   # Historgram

#  See example graphs
example(persp)

example(boxplot)

#  Nice data viewing...
View(mtcars)

#  Handy data editor...
edit(mtcars)



