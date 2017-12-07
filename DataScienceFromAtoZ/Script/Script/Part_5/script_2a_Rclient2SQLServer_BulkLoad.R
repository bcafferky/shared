# From Microsoft online training documentation...

#  High speed data load into SQL Server...

#  Set option to where data files are...
rxOptions(sampleDataDir = "C:/Users/BryanCafferky/Documents/BI_UG/Presentations/R_PreCon/data")   

sqlConnString <- "Driver=SQL Server;Server=localhost\\SQL2017; Database=Development;trusted_connection=true;Port=1433"   

sqlFraudTable <- "ccFraud" 

sqlRowsPerRead = 5000   

sqlFraudDS <- RxSqlServerData(connectionString = sqlConnString, table = sqlFraudTable, rowsPerRead = sqlRowsPerRead)  

sqlScoreTable <- "ccFraudScoreSmall"  
sqlScoreDS <- RxSqlServerData(connectionString = sqlConnString, table = sqlScoreTable, rowsPerRead = sqlRowsPerRead)  

# ccFraudCsv <- file.path(rxGetOption("sampleDataDir"), "ccFraud.csv")   
 ccFraudCsv <- file.path(rxGetOption("sampleDataDir"), "ccFraudSmall.csv")   

inTextData <- RxTextData(file = ccFraudCsv,      colClasses = c(   
  "custID" = "integer", "gender" = "integer", "state" = "integer",   
  "cardholder" = "integer", "balance" = "integer",    
  "numTrans" = "integer",   
  "numIntlTrans" = "integer", "creditLine" = "integer",    
  "fraudRisk" = "integer"))  

rxDataStep(inData = inTextData, outFile = sqlFraudDS, overwrite = TRUE)  

#  Query a table...
sqlNames <- RxSqlServerData(connectionString = sqlConnString, table = "ccFraud", rowsPerRead = sqlRowsPerRead)  

rxGetVarInfo(data = sqlNames) 

