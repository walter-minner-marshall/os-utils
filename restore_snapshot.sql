USE [master]
GO

alter database GolfNowOne
set SINGLE_USER
with ROLLBACK IMMEDIATE;
go

restore database GolfNowOne from
DATABASE_SNAPSHOT = 'GolfNowOne2_Snapshot'
go

alter database GolfNowOne
set MULTI_USER
with ROLLBACK IMMEDIATE;
go