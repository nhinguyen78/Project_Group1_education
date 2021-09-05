# Project_Group1_education's description

Dear trainers and everyone,

This is Group 1’s GitHub on the first project of as FA Fresher by Minh (Duy-deliver) and Huy Anh ( Anh Huy Ha) . Our project topic for today is Evaluating class quality based on teachers, students, subject information and feedback.

The scenario: One very well-known education center X has one dataset of the students’ reviews. This company wants to analyze the class quality by student feedback based on their report card.

The Guideline:
- Here is the roadmap of what we do from generating data to visualizing them.

![Roadmap](https://github.com/nhinguyen78/Project_Group1_education/blob/master/DataRoadMap.jpg)

- First of all, what we do is we generate data by Python code as OLTP data and we save it as a .csv file, named (untitled folder_CoursesData-2021_08_13-10_53_41_PM.csv)

- Second, we create data pipeline in SQL Server Integration Services (SSIS), which is we load the .csv file. From the file, we ETL it to other Dim tables such as Dim Instructor, Dim Student, Dim Course. Each dims have their unique Primary key in order to create relationship with the Fact table later.

- After the data in all dims has been transformed, we load them to the Cloud destination, called Snowflake. Our server name is: ob27530.southeast-asia.azure.snowflakecomputing.com

- After all dims are all there, we will load the big Fact table on the Cloud too.

- Next our 3 dims and 1 fact are at the Cloud server, we create relationships between these table with the lookup tool in SSIS one last time.

- Finally, the data model is finished and ready to visualize by PowerBI tool.

How to setup
1. Use the raw data in raw-code
2. Login MSSQL and run the script
3. Authen Snowflake and run
Please click [Snowflake](https://cf43998.southeast-asia.azure.snowflakecomputing.com/console#/partner)

User for trainer 1: longbv1
Password: Password@1

Use for trainer 2: mainq2
Password: Password@1

4. Link to PowerBI Visualization
Please click [PowerBI](https://app.powerbi.com/links/7ReXjH56Kp?ctid=f01e930a-b52e-42b1-b70f-a8882b5d043b&pbi_source=linkShare)
