--Create tables
CREATE OR REPLACE TABLE DIM_COURSE(
    Course_ID INT NOT NULL,
    Course_Name varchar(50)
  );


CREATE OR REPLACE TABLE DIM_INSTRUCTOR(
	Instructor_ID INT NOT NULL,
    Instructor_Name varchar(50)
  );
  
--Create Table
CREATE OR REPLACE TABLE DIM_STUDENT(
    Student_ID int NOT NULL,
	Student_Name varchar(50),
    Email varchar(50),
	Date_of_birth varchar(50),
	Gender varchar(50),
    StartDate datetime,
	EndDate datetime,
	Rating_class varchar(50),
	Class_recommendation varchar(50),
	Final_score varchar(50),
	Instructor_rating varchar(50)
  );
 

CREATE OR REPLACE TABLE FACTTRANSACTION(
	Course_ID int NOT NULL,
	Transaction_ID int NOT NULL,
    Course_Name varchar(50),
	Rating_class varchar(50),
	Class_recommendation varchar(50),
	Final_Score varchar(50),
	Instructor_rating varchar(50),
	Registered_date datetime,
	Instructor_ID int NOT NULL,
	Student_ID int NOT NULL
  );

