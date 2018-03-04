EXEC sp_execute_external_script
  @language =N'R',
  @script=N'OutputDataSet<-InputDataSet',
  @input_data_1 =N'SELECT top 10 passenger_count, trip_distance from dbo.nyctaxi_sample'
  WITH RESULT SETS (([passenger_count] int not null, [trip_distance] float not null));
GO
