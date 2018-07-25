

IF OBJECT_ID('[Staging].[EmployeeTransformed]', 'U') IS NULL 
BEGIN
  CREATE TABLE [Staging].[EmployeeTransformed](
	[ID] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[MI] [varchar](50) NULL,
	[FullName] varchar(500) NULL,
	[StartDate] date NULL,
	[EndDate] date NULL,
	[TenureInMonths] int,
	[Hours] int NULL
  ) ON [PRIMARY]
END;

