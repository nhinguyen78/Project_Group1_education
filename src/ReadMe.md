# Guideline Intergation Package
**Folder**:
 1. [Rest API](https://github.com/nhinguyen78/Project_Group1_education/tree/Group02/src/Rest%20API "Rest API"):
	 * [main.py](https://github.com/nhinguyen78/Project_Group1_education/blob/Group02/src/Rest%20API/main.py "main.py") : Code with rest api - implement by python code 
	 * [rsa_key.p8](https://github.com/nhinguyen78/Project_Group1_education/blob/Group02/src/Rest%20API/rsa_key.p8 "rsa_key.p8"): RSA encryption framework comprises of 4 stages: key generation, key distribution, encryption and decryption. 
 2. [RunFile](https://github.com/nhinguyen78/Project_Group1_education/tree/Group02/src/RunFile "RunFile"):
	 * [FactTransaction.csv](https://github.com/nhinguyen78/Project_Group1_education/blob/Group02/src/RunFile/FactTransaction.csv "FactTransaction.csv"): File Transaction after migrate data 
	 * [ssisPut.sql](https://github.com/nhinguyen78/Project_Group1_education/blob/Group02/src/RunFile/ssisPut.sql "ssisPut.sql"): Put file from local to stage Snowflake. 
## Step 1: Creating ODBC Connection 
- Down ODBC Driver from Snowlfake Computing 
- Create 2 connections with DNS with these configurations:
 + Connection 1: Data Warehouse
	* Data Source: dw
	* User: hank0720
	* Password: Forever2@
	* Server: cf43998.southeast-asia.azure.snowflakecomputing.com
	* Database: EDUCATIONDATA
	* Schema : DWHOUSE  
	* Warehouse: COMPUTE_WH 
	* Role: ACCOUNTADMIN
	* Tracing: 4
	
 + Connection 2: Stagging
 	* Data Source: s1
	* User: hank0720
	* Password: Forever2@
	* Server: cf43998.southeast-asia.azure.snowflakecomputing.com
	* Database: EDUCATIONDATA
	* Schema : STAGGINGDWH  
	* Warehouse: COMPUTE_WH 
	* Role: ACCOUNTADMIN
	* Tracing: 4
	
## Step 2: Config file Bat 
- [config](https://github.com/nhinguyen78/Project_Group1_education/blob/Group02/src/snowsql/config "config"): Set up your config file `C:\Users\Admin\.snowsql\config` with the same ( you can   
drag and drop for overwrite ) 
- [snowPut.bat](https://github.com/nhinguyen78/Project_Group1_education/blob/Group02/src/snowsql/snowPut.bat "snowPut.bat") : `"C:\Program Files\Snowflake SnowSQL\snowsql" -c hank0720 -f C:\Users\Admin\Desktop\RunFile\ssisPut.sql` change suitable path file with C:\*\ is locate file ssisPut.sql 

## Step 03: Setup Folder and Install Libraries for Python
- Create a folder and name: `tmp`. Locate the foder in: `C:\`
- Use the suitabke that you changed the path on your: `"C:\Users\17737\AppData\Local\Programs\Python\Python39\python.exe"` to open Command Prompt to create 2 libraries snowflake and snowflake.ingest as bellow:
	* `python -m pip install snowflake`
	* `python -m pip install snowflake.ingest`

## Step 04: Parameter and Varaible in SSIS Project
**Parameter**
-  Connection: 
	* Snowflake: Stagging and DW House 
	* MSSQL connection 
	* Batch connection
- Audit Files: 
	* CourseAudit
	* InstructorAudit
	* StudentAudit
	* TransactionAudit
	* FactTransactionAudit
- CSV Files:
	* CSV_OutputFact : file CSV of FactTransaction
	* RawData: Orginal Data file  
- Data Info Files: 
	* DataLog
	* DataProfiling
	
 **Variables in Package: Main Package & Load to Snowflake:**
 - SMTPUsername: Create gmail username
 - SMTPPassword: Create gmail password
 - SMTPServer: Connect smtp by using gmail
 - SMTPPort: Gmail port
 - From: Create sending user
 - To: Create sending to user
 - Subject: Message Subjects
 - MessageBody: Create Message with Error to user
 
 **Variables in Package: Load to Snowflake:**
- Executetable: `C:\Users\Admin\AppData\Local\Programs\Python\Python39\python.exe` which is locate python.exe 
- PythonScript : `main.py`
- WorkingDirectory: Locate main.py,  for instance in this repo [Rest API](https://github.com/nhinguyen78/Project_Group1_education/tree/Group02/src/Rest%20API "Rest API")
