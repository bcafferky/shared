this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
getwd()

movies <- read.csv("movies.csv")

str(movies)

summary(movies)

# average score...
mean(movies$critics_score)

movies$title

head(movies)

mgenre <- as.factor(movies$genre)

hist(movies$dvd_rel_year)

movies[movies$genre == "Comedy",]


movies[]