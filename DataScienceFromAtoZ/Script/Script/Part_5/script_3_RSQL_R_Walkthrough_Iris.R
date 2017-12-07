# Step 1 - Pre

# PreRequisites: You have installed Revolution R Enterprise 7.5.0 or higher on the machine and SQL Server 2016 CTP3 or higher on the database server
# Install required R libraries for this walkthrough if they are not installed. 
#    See https://msdn.microsoft.com/en-us/library/mt591989.aspx on install directions.

if (!('ggmap' %in% rownames(installed.packages()))){
  install.packages('ggmap')
}
if (!('mapproj' %in% rownames(installed.packages()))){
  install.packages('mapproj')
}
if (!('ROCR' %in% rownames(installed.packages()))){
  install.packages('ROCR')
}
if (!('RODBC' %in% rownames(installed.packages()))){
  install.packages('RODBC')
}

# server = 'BryanCafferkyPC\SS2016'
# db = RSQL_Walkthrough

# 2

#### Block 1 
library(RevoScaleR)

# Define the connection string - Microsoft Site says...
#    - This walkthrough requires SQL authentication
#    - For SQL Server 2016 CTP3, the user name must be a SQL login. 
#    Currently the RevoScaleR package does not support Windows integrated authentication.
# connStr <- "Driver=SQL Server;Server=<Your_Server_Name.somedomain.com>;Database=<Your_Database_Name>;Uid=<Your_User_Name>;Pwd=<Your_Password>"

# connStr <- "Driver=SQL Server;Server=BryanCafferkyPC\\SS2016;Database=RSQL_Walkthrough;trusted_connection=true;Port=1433"


# Set ComputeContext. Needs a temp directory path to serialize R objects 
# back and forth.
connStr <- "Driver=SQL Server;Server=BryanCafferkyPC\\SS2016;Database=RSQL_Walkthrough;Uid=bryan;Pwd=bryan"

sqlShareDir <- paste("C:\\AllShare\\",Sys.getenv("USERNAME"),sep="")
sqlWait <- TRUE
sqlConsoleOutput <- FALSE
cc <- RxInSqlServer(connectionString = connStr, shareDir = sqlShareDir, 
                    wait = sqlWait, consoleOutput = sqlConsoleOutput)
rxSetComputeContext(cc)

#Define a DataSource (from a select query) to be used to explore the data and generate features from.
#Keep in mind that inDataSource is just a reference to the result dataset from the SQL query.
sampleDataQuery <- "select top 5000 tipped, fare_amount, passenger_count,trip_time_in_secs,trip_distance, 
    pickup_datetime, dropoff_datetime, pickup_longitude, pickup_latitude, dropoff_longitude,  
    dropoff_latitude from nyctaxi_sample where tip_amount <> 0"


inDataSource <- RxSqlServerData(sqlQuery = sampleDataQuery, connectionString = connStr, 
                                colClasses = c(pickup_longitude = "numeric", pickup_latitude = "numeric", 
                                               dropoff_longitude = "numeric", dropoff_latitude = "numeric"),
                                rowsPerRead=500)

# Note:  inDataSource is a object reference, not the actual data.

#### End of Block 1
	
# Step 3 - Explore Data.

################################
#        Data exploration      #
################################
#   **** Note:  SQL Server Launchpad Service must be started. *****

# Summarize the inDataSource
summary(inDataSource) # Object info...

rxGetVarInfo(data = inDataSource)
start.time <- proc.time()
rxSummary(~fare_amount:F(passenger_count,1,6), data = inDataSource)
used.time <- proc.time() - start.time
print(paste("It takes CPU Time=", round(used.time[1]+used.time[2],2)," seconds, Elapsed Time=", 
            round(used.time[3],2), " seconds to summarize the inDataSource.", sep=""))

# 4

################################
#       Data Visualization     #
################################

