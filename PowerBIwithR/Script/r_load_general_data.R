#  Consumer Price Data...
#
#  https://cran.r-project.org/web/packages/blscrapeR/vignettes/Inflation_and_Prices.html

library(blscrapeR)
library(acs)

# Consumer Price Index for All Urban Consumers: All Items

cpi_value_all_df <- bls_api("CUUR0000SA0")

# Filter data...
cpi_value_20142015_df <- bls_api("CUSR0000SA0",
              startyear = 2014, endyear = 2015)

# find out the value of a 1995 dollar in 2015
value_adjusted <- inflation_adjust(1995)
value_adjusted_1995_df <- value_adjusted[value_adjusted$year > 1994,]

cpi_df <- cpi

# Package acs - American Community Survey 
# 
# https://cran.r-project.org/web/packages/acs/acs.pdf




