USE nyctaxi
go

CREATE OR ALTER PROCEDURE usp_insert_taxi_model 
AS
/*
Author: Bryan Cafferky - Demo code only - not for production use!

 Insert new predictive model into table.

*/

INSERT INTO [dbo].[taxi_pred_model] (model)
EXEC  dbo.usp_BuildTaxiModel
;