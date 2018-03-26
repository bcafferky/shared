USE [nyctaxi]
GO

/****** Object:  Table [dbo].[taxi_pred_model]    Script Date: 3/6/2018 3:29:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[taxi_new_tip_predictions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[tip] float NOT NULL,
	[CreatedDateTime] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
))

ALTER TABLE [dbo].[taxi_new_tip_predictions] ADD  DEFAULT (getdate()) FOR [CreatedDateTime]
GO


