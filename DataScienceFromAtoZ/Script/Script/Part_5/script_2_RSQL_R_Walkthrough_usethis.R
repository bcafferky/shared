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

#### Block 1 
library(RevoScaleR)

# Define the connection string - Microsoft Site says...
#    - This walkthrough requires SQL authentication
#    - For SQL Server 2016 CTP3, the user name must be a SQL login. 
#    Currently the RevoScaleR package does not support Windows integrated authentication.
# connStr <- "Driver=SQL Server;Server=<Your_Server_Name.somedomain.com>;Database=<Your_Database_Name>;Uid=<Your_User_Name>;Pwd=<Your_Password>"

# connStr <- "Driver=SQL Server;Server=BryanCafferkyPC\\SS2016;Database=RSQL_Walkthrough;Uid=bryan;Pwd=bryan"
connStr <- "Driver=SQL Server;Server=localhost\\SQL2017;Database=RWalkThru;trusted_connection=true;Port=1433"


# Set ComputeContext. Needs a temp directory path to serialize R objects back and forth
sqlShareDir <- paste("C:\\AllShare\\",Sys.getenv("USERNAME"),sep="")
sqlWait <- TRUE
sqlConsoleOutput <- FALSE
cc <- RxInSqlServer(connectionString = connStr, shareDir = sqlShareDir, 
                    wait = sqlWait, consoleOutput = sqlConsoleOutput)
rxSetComputeContext(cc)

#Define a DataSource (from a select query) to be used to explore the data and generate features from.
#Keep in mind that inDataSource is just a reference to the result dataset from the SQL query.
sampleDataQuery <- "select top 1000 tipped, fare_amount, passenger_count,trip_time_in_secs,trip_distance, 
    pickup_datetime, dropoff_datetime, pickup_longitude, pickup_latitude, dropoff_longitude,  
    dropoff_latitude from nyctaxi_sample"


inDataSource <- RxSqlServerData(sqlQuery = sampleDataQuery, connectionString = connStr, 
                                colClasses = c(pickup_longitude = "numeric", pickup_latitude = "numeric", 
                                               dropoff_longitude = "numeric", dropoff_latitude = "numeric"),
                                rowsPerRead=500)
#### End of Block 1
								
################################
#        Data exploration      #
################################
#   **** SQL Server Launchpad Service must be started. *****

# Summarize the inDataSource
head(inDataSource)
rxGetVarInfo(data = inDataSource)

start.time <- proc.time()
rxSummary(~fare_amount:F(passenger_count,1,6), data = inDataSource)
used.time <- proc.time() - start.time
print(paste("It takes CPU Time=", round(used.time[1]+used.time[2],2)," seconds, Elapsed Time=", 
            round(used.time[3],2), " seconds to summarize the inDataSource.", sep=""))

################################
#       Data Visualization     #
################################

# Plot fare amount histogram on the SQL Server, and ship the plot to R client to display
start.time <- proc.time()
rxHistogram(~fare_amount, data = inDataSource, title = "Fare Amount Histogram")
used.time <- proc.time() - start.time
print(paste("It takes CPU Time=", round(used.time[1]+used.time[2],2), 
            " seconds, Elapsed Time=", round(used.time[3],2), " seconds to generate histogram.", sep=""))

# Plot pickup location on map in SQL Server
# Define a function that plots points on a map
mapPlot <- function(inDataSource, googMap){
    library(ggmap)
    library(mapproj)

# Open Source R functions require data to be brought back in memory into data frames. Use rxImport to bring in data. 
# Remember: This whole function runs in the SQL Server Context.
    ds <- rxImport(inDataSource)

    p<-ggmap(googMap)+
    geom_point(aes(x = pickup_longitude, y =pickup_latitude ), 
                      data=ds, alpha =.5, color="darkred", size = 1.5)

    return(list(myplot=p))
}

# install.packages("mapproj")

#  Switch to local mode
rxSetComputeContext("local")

library(ggmap)
library(mapproj)
# Get the map with Times Square, NY as the center. This is run on the R Client
gc <- geocode("Times Square", source = "google")
googMap <- get_googlemap(center = as.numeric(gc), zoom = 12, maptype = 'roadmap', color = 'color')

# Run the points plotting on SQL server. Passing in the map data as arg to remotely executed function. 
# The points are in the database and will be plotted on the map
myplots <- rxExec(mapPlot, inDataSource, googMap, timesToRun = 1)
plot(myplots[[1]][["myplot"]])

# with SQL Server Context...
rxSetComputeContext(cc)
myplots <- rxExec(mapPlot, inDataSource, googMap, timesToRun = 1)
plot(myplots[[1]][["myplot"]]);

################################
#      Feature engineering     #
################################
# Define a function in open source R to calculate the direct distance between pickup and dropoff as a new feature 
# Use Haversine Formula: https://en.wikipedia.org/wiki/Haversine_formula
env <- new.env()

env$ComputeDist <- function(pickup_long, pickup_lat, dropoff_long, dropoff_lat){
  R <- 6371/1.609344 #radius in mile
  delta_lat <- dropoff_lat - pickup_lat
  delta_long <- dropoff_long - pickup_long
  degrees_to_radians = pi/180.0
  a1 <- sin(delta_lat/2*degrees_to_radians)
  a2 <- as.numeric(a1)^2
  a3 <- cos(pickup_lat*degrees_to_radians)
  a4 <- cos(dropoff_lat*degrees_to_radians)
  a5 <- sin(delta_long/2*degrees_to_radians)
  a6 <- as.numeric(a5)^2
  a <- a2+a3*a4*a6
  c <- 2*atan2(sqrt(a),sqrt(1-a))
  d <- R*c
  return (d)
}

