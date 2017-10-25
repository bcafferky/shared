library(RODBC)

# Helped from: http://stackoverflow.com/questions/20310261/read-data-from-microsoft-sql-database-on-remote-desktop-via-r
# By: Sudip Kafle at http://stackoverflow.com/users/1159766/sudip-kafle

ufn_get_connection <- function(host, db, user=NULL, pass=NULL )
{
 
  if(is.null(pass)) 
  {     
    c <- odbcDriverConnect(connection=paste0("server=",host,
                                             ";database=",db,
                                             ";trusted_connection=true;Port=1433;driver={SQL Server};TDS_Version=7.0;"))
  }
  else
  {
    c <- odbcDriverConnect(connection=paste0("server=",host,
                                             ";database=",db,
                                             ";uid=",user,
                                             ";pwd=",pass,
                                             ";trusted_connection=true;Port=1433;driver={SQL Server};TDS_Version=7.0;"))
  }
  
    if(class(c) == 'RODBC') 
    {  
      writeLines("Successfilly opened connection to db")
      return(c)
    } 
    else
    {
      writeLines(paste0("Error opening connection: ", as.character(c)))
    }
  
}

#  Connection with integrated security...
myisconnection <- ufn_get_connection ("(local)", "AdventureWorks2016")

# Connection using credentials...
# myisconnection <- ufn_get_connection ("(local)", "AdventureWorks2016", "userid", "pw")

#  Get column list...
sqlColumns(mysaconnection, "Sales.CreditCard")

# Do a query...
myresults <- sqlQuery(myisconnection, "select * from Sales.CreditCard", errors = TRUE)

# Display results...
myresults

class(myresults)

summary(myresults)

# Analyze column correlation...
library(psych)
pairs.panels(myresults)


