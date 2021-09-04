﻿# Guideline Intergation Package
**Folder**:
 1. [Rest API](https://github.com/nhinguyen78/Project_Group1_education/tree/Group02/src/Rest%20API "Rest API"):
	 * [main.py](https://github.com/nhinguyen78/Project_Group1_education/blob/Group02/src/Rest%20API/main.py "main.py") : Code with rest api - implement by python code 
	 * [rsa_key.p8](https://github.com/nhinguyen78/Project_Group1_education/blob/Group02/src/Rest%20API/rsa_key.p8 "rsa_key.p8"): RSA encryption framework comprises of 4 stages: key generation, key distribution, encryption and decryption. 
 2. [RunFile](https://github.com/nhinguyen78/Project_Group1_education/tree/Group02/src/RunFile "RunFile"):
	 * [FactTransaction.csv](https://github.com/nhinguyen78/Project_Group1_education/blob/Group02/src/RunFile/FactTransaction.csv "FactTransaction.csv"): File Transaction after migrate data 
	 * [ssisPut.sql](https://github.com/nhinguyen78/Project_Group1_education/blob/Group02/src/RunFile/ssisPut.sql "ssisPut.sql"): Put file from local to stage Snowflake. 
## Step 1: Creating ODBC Connection 
- Down ODBC Driver from Snowlfake Computing 
- Create connection with DNS with these configuration:
	* User: hank0720
	* Server: cf43998.southeast-asia.azure.snowflakecomputing.com
	* Database: EDUCATIONDATA
	* Schema : DWHOUSE ( DatawareHouse ) and STAGGINGDWH (Stagging ) 
	* Warehouse: COMPUTE_WH 
	* Role: ACCOUNTADMIN
	* Tracing: 4
## Step 2: Config file Bat 
- [config](https://github.com/nhinguyen78/Project_Group1_education/blob/Group02/src/snowsql/config "config"): Set up your config file `C:\Users\Admin\.snowsql\config` with the same ( you can   
drag and drop for overwrite ) 
- [snowPut.bat](https://github.com/nhinguyen78/Project_Group1_education/blob/Group02/src/snowsql/snowPut.bat "snowPut.bat") : `"C:\Program Files\Snowflake SnowSQL\snowsql" -c hank0720 -f C:\Users\Admin\Desktop\RunFile\ssisPut.sql` change suitable path file with C:\*\ is locate file ssisPut.sql 

## Step 03: Parameter and Varaible in SSIS Project
**Parameter**
-  Connection: 
	* Snowflake: Stagging and DW House 
	* MSSQL connection 
- Audit file: 
	* CourseAudit
	* InstructorAudit
	* StudentAudit
	* TransactionAudit
	* FactTransactionAudit
- CSV File:
	* CSV_OutputFact : file CSV of FactTransaction
	* RawData: Orginal Data file  
- DataLog: 

 **Varaible in Package: Load to Snowflake:**
 - Executetable: `C:\Users\Admin\AppData\Local\Programs\Python\Python39\python.exe` which is locate python.exe 
- PythonScript : `main.py`
- WorkingDirectory: Locate main.py,  for instance in this repo [Rest API](https://github.com/nhinguyen78/Project_Group1_education/tree/Group02/src/Rest%20API "Rest API")