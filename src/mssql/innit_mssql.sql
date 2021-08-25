CREATE DATABASE EducationData;

USE EducationData
GO

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
