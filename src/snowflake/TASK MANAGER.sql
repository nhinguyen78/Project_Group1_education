--set up context 
use role sysadmin;
use database "EDUCATIONDATA";
use schema "STAGGINGDWH";
use warehouse compute_wh;


--GRANT TASK exucute to Account 
create role taskadmin;

--set the active role to ACCOUNTADMIN before granting the EXECUTE TASK privilege to the new role
use role accountadmin;

grant execute task on account to role taskadmin;

--set the active role to SECURITYADMIN to show that this role can grant a role to another role
use role securityadmin;

grant role taskadmin to role sysadmin;


//CDC ON STAGGING TALBE
-- Stream on Dim Courses
create stream stream_Course on table "EDUCATIONDATA"."STAGGINGDWH"."DIM_COURSE";

create or replace task task_Course
    warehouse = COMPUTE_WH
    schedule = '15 minutes'
    when system$stream_has_data('stream_Course')
as
    merge into "EDUCATIONDATA"."DWHOUSE"."DIM_COURSE" pd
    using "EDUCATIONDATA"."STAGGINGDWH"."DIM_COURSE" stg
    on pd.COURSE_ID = stg.COURSE_ID
    when matched then
    update set pd.COURSE_NAME = stg.COURSE_NAME
    when not matched then
    insert (COURSE_ID,COURSE_NAME)
    values (stg.COURSE_ID, stg.COURSE_NAME);


--Stream on Dim Instructor 
create stream stream_Instructor on table "EDUCATIONDATA"."STAGGINGDWH"."DIM_INSTRUCTOR";

create or replace task task_Instructor
    warehouse = COMPUTE_WH
    schedule = '15 minutes'
    when system$stream_has_data('stream_Instructor')
as
    merge into "EDUCATIONDATA"."DWHOUSE"."DIM_INSTRUCTOR" pd
    using "EDUCATIONDATA"."STAGGINGDWH"."DIM_INSTRUCTOR" stg
    on pd.INSTRUCTOR_ID = stg.INSTRUCTOR_ID
    when matched then
    update set pd.INSTRUCTOR_NAME = stg.INSTRUCTOR_NAME
    when not matched then
    insert (INSTRUCTOR_ID,INSTRUCTOR_NAME)
    values (stg.INSTRUCTOR_ID, stg.INSTRUCTOR_NAME);

--Stream on Dim Student 
create stream stream_Student on table "EDUCATIONDATA"."STAGGINGDWH"."DIM_STUDENT";

create or replace task task_Student
    warehouse = COMPUTE_WH
    schedule = '15 minutes'
    when system$stream_has_data('stream_Student')
as
    merge into "EDUCATIONDATA"."STAGGINGDWH"."DIM_STUDENT" pd
    using "EDUCATIONDATA"."DWHOUSE"."DIM_STUDENT" stg
    on pd.STUDENT_ID = stg.STUDENT_ID
    when matched then
    update set pd.STUDENT_NAME = stg.STUDENT_NAME
    when not matched then
    insert (STUDENT_ID,STUDENT_NAME,EMAIL,DATE_OF_BIRTH,GENDER,STARTDATE,ENDDATE,RATING_CLASS,CLASS_RECOMMENDATION,FINAL_SCORE,INSTRUCTOR_RATING)
    values (stg.STUDENT_ID, stg.STUDENT_NAME,stg.EMAIL,
           stg.DATE_OF_BIRTH,stg.GENDER,stg.STARTDATE,stg.ENDDATE,
           stg.RATING_CLASS, stg.CLASS_RECOMMENDATION, stg.FINAL_SCORE,stg.INSTRUCTOR_RATING);

--Stream on Fact Transaction 

create stream stream_Transaction on table "EDUCATIONDATA"."STAGGINGDWH"."FACTTRANSACTION";

create or replace task task_Transaction
    warehouse = COMPUTE_WH
    schedule = '1 minutes'
    when system$stream_has_data('stream_Transaction')
as
    merge into "EDUCATIONDATA"."STAGGINGDWH"."FACTTRANSACTION" pd
    using "EDUCATIONDATA"."DWHOUSE"."FACTTRANSACTION" stg
    on pd.TRANSACTION_ID = stg.TRANSACTION_ID
    when matched then
    update set pd.COURSE_NAME = stg.COURSE_NAME
    when not matched then
    insert (COURSE_ID,TRANSACTION_ID,COURSE_NAME,RATING_CLASS,CLASS_RECOMMENDATION,FINAL_SCORE
           ,INSTRUCTOR_RATING,REGISTERED_DATE,INSTRUCTOR_ID,STUDENT_ID)
    values (stg.COURSE_ID,stg.TRANSACTION_ID,stg.COURSE_NAME,stg.RATING_CLASS,stg.CLASS_RECOMMENDATION,stg.FINAL_SCORE
           ,stg.INSTRUCTOR_RATING,stg.REGISTERED_DATE,stg.INSTRUCTOR_ID,stg.STUDENT_ID);



alter task task_Course resume;
--alter task task_Instructor suspend;
--alter task task_Student suspend;
alter task task_Transaction resume;


select *
  from table(information_schema.task_history())
  order by scheduled_time;
