# Installing Packages from CRAN - RStudio

#####
#   You only need to install the package once!!!
####

# What do I already have installed?
installed.packages()

# Put the list into a data.frame
packagelist <- installed.packages()

# Installing a pacakge...
#  install.packages("dplyr")

##########################################
#       More help on packages            #
##########################################

browseVignettes(package="dplyr")

packageDescription("dplyr")

# Installing Packages from GitHub.
#  We want to use the baby names package
#  from Githib so...

install.packages("devtools")

library(devtools)
install_github("hadley/babynames")

# Use the package...
library("babynames")

help.start()  # Get help index
help(package = "babynames")

head(babynames)
tail(babynames)

#
##############################################
#             dplyr package                  #
##############################################

# A word about require...
require("dplyr")  
# require loads the package...
# But is intended for use inside functions that load
# packages...

str(iris)

# select columns by vector
select(iris, Sepal.Length:Petal.Length)

# select by specifying the column names
iris_df <- select(iris, Species, Sepal.Length, Sepal.Width)
iris_df

# mutate - to create calculated columns...
head(mutate(iris_df, NewSepalLength = Sepal.Length / 10 ) )

# filtering
filter(iris, Species == 'setosa' & Sepal.Length > 5)  

# sorting
arrange(iris_df, Sepal.Length)

# Aggregating
summarise(iris, mean_petal_length = mean(Petal.Length, na.rm = TRUE))

# Nesting - we can string functions together...
select(
  arrange(
    mutate(iris,
           petal_2_sepal_length = Petal.Length / Sepal.Length),
    desc(petal_2_sepal_length)), # arrange
  Species, petal_2_sepal_length) # select 
# Above order is mutate, arrange, select.

# Using Piping with magrittr

iris %>%
  mutate(petal_2_sepal_length = Petal.Length / Sepal.Length) %>%
  arrange(desc(petal_2_sepal_length)) %>%
  select(Species, petal_2_sepal_length)

#
##############################################
#            ggplot2 package                 #
##############################################

library("ggplot2")

# Starting simple...
ggplot(iris, aes(x = factor(""), fill = Species) ) +
  geom_bar()

# Adding more...
ggplot(iris,
       aes(x = factor(""), fill = Species) ) +
  geom_bar() +
  coord_polar(theta = "y") +
  scale_x_discrete("")

ggplot(iris,
       aes(x = factor(""), fill = Species) ) +
  geom_bar() +
  coord_polar(theta = "y") +
  scale_x_discrete("") +
  labs(title = "Iris by Species") 

#
##############################################
#             sqldf package                  #
##############################################

library(sqldf)
library(babynames)

str(babynames)

sqldf("select * from babynames where year > 2000 limit 25")

# Aggregation...

sqldf("select name, sum(n) as NameCount
       from babynames 
       where year > 2000
       Group By name limit 10")

# Example of joining data...
ref_sex <- data.frame(sex_code = c('F', 'M'), sex_desc = c('Female', 'Male'))

sqldf("select * 
      from babynames 
      join ref_sex 
      on (babynames.sex = ref_sex.sex_code)
      where year > 2000 limit 10")










