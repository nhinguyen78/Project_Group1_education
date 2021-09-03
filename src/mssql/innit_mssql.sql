--Create Database
CREATE DATABASE EducationData;

USE EducationData
GO

--Create Tables
CREATE TABLE DimCourse
(
	[Course_ID] INT IDENTITY(1,1) PRIMARY KEY,
	[Course_Name] VARCHAR(50) NOT NULL,
)
 
CREATE TABLE DimInstructor (
    [Instructor_ID] INT IDENTITY(1,1) PRIMARY KEY,
    [Instructor_Name] varchar(50),
)


CREATE TABLE DimStudent(
	[Student_ID] INT IDENTITY(1,1) PRIMARY KEY, 
	[Student_Name] varchar(50), 
	[Date_of_birth] varchar(50),
	[Email] varchar(50),
    [Gender] varchar(50),
    [Rating_class] varchar(50),
    [Class_recommendation] varchar(50),
    [Final_score] varchar(50),
    [Instructor_rating] varchar(50),
    [StartDate] datetime, 
	[EndDate] datetime
)

CREATE TABLE TransactionData (
    [Transaction_ID] INT IDENTITY(1,1) PRIMARY KEY,
    [Instructor_Name] varchar(50),
    [Student_Name] varchar(50),
    [Course_Name] varchar(50),
    [Rating_class] varchar(50),
    [Class_recommendation] varchar(50),
    [Final_Score] varchar(50),
    [Instructor_rating] varchar(50),
    [Registered_date] varchar(50)
)

CREATE TABLE [FactTransaction] (
    [Course_ID] int,
    [Transaction_ID] int,
    [Rating_class] varchar(50),
    [Class_recommendation] varchar(50),
    [Final_Score] varchar(50),
    [Instructor_rating] varchar(50),
    [Registered_date] varchar(50),
    [Instructor_ID] int,
    [Student_ID] int
)

--Create Index
Create clustered index PK_FactTransaction
	On [dbo].[FactTransaction] (Transaction_ID)
Go

Create nonclustered index IX_FactTransaction 
	On [dbo].[FactTransaction] (Course_ID)
Go

--Create clone table and Test Demo

Select * into FactTransactionClone
From FactTransaction

select Transaction_ID from [FactTransaction]
group by Transaction_ID
having count(*) >= 3

Select * from [FactTransaction]
where Transaction_ID ='10022'

Select * from [FactTransactionClone]
where Transaction_ID ='10022'

--Create Eror Logs table
Use EducationData
Go;

IF EXISTS(SELECT 1 FROM sysobjects with (nolock) where ID = OBJECT_ID(N'Error_Logs') AND type = (N'U'))
drop table Error_Logs
go

Create table Error_Logs(ID INT IDENTITY, MachineName varchar(200), PackageName varchar(200), TaskName varchar(200), ErrorCode int,
ErrorDescription varchar(max), Dated datetime)
go

insert into Error_Logs values ('(local)', 'MyPackage.dtsx', 'MyDFT', 102,'Unable to locate file', getdate())

select * from Error_Logs;

	