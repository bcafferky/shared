USE Development
go

DROP TABLE IF EXISTS dbo.Sample;

CREATE TABLE dbo.[Sample] (
    [AddressLine1] varchar(50),
    [City] varchar(50),
    [StateProvinceID] varchar(50),
    [PostalCode] varchar(50)
)