

IF OBJECT_ID('[Staging].[Employee]', 'U') IS NULL 
BEGIN
  CREATE TABLE [Staging].[Employee](
	[ID] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[MI] [varchar](50) NULL,
	[StartDate] [varchar](50) NULL,
	[EndDate] [varchar](50) NULL,
	[Hours] [varchar](50) NULL
  ) ON [PRIMARY]
END;

