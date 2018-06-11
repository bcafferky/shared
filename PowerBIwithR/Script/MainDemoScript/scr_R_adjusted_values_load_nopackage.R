# install.packages('blscrapeR')

library(blscrapeR)

# find out the value of a 1995 dollar in 2015
value_adjusted <- inflation_adjust(1995)
value_adjusted_1995_df <- value_adjusted[value_adjusted$year > 1994,]

rm(value_adjusted)