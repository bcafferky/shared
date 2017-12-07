#  R Client Side Demo from Microsoft site...
#  https://msdn.microsoft.com/en-us/microsoft-r/microsoft-r-getting-started
#
#  Note:  On web page examples replace &lt; with <- 
#
#  Using rx prefixed functions to get scalability, runs the code on the server.

#
# Test installation...  Caution:  Takes a long time to run.
#
# library(RevoIOQ)
# RevoIOQ()

# Note:  "sampleDataDir" points to where the data is.

# * Runs on local machine, no context set.
#   Uses scaleR functions.

##########################################################################
#                         L O W   S C A L E                              #
##########################################################################

library("RevoScaleR")

# R Server has configurable options...
rxOptions()
rxGetOption("sampleDataDir")

#  Set the path to the input data file...
inDataFile <- file.path(rxGetOption("sampleDataDir"),
                        "mortDefaultSmall2000.csv")

#  Use rxImport to load the data into a data frame.
#     - rxImport can read many formats including anything that
#       has an ODBC driver. 

#  Note:  Working in local context.
mortData <- rxImport(inData = inDataFile)

str(mortData)

dim(mortData)

#  rxGetInfo - efficient way to get data frame info...
rxGetInfo(mortData, getVarInfo = TRUE, numRows=3)

#### .xdf is a highly compressed binary file format that is
#### very efficient and super fast to read into memory.
#### Kind of like the SSIS raw file format.

#  Load the data again but this time
#  Set it up for output files by creating dummy file name holders...
#  If outFile has a string, it will write to that file name in .xdf format.
outFile <- "somedata.xdf"
outFile2 <- NULL
mortData <- rxImport(inData = inDataFile, outFile = outFile)

# references the xdf file now...
head(mortData)

# rxDataStep...
#   Like a little self contained ETL function.
#   - drop variables.
#   - filter rows.
#   - add new columns.
mortDataNew <- rxDataStep(
  # Specify the input data set
  inData = mortData,
  # Put in a placeholder for an output file
  outFile = outFile2,
  # Specify any variables to keep or drop
  varsToDrop = c("year"),
  # Specify rows to select
  rowSelection = creditScore < 850,
  # Specify a list of new variables to create
  transforms = list(
    catDebt = cut(ccDebt, breaks = c(0, 6500, 13000),
                  labels = c("Low Debt", "High Debt")),
    lowScore = creditScore < 625))

# rxGetInfo...
rxGetVarInfo(mortDataNew)

head(mortDataNew)

# rxHistogram...
# What is notworth about the historgram displayed?
rxHistogram(~creditScore, data = mortDataNew )

#  More analysis with rxCube

# rxCube - Creates a cross tab summary...
#   F() converts the variable to a factor.  groups by debt category.
#   Descrete numbers are mapped into ranges of 50.
#   ?rxCube
mortCube <- rxCube(~F(creditScore):catDebt, data = mortDataNew, reportProgress = 3)
summary(mortCube)
head(mortCube)

str(mortCube)

# Now plot the cube using rxLinePlot...
rxLinePlot(Counts~creditScore|catDebt, data=rxResultsDF(mortCube))

#  rxLogit...
myLogit <- rxLogit(default~ccDebt+yearsEmploy , data=mortDataNew)
summary(myLogit)

# RevoScaleR provides the foundation for a variety of high performance, scalable data analyses. 
# Here we'll do a logistic regression, but you'll probably also want to take look at computing summary 
# statistics (rxSummary), computing cross-tabs (rxCrossTabs), estimating linear models (rxLinMod) or
# generalized linear models (rxGlm), and estimating variance-covariance or correlation matrices (rxCovCor) 
# that can be used as inputs to other R functions such as principal components analysis and factor analysis. 
# Now, let's estimate a logistic regression on whether or not an individual defaulted on their loan, using
# credit card debt and years of employment as independent variables:


##########################################################################
#                         H I G H  S C A L E                            #
##########################################################################

# Scaling up by writing data to .xdf file....

#inDataFile <- file.path(bigDataDir, "mortDefault","mortDefault2000.csv")

# For a full list of options, see...
#     https://docs.microsoft.com/en-us/machine-learning-server/r-reference/revoscaler/rxoptions

inDataFile <- file.path(rxGetOption("sampleDataDir"),
                        "mortDefault2009.csv")

str(inDataFile)

outFile <- "myMortData.xdf"
outFile2 <- "myMortData2.xdf"
# xdf files are highly compressed and stored on disk mainly 
# with stub in memory.

mortData <- rxImport(inData = inDataFile, outFile = outFile, overwrite = TRUE)
rxGetInfo(mortData, getVarInfo = TRUE, numRows=3)

# Some quick information about my data
rxGetInfo(mortData, getVarInfo = TRUE, numRows=5)

# The data step
mortDataNew <- rxDataStep(
  # Specify the input data set
  inData = mortData,
  # Put in a placeholder for an output file
  outFile = outFile2, overwrite = TRUE,
  # Specify any variables to keep or drop
  varsToDrop = c("year"),
  # Specify rows to select
  rowSelection = creditScore < 850,
  # Specify a list of new variables to create
  transforms = list(
    catDebt = cut(ccDebt, breaks = c(0, 6500, 13000),
                  labels = c("Low Debt", "High Debt")),
    lowScore = creditScore < 625))

rxHistogram(~creditScore, data = mortDataNew )

myCube = rxCube(~F(creditScore):catDebt, data = mortDataNew)

rxLinePlot(Counts~creditScore|catDebt, data=rxResultsDF(myCube))

# Compute a logistic regression
myLogit <- rxLogit(default~ccDebt+yearsEmploy, data=mortDataNew)
summary(myLogit)

#  Check memory...
memory.limit()

memory.size(max = FALSE)



