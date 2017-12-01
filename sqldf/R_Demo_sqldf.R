##################################################
#  Warning: Code is intended for demonostration  #
#           only. Not meant for production use.  #
#           Code is 'as is'.                     #
##################################################

# Installing Packages from CRAN - RStudio

#####
#   You only need to install the package once!!!
####

# What do I already have installed?
installed.packages()

# Put the list into a data.frame
install.packages("sqldf")

##########################################
#       Getting help on packages         #
##########################################

packageDescription("sqldf")
help(sqldf)
# https://cran.r-project.org/web/packages/sqldf/sqldf.pdf

##############################################
#             sqldf package                  #
##############################################

library(sqldf)
library(babynames)

head(babynames)
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

# from sqlf documentation
#   https://github.com/ggrothendieck/sqldf 
sqldf("select iris.Species '[Species]', 
       avg(\"Sepal.Length\") '[Avg of SLs > avg SL]'
    from iris, 
         (select Species, avg(\"Sepal.Length\") SLavg 
         from iris group by Species) SLavg
    where iris.Species = SLavg.Species
       and \"Sepal.Length\" > SLavg
    group by iris.Species")

# load and use a csv file...
sqldf('select * from sales where totalsales > 200
       order by LastName limit 5')

############################################
# Using sqldf with SQL Server data...      #
############################################

library(RODBC)

# Open a connection with integrated security...
con <- odbcDriverConnect(connection=paste0("server=",'(local)',
                                           ";database=",'Adventureworks2016',
                                           ";trusted_connection=true;Port=1433;driver={SQL Server};TDS_Version=7.0;"))

#  Get column list...
sqlColumns(con, "Sales.CreditCard")

# Doa query...
salesSQL <- sqlQuery(con, "select * from Sales.CreditCard", errors = TRUE)

sqldf("select ExpMonth, ExpYear from salesSQL 
       where CardType = 'Vista'
       order by ExpYear, ExpMonth
       limit 10")