#Define the featureDataSource to be used to store the features, specify types of some variables as numeric
featureDataSource = RxSqlServerData(table = "features", 
                                    colClasses = c(pickup_longitude = "numeric", pickup_latitude = "numeric", 
                                               dropoff_longitude = "numeric", dropoff_latitude = "numeric",
                                                  passenger_count  = "numeric", trip_distance  = "numeric",
                                                   trip_time_in_secs  = "numeric", direct_distance  = "numeric"),
                                    connectionString = connStr)

# Create feature (direct distance) by calling rxDataStep() function, which calls the env$ComputeDist function to process records
# And output it along with other variables as features to the featureDataSource
# This will be the feature set for training machine learning models
start.time <- proc.time()
rxDataStep(inData =   inDataSource, outFile = featureDataSource,  overwrite = TRUE, 
                           varsToKeep=c("tipped", "fare_amount", "passenger_count","trip_time_in_secs", 
                                        "trip_distance", "pickup_datetime", "dropoff_datetime", "pickup_longitude",
                                        "pickup_latitude","dropoff_longitude", "dropoff_latitude"),
                           transforms = list(direct_distance=ComputeDist(pickup_longitude, pickup_latitude, dropoff_longitude, 
                                                              dropoff_latitude)),
                           transformEnvir = env, rowsPerRead=500, reportProgress = 3)
used.time <- proc.time() - start.time
print(paste("It takes CPU Time=", round(used.time[1]+used.time[2],2), 
            " seconds, Elapsed Time=", round(used.time[3],2), " seconds to generate features.", sep=""))

# Alternatively, use a user defined function in SQL 
# to create features.
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

################################
#        Training models       #
################################
# build classification model to predict tipped or not
system.time(logitObj <- rxLogit(tipped ~ passenger_count + trip_distance + trip_time_in_secs + direct_distance, data = featureDataSource))
summary(logitObj)

rxSetComputeContext("local")
################################
#        Make predictions      #
################################
# predict and write the prediction results back 
# to SQL Server table
scoredOutput <- RxSqlServerData(
  connectionString = connStr,
  table = "taxiScoreOutput"
)

rxPredict(modelObject = logitObj, data = featureDataSource, outData = scoredOutput, 
                   predVarNames = "Score", type = "response", writeModelVars = TRUE, overwrite = TRUE)

rxSetComputeContext(cc)

################################
#        Model evaluation      #
################################
# plot ROC curve from SQL Context
#  rxRocCurve( "tipped", "Score", scoredOutput)

scoredOutput = rxImport(scoredOutput);
rxRoc(actualVarName= "tipped", predVarNames = "Score", scoredOutput);

scoredOutput = rxImport(scoredOutput);
rocObjectOut <- rxRoc(actualVarName= "tipped", predVarNames = "Score", scoredOutput);
plot(rocObjectOut);
##


# Plot accuracy vs threshold
# We demonstrate how to do it on the client using 
# Open source R library (ROCR)

# NOTE: The non Revolution R Enterprise functions ("rx") run locally even 
# if execution context is set to SQL Server
# First of all you need to bring the scored Output 
# data to the client using rxImport
scoredOutput = rxImport(scoredOutput)

library('ROCR')
pred <- prediction(scoredOutput$Score, scoredOutput$tipped)

acc.perf = performance(pred, measure = 'acc')
plot(acc.perf)


################################
#   Model operationalization   #
################################
# First, serialize a model and put it into a database table
modelbin <- serialize(logitObj, NULL)
modelbinstr=paste(modelbin, collapse="")

rxSetComputeContext("local")

library(RODBC)
conn <- odbcDriverConnect(connStr )

# Persist model by calling a stored procedure from SQL
q<-paste("EXEC PersistModel @m='", modelbinstr,"'", sep="")
sqlQuery (conn, q)
# verify the model is saved to the database

# We have already provided and installed two stored procs to call for prediction on this model - PredictTipBatchMode and PredictTipSingleMode
# predict with stored procedure in batch mode. Take a few records that are not part of training data
# NOTE: You need to generate the distance feature when you extract the records to send for prediction in batch mode
# The following query selects the top 10 observations that are not in training set. 
# This query is parsed as an input parameter to a stored procedure PredictTipBatchMode to make predictions
input = "N'select top 10 a.passenger_count as passenger_count, 
	a.trip_time_in_secs as trip_time_in_secs,
	a.trip_distance as trip_distance,
	a.dropoff_datetime as dropoff_datetime,  
	dbo.fnCalculateDistance(pickup_latitude, pickup_longitude, dropoff_latitude,dropoff_longitude) as direct_distance 
from
(
	select medallion, hack_license, pickup_datetime, passenger_count,trip_time_in_secs,trip_distance,  
		dropoff_datetime, pickup_latitude, pickup_longitude, dropoff_latitude, dropoff_longitude
	from nyctaxi_sample
)a
left outer join
(
select medallion, hack_license, pickup_datetime
from nyctaxi_sample
tablesample (1 percent) repeatable (98052)
)b
on a.medallion=b.medallion and a.hack_license=b.hack_license and a.pickup_datetime=b.pickup_datetime
where b.medallion is null
'"
q<-paste("EXEC PredictTipBatchMode @inquery = ", input, sep="")
sqlQuery (conn, q)

# Call predict on a single observation
q = "EXEC PredictTipSingleMode 1, 2.5, 631, 40.763958,-73.973373, 40.782139,-73.977303 "
sqlQuery (conn, q)
