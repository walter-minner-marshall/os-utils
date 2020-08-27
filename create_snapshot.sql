USE [GolfNowOne]
GO

create database GolfNowOne2_Snapshot ON
	(Name = 'Spa-Booker_Data', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL13.ALFRED\MSSQL\DATA\GolfNowOne.ss'),
	(Name = 'Spa-Booker_Index', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL13.ALFRED\MSSQL\DATA\GolfNowOne_index.ss')
as snapshot of GolfNowOne;
go