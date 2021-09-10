DECLARE
 @FOLDER_NAME             NVARCHAR(128) = N'Final SSIS'
,@FOLDER_ID               BIGINT
,@TARGET_ENVIRONMENT_NAME NVARCHAR(128) = N'Final Environment'
,@ENVIRONMENT_ID          INT
,@VARIABLE_NAME           NVARCHAR(128)
,@VARIABLE_VALUE          NVARCHAR(1024)
,@VARIABLE_DESCRIPTION    NVARCHAR(1024)

DECLARE @ENVIRONMENT_VARIABLES TABLE (
  [name]        NVARCHAR(128)
, [value]       NVARCHAR(1024)
, [description] NVARCHAR(1024)
);


INSERT @ENVIRONMENT_VARIABLES
SELECT [name], [value], [description]
FROM (
  VALUES
         ('ConnectionMSSQL','localhost','Connection MSSQL')
        ,('ConnectionSnowDW','Dsn=dw;pwd=Forever2@;uid=hank0720','Connection SnowSQL DWhouse')
		,('ConnectionSnowStagging','Dsn=s1;pwd=Forever2@;uid=hank0720','Connection SnowSQL Stagging')
		,('CourseAudit','C:\Users\Admin\Desktop\Project_Group1_education-Group02\src\Integration Services Project10\Audit files\CourseAudit.txt','Audit file')
		,('CSV_OutputFact','C:\Users\Admin\Desktop\Project_Group1_education-Group02\src\RunFile\FactTransaction.csv','Fact Transaction file CSV in Folder Run File')
		,('DataLog','C:\Users\Admin\Desktop\Project_Group1_education-Group02\src\Integration Services Project10\DataLog','Data log')
		,('DataProfiling','C:\Users\Admin\Desktop\Project_Group1_education-Group02\src\Integration Services Project10\Data Profiling.txt','Data Profiling')
		,('FactTransactionAudit','C:\Users\Admin\Desktop\Project_Group1_education-Group02\src\Integration Services Project10\Audit files\FactTransactionAudit.txt','Audit file')
		,('InstructorAudit','C:\Users\Admin\Desktop\Project_Group1_education-Group02\src\Integration Services Project10\Audit files\InstructorAudit.txt','Audit file')
		,('RawData','C:\Users\Admin\Desktop\Project_Group1_education-Group02\resources\RawData.csv','Raw Data file CSV in resources')
		,('StudentAudit','C:\Users\Admin\Desktop\Project_Group1_education-Group02\src\Integration Services Project10\Audit files\StudentAudit.txt','Audit file')
		,('TransactionAudit','C:\Users\Admin\Desktop\Project_Group1_education-Group02\src\Integration Services Project10\Audit files\TransactionAudit.txt','Audit file')
		,('ConnectionBatch','C:\Users\Admin\Desktop\Project_Group1_education-Group02\src\snowsql\snowPut.bat','Batch File in Folder snowsql')
) AS v([name], [value], [description]);
 
SELECT * FROM @ENVIRONMENT_VARIABLES;  -- debug output	

IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[folders] WHERE name = @FOLDER_NAME)
    EXEC [SSISDB].[catalog].[create_folder] @folder_name=@FOLDER_NAME, @folder_id=@FOLDER_ID OUTPUT
ELSE
    SET @FOLDER_ID = (SELECT folder_id FROM [SSISDB].[catalog].[folders] WHERE name = @FOLDER_NAME)
	

IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environments] WHERE folder_id = @FOLDER_ID AND
               name = @TARGET_ENVIRONMENT_NAME)
    EXEC [SSISDB].[catalog].[create_environment]
     @environment_name=@TARGET_ENVIRONMENT_NAME,
     @folder_name=@FOLDER_NAME

-- get the environment id
SET @ENVIRONMENT_ID = (SELECT environment_id FROM [SSISDB].[catalog].[environments] 
WHERE folder_id = @FOLDER_ID and name = @TARGET_ENVIRONMENT_NAME)

SELECT TOP 1
 @VARIABLE_NAME = [name]
,@VARIABLE_VALUE = [value]
,@VARIABLE_DESCRIPTION = [description]
FROM @ENVIRONMENT_VARIABLES
WHILE @VARIABLE_NAME IS NOT NULL
BEGIN
   PRINT @VARIABLE_NAME
    -- create environment variable if it doesn't exist
   IF NOT EXISTS (
      SELECT 1 FROM [SSISDB].[catalog].[environment_variables] 
      WHERE environment_id = @ENVIRONMENT_ID AND name = @VARIABLE_NAME
   )
      EXEC [SSISDB].[catalog].[create_environment_variable]
        @variable_name=@VARIABLE_NAME
      , @sensitive=0
      , @description=@VARIABLE_DESCRIPTION
      , @environment_name=@TARGET_ENVIRONMENT_NAME
      , @folder_name=@FOLDER_NAME
      , @value=@VARIABLE_VALUE
      , @data_type=N'String'
   ELSE
    -- update environment variable value if it exists
      EXEC [SSISDB].[catalog].[set_environment_variable_value]
        @folder_name = @FOLDER_NAME
      , @environment_name = @TARGET_ENVIRONMENT_NAME
      , @variable_name = @VARIABLE_NAME
      , @value = @VARIABLE_VALUE
   DELETE TOP (1) FROM @ENVIRONMENT_VARIABLES
   SET @VARIABLE_NAME = null
   SELECT TOP 1
     @VARIABLE_NAME = [name]
    ,@VARIABLE_VALUE = [value]
    ,@VARIABLE_DESCRIPTION = [description]
    FROM @ENVIRONMENT_VARIABLES
END			