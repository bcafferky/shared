EXECUTE sp_execute_external_script
  @language = N'R', 
  @script = N' OutputDataSet <- iris;
    OutputDataSet;' , 
  @input_data_1 = N'  ';