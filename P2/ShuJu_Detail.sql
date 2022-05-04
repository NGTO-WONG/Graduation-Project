USE [sj_webdata_db]
GO

/****** Object:  Table [dbo].[ShuJu_Detail]    Script Date: 2022/4/22 10:20:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ShuJu_Detail](
	[detailId] [VARCHAR](50) NOT NULL,
	[Id] [INT] NULL,
	[detailName] [VARCHAR](255) NULL,
	[detailValue] [DECIMAL](18, 2) NULL,
	[createDate] [DATETIME] NULL,
	[state] [VARCHAR](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[detailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


