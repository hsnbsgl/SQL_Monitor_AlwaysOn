SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[spMonitor_AlwaysOn_Availability_Groups] 
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @lcTimeSeries INT, @lcTime DATETIME = GETDATE()
	SELECT @lcTimeSeries = NEXT VALUE FOR MonitorAlwaysOnTimeSeries

	INSERT INTO dbo.Monitor_AlwaysOn (TimeSeries, [Time], AvailabilityGroupName, DatabaseName, redo_queue_size_KB, log_send_queue_size_KB, log_send_rate_KBperSec, redo_rate_KBperSec,
											synchronization_health, synchronization_state, database_state, suspend_reason,is_local)
	SELECT @lcTimeSeries, @lcTime, AG.name AS AvailabilityGroupName, 
			D.name AS DatabaseName, 
			HA.redo_queue_size, HA.log_send_queue_size, 
			HA.log_send_rate, HA.redo_rate,
			HA.synchronization_health_desc, HA.synchronization_state_desc, ISNULL(HA.database_state_desc, D.state_desc), HA.suspend_reason_desc, HA.is_local
	FROM sys.dm_hadr_database_replica_states HA WITH (NOLOCK)
		JOIN sys.availability_groups AG WITH (NOLOCK) ON HA.group_id = AG.group_id
		JOIN sys.databases D WITH (NOLOCK) ON HA.group_database_id = D.group_database_id 
	WHERE
			(
				ISNULL(HA.redo_queue_size, 0)>0 OR ISNULL(HA.log_send_queue_size, 0)>0 OR 
				HA.synchronization_health_desc<>'HEALTHY' OR 
				HA.synchronization_state_desc NOT IN ('SYNCHRONIZING', 'SYNCHRONIZED') OR 
				D.state_desc <> 'ONLINE' OR
				ISNULL(HA.database_state_desc, 'ONLINE')<>'ONLINE'
			)
END 
 
  
