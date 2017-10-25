#  From 
#    http://blog.revolutionanalytics.com/2016/01/new-data-sources-for-r.html

install.packages("mice")

library(pageviews)
library(ggplot2)

res <- article_pageviews(project = "en.wikipedia", 
                         article = "R_(programming_language)",
                         start = "2015010100", end = "2015123124")

install.packages("SocialMediaLab")

# https://mran.revolutionanalytics.com/package/rUnemploymentData/
#
#  Unemployment data documentation...
#  https://mran.revolutionanalytics.com/web/packages/rUnemploymentData/rUnemploymentData.pdf

# install.packages("rUnemploymentData")
# install.packages("choroplethrMaps")

library("rUnemploymentData")

state_unemp <- get_state_unemployment_df()

data(df_state_unemployment)

get_state_unemployment_df(year = 2013)

state_unemployment_choropleth(year = 2013, num_colors = 7, zoom = NULL)

animated_county_unemployment_choropleth()






