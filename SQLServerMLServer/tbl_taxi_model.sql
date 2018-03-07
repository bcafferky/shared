USE nyctaxi
go

CREATE TABLE taxi_pred_model (
    model_name varchar(30) not null default('default model') primary key,
    model varbinary(max) not null);