

USE [Development]
GO

/****** Object:  Table [Staging].[EmployeeTransformed]    Script Date: 7/4/2018 1:19:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- Run statement below to create the EDW schema
-- Create schema EDW

CREATE TABLE [EDW].[Employee](
	[ID] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[MI] [varchar](50) NULL,
	[FullName] [varchar](500) NULL,
	[StartDate] [date] NULL,
	[TenureInMonths] [int] NULL,
	[Hours] [int] NULL,
	[WeeklySalary] [decimal](10, 2) NULL,
	[FullTimeInd] [char](1) NULL,
	[CreatedDate] smalldatetime NOT NULL Default(GetDate())
) ON [PRIMARY]
GO