# Plot fare amount histogram on the SQL Server, and ship the plot to
# R client to display
start.time <- proc.time()
rxHistogram(~fare_amount, data = inDataSource, title = "Fare Amount Histogram")
used.time <- proc.time() - start.time
print(paste("It takes CPU Time=", round(used.time[1]+used.time[2],2), 
            " seconds, Elapsed Time=", round(used.time[3],2), " seconds to generate histogram.", sep=""))

# 5

# Plot pickup location on map in SQL Server
# Define a function that plots points on a map
mapPlot <- function(inDataSource, googMap){
    library(ggmap)
    library(mapproj)
  
# Open Source R functions require data to be brought back in memory into data frames. 
# Use rxImport to bring in data. 
# Remember: This whole function runs in the SQL Server Context.
    ds <- rxImport(inDataSource)

    p<-ggmap(googMap)+
    geom_point(aes(x = pickup_longitude, y =pickup_latitude ), 
                      data=ds, alpha =.5, color="darkred", size = 1.5)

    return(list(myplot=p))
}

#
# detach("package:ggmap", unload=TRUE)
# detach("package:mapproj", unload=TRUE)

if (!('geosphere' %in% rownames(installed.packages()))){
  install.packages('geosphere')
}
if (!('jpeg' %in% rownames(installed.packages()))){
  install.packages('jpeg')
}
if (!('rjson' %in% rownames(installed.packages()))){
  install.packages('rjson')
}

library(ggmap)  
library(mapproj)  
gc <- geocode("Times Square", source = "google")  
googMap <- get_googlemap(center = as.numeric(gc), zoom = 12, maptype = 'roadmap', color = 'color');  
  
myplots <- rxExec(mapPlot, inDataSource, googMap, timesToRun = 1)  
plot(myplots[[1]][["myplot"]]);                                                  
#

# 6 - Define the features.

# An R function can be used to create a new calculated feature.
# Alternatively, use a user defined function in SQL to create features.
# Below the feature direct_distance is calculated by a T-SQL function.
# Sometimes, feature engineering in SQL might be faster than R
# You need to choose the most efficient way based on real situation
# Here, featureEngineeringQuery is just a reference to the result from a SQL query. 

featureEngineeringQuery = "SELECT tipped, fare_amount, passenger_count,trip_time_in_secs,trip_distance, 
    pickup_datetime, dropoff_datetime, 
    dbo.fnCalculateDistance(pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude) as direct_distance,
    pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude
    FROM nyctaxi_sample
    tablesample (1 percent) repeatable (98052)
"
featureDataSource = RxSqlServerData(sqlQuery = featureEngineeringQuery, 
                                    colClasses = c(pickup_longitude = "numeric", pickup_latitude = "numeric", 
                                               dropoff_longitude = "numeric", dropoff_latitude = "numeric",
                                                  passenger_count  = "numeric", trip_distance  = "numeric",
                                                   trip_time_in_secs  = "numeric", direct_distance  = "numeric"),
                                    connectionString = connStr)

# summarize the feature table after the feature set is created
rxGetVarInfo(data = featureDataSource)

# 7 Train the model.

################################
#        Training models       #
################################
# build classification model to predict tipped or not
system.time(logitObj <- rxLogit(tipped ~ passenger_count + trip_distance + trip_time_in_secs + direct_distance, data = featureDataSource))
summary(logitObj)

# 6

###########################################
#        Make predictions and scoring     #
###########################################
# predict and write the prediction results back to SQL Server table
scoredOutput <- RxSqlServerData(
  connectionString = connStr,
  table = "taxiScoreOutput"
)

rxPredict(modelObject = logitObj, data = featureDataSource, outData = scoredOutput, 
                   predVarNames = "Score", type = "response", writeModelVars = TRUE, overwrite = TRUE)

################################
#        Model evaluation      #
################################
# plot ROC curve from SQL Context
# ?rxRocCurve - Receiver Operating Characteristic calculation and plot.
# Help on understanding the plot at:
#    http://www.r-bloggers.com/illustrated-guide-to-roc-and-auc/
#    Hint:  AUC is the area under the curve.  
#      1 = Perfect Prediction.
#      0 = Throw darts instead.  
#          Note: blog above questions AUC reliability.

