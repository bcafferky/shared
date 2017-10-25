#  Consumer Price Data...
#
#  https://cran.r-project.org/web/packages/blscrapeR/vignettes/Inflation_and_Prices.html

install.packages(c('acs', 'blscrapeR'))

help("acs")
vignette("acs") # None for this package.

library(blscrapeR)

# Consumer Price Index for All Urban Consumers: All Items

cpi_value_all <- bls_api("CUUR0000SA0")
head(df)

# Filter data...
cpi_value_20142015 <- bls_api("CUSR0000SA0",
              startyear = 2014, endyear = 2015)
head(df)

# find out the value of a 1995 dollar in 2015
df <- inflation_adjust(1995)
tail(df)

#  CPI Calculation...

# Set base value.
base_value <- 100

# Get CPI from base period (January 2014).
base_cpi <- subset(df, year==2014 & periodName=="January", select = "value")

# Get the CPI for the new period (February 2015).
new_cpi <- subset(df, year==2015 & periodName=="January", select = "value")

# Calculate the updated value of our $100 investment.
(base_value / base_cpi) * new_cpi
(base_cpi / new_cpi) 

# Woops, looks like we lost a penny!

# Package acs - American Community Survey 
# 
# https://cran.r-project.org/web/packages/acs/acs.pdf

library(acs)

data(cpi)

cpi


