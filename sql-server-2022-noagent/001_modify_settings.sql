EXEC sys.sp_configure 'show advanced options', 1
RECONFIGURE
GO
EXEC sys.sp_configure 'cost threshold for parallelism', 60
RECONFIGURE
GO
EXEC sys.sp_configure 'max degree of parallelism', 3
RECONFIGURE
GO
EXEC sys.sp_configure 'optimize for ad hoc workloads', 1
RECONFIGURE
GO
EXEC sys.sp_configure 'clr enabled', 1
RECONFIGURE
GO
EXEC sys.sp_configure 'clr strict security', 0
RECONFIGURE
GO
EXEC sys.sp_configure 'tempdb metadata memory-optimized', 1
RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure 'min server memory', 1024
RECONFIGURE
GO
EXEC sys.sp_configure 'backup compression default', '1'
RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure 'show advanced options', 0
RECONFIGURE WITH OVERRIDE
GO
