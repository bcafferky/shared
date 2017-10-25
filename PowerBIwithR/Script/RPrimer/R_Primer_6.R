# From: http://www.analyticsvidhya.com/blog/2015/07/guide-data-visualization-r/

heatmap(as.matrix(mtcars))

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

library(wordcloud)

x<-c("data","stats","Sentiment","Analysis","Social","Networking","Visualize",
     "Big data","Graphics","Maths","Algorithms","Machine", "Learning","Classification",
     "Clustering","Grouping","Mining","Text")

f<-c( 78,  40, 172 ,147, 213, 101, 217,  29, 149, 174, 213, 166, 265 ,215,56, 109,  80,   260)

wordcloud(x,f,scale=c(4,1),Inf,random.order=FALSE)

# install.packages("ggdendro")
library(ggplot2)
library(ggdendro)
theme_set(theme_bw())

hc <- hclust(dist(USArrests), "ave")  # hierarchical clustering

# plot
ggdendrogram(hc, rotate = TRUE, size = 2 )


# From: http://www.analyticsvidhya.com/blog/2015/07/guide-data-visualization-r/

library(Rcmdr)
library(rgl)

data(iris, package="datasets")
scatter3d(Petal.Width~Petal.Length+Sepal.Length|Species, data=iris, fit="linear", residuals=TRUE, parallel=FALSE, bg="black", axis.scales=TRUE, grid=TRUE, ellipsoid=FALSE)


