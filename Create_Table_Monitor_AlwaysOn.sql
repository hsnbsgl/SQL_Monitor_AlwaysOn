
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Monitor_AlwaysOn](
	[RowId] [INT] IDENTITY(1,1) NOT NULL,
	[TimeSeries] [INT] NOT NULL,
	[Time] [DATETIME] NOT NULL,
	[AvailabilityGroupName] [VARCHAR](128) NOT NULL,
	[DatabaseName] [VARCHAR](128) NOT NULL,
	[redo_queue_size_KB] [BIGINT] NULL,
	[log_send_queue_size_KB] [BIGINT] NULL,
	[log_send_rate_KBperSec] [BIGINT] NULL,
	[redo_rate_KBperSec] [BIGINT] NULL,
	[synchronization_health] [VARCHAR](60) NULL,
	[synchronization_state] [VARCHAR](60) NULL,
	[database_state] [VARCHAR](60) NULL,
	[suspend_reason] [VARCHAR](60) NULL,
	[LOG_Date] [DATETIME] NOT NULL,
	[LOG_Hostname] [VARCHAR](100) NOT NULL,
	[LOG_App] [VARCHAR](300) NOT NULL,
	[LOG_SQL_LoginName] [VARCHAR](100) NOT NULL,
	[is_local] [BIT] NULL,
 CONSTRAINT [PK_zzLOG_Monitor_AlwaysOn] PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Monitor_AlwaysOn] ADD  CONSTRAINT [DF__zzLOG_Mon__LOG_D__00D46649]  DEFAULT (GETDATE()) FOR [LOG_Date]
GO

ALTER TABLE [dbo].[Monitor_AlwaysOn] ADD  CONSTRAINT [DF__zzLOG_Mon__LOG_H__01C88A82]  DEFAULT (HOST_NAME()) FOR [LOG_Hostname]
GO

ALTER TABLE [dbo].[Monitor_AlwaysOn] ADD  CONSTRAINT [DF__zzLOG_Mon__LOG_A__02BCAEBB]  DEFAULT (APP_NAME()) FOR [LOG_App]
GO

ALTER TABLE [dbo].[Monitor_AlwaysOn] ADD  CONSTRAINT [DF__zzLOG_Mon__LOG_S__03B0D2F4]  DEFAULT (ORIGINAL_LOGIN()) FOR [LOG_SQL_LoginName]
GO
