# Impressive visualizations...
# Got help from http://www.statmethods.net/graphs/bar.html

#  See example graphs

demo(graphics)

demo(persp)

example(boxplot)

example(hist)

example("scatter.smooth")

example(InsectSprays)

# From: http://www.analyticsvidhya.com/blog/2015/07/guide-data-visualization-r/

library("scatterplot3d") # load
scatterplot3d(iris[,1:3], pch = 16, color="steelblue")

#  Show a map at coordinates...
library(magrittr)
library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=77.2310, lat=28.6560, popup="The delicious food of chandni chowk")
m  # Print the map


#  Wordcloud...
#  From: http://thenewstack.io/data-visualization-basics-r-programming-language/

# install.packages('wordcloud',dependencies=TRUE)
library(wordcloud)

x<-c("data","stats","Sentiment","Analysis","Social","Networking","Visualize",
     "Big data","Graphics","Maths","Algorithms","Machine", "Learning","Classification",
     "Clustering","Grouping","Mining","Text")

f<-c( 78,  40, 172 ,147, 213, 101, 217,  29, 149, 174, 213, 166, 265 ,215,56, 109,  80,   260)

wordcloud(x,f,scale=c(4,1),Inf,random.order=FALSE)

# More...
# From: http://www.analyticsvidhya.com/blog/2015/07/guide-data-visualization-r/

library(RColorBrewer)

data(VADeaths)
par(mfrow=c(2,3))
hist(VADeaths,breaks=10, col=brewer.pal(3,"Set3"),main="Set3 3 colors")
hist(VADeaths,breaks=3 ,col=brewer.pal(3,"Set2"),main="Set2 3 colors")
hist(VADeaths,breaks=7, col=brewer.pal(3,"Set1"),main="Set1 3 colors")
hist(VADeaths,,breaks= 2, col=brewer.pal(8,"Set3"),main="Set3 8 colors")
hist(VADeaths,col=brewer.pal(8,"Greys"),main="Greys 8 colors")
hist(VADeaths,col=brewer.pal(8,"Greens"),main="Greens 8 colors")

# Cross plotting variables...
plot(iris,col=brewer.pal(3,"Set1"))