rxRocCurve( "tipped", "Score", scoredOutput)

# Plot accuracy vs threshold
# We demonstrate how to do it on the client using Open source R library (ROCR)
# NOTE: The non Revolution R Enterprise functions ("rx") run locally even if execution context is set to SQL Server
# First of all you need to bring the scored Output data to the client using rxImport
scoredOutput = rxImport(scoredOutput)

library('gplots')
library('ROCR')
pred <- prediction(scoredOutput$Score, scoredOutput$tipped)

acc.perf = performance(pred, measure = 'acc')
plot(acc.perf)
ind = which.max( slot(acc.perf, 'y.values')[[1]] )
acc = slot(acc.perf, 'y.values')[[1]][ind]
cutoff = slot(acc.perf, 'x.values')[[1]][ind]

str(scoredOutput)

library(gmodels)

CrossTable(x = scoredOutput$tipped, y = scoredOutput$tipped, prop.chisq=FALSE)

CrossTable(x = iris.testLabels, y = iris_pred, prop.chisq=FALSE)


################################
#   Model operationalization   #
################################
# First, serialize a model and put it into a database table
modelbin <- serialize(logitObj, NULL)
modelbinstr=paste(modelbin, collapse="")

library(RODBC)
conn <- odbcDriverConnect(connStr)

# Persist model by calling a stored procedure from SQL
q<-paste("EXEC PersistModel @m='", modelbinstr,"'", sep="")
sqlQuery (conn, q)

# We have already provided and installed two stored procs to call for prediction on this model - PredictTipBatchMode and PredictTipSingleMode
# predict with stored procedure in batch mode. Take a few records that are not part of training data
# NOTE: You need to generate the distance feature when you extract the records to send for prediction in batch mode
# The following query selects the top 10 observations that are not in training set. 
# This query is parsed as an input parameter to a stored procedure PredictTipBatchMode to make predictions

# **** Error in the MS Tutorial.  Complex queries like the one they provide
#      are not supported by ODBC.  
#      http://stackoverflow.com/questions/30168057/rodbc-error-could-not-sqlexecdirect-in-mysql

input = "N'select top 10 a.passenger_count as passenger_count,a.trip_time_in_secs as trip_time_in_secs,
	a.trip_distance as trip_distance,	a.dropoff_datetime as dropoff_datetime,dbo.fnCalculateDistance(pickup_latitude, pickup_longitude, dropoff_latitude,dropoff_longitude) as direct_distance  
from
(
	select medallion, hack_license, pickup_datetime, passenger_count,trip_time_in_secs,trip_distance,  
		dropoff_datetime, pickup_latitude, pickup_longitude, dropoff_latitude, dropoff_longitude
	from nyctaxi_sample
) a
left outer join
(
select medallion, hack_license, pickup_datetime
from nyctaxi_sample
tablesample (1 percent) repeatable (98052)
) b
on a.medallion=b.medallion and a.hack_license=b.hack_license and a.pickup_datetime=b.pickup_datetime
where b.medallion is null
'"

input = "N'select top 10 passenger_count as passenger_count,trip_time_in_secs as trip_time_in_secs,
	trip_distance as trip_distance,	dropoff_datetime as dropoff_datetime,dbo.fnCalculateDistance(pickup_latitude, pickup_longitude, dropoff_latitude,dropoff_longitude) as direct_distance  
from nyctaxi_sample'"

#  Note:  Score > .50 means a tip is likely.
#  
#  Second error in MS Tutorial.  Their code has proc parameter 
#  as @inquery but it is @input
q<-paste("EXEC PredictTipBatchMode @input = ", input, sep="")
sqlQuery (conn, q)

# Call predict on a single observation
q = "EXEC PredictTipSingleMode 1, 2.5, 631, 40.763958,-73.973373, 40.782139,-73.977303 "
sqlQuery (conn, q)

#  The model can be executed from SQL Agent or called from PowerShell easily.
#  RDeploy can be used to create a web service wrapper to the model.


