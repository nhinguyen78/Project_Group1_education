put file://C:\Users\NhiNTH1\Desktop\workingfolder\*.csv @snowflake_push;

 
COPY INTO DIMCOURSE1 FROM @snowflake_push/DimCourse.csv.gz;
COPY INTO DIMinstructor1 FROM @snowflake_push/DimInstructor.csv.gz; 
COPY INTO DIMStudent1 FROM @snowflake_push/DimStudent.csv.gz;
COPY INTO FactTransaction FROM @snowflake_push/FactTransaction.csv.gz; 