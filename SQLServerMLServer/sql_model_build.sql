USE nyctaxi
go

-- Note:  2016 added create or alter.

CREATE OR ALTER PROCEDURE usp_BuildTaxiModel (@param1 int, @param2 int, @param3 int)
AS
/*
Author: Bryan Cafferky - Demo code only - not for production use!

 exec dbo.usp_BuildTaxiModel 1, 2,3

*/

EXEC sp_execute_external_script
  @language =N'R',
  @script=N'
  taxisource <- InputDataSet;

  logitObj <- rxLogit(tipped ~ passenger_count + trip_distance + trip_time_in_secs + direct_distance, data = taxisource);
  # summary(logitObj);

  trained_model <- data.frame(payload = as.raw(serialize(logitObj, connection=NULL)));
  
  OutputDataSet <- trained_model;',

  -- Get model feature source data...
  @input_data_1 =N'SELECT tipped, fare_amount, passenger_count,trip_time_in_secs,trip_distance, 
pickup_datetime, dropoff_datetime, 
dbo.fnCalculateDistance(pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude) as direct_distance,
pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude
FROM nyctaxi_sample
tablesample (1 percent) repeatable (98052)'
  WITH RESULT SETS (( model varbinary(max)));
GO

/*

    [tipped]          [int]      not null,
	[fare_amount] [float] NULL,
	[passenger_count] [int] NULL,
	[trip_time_in_secs] [bigint] NULL,
	[trip_distance] [float] NULL,
	[pickup_datetime] [datetime] NOT NULL,
	[dropoff_datetime] [datetime] NULL,
	[direct_distance] [float] NULL,
	[pickup_latitude] [varchar](30) NULL,
	[pickup_longitude] [varchar](30) NULL,
	[dropoff_latitude] [varchar](30) NULL,
	[dropoff_longitude] [varchar](30) NULL

	*/