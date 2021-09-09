--Failure Handling 

CREATE OR REPLACE TABLE error_log(error_code number, error_state string, error_message string, stack_trace string);

CREATE OR REPLACE PROCEDURE failure_task1() 
RETURNS varchar 
NOT NULL 
LANGUAGE javascript 
AS $$
var result;
try {
    snowflake.execute({ sqlText:"Alter task task_Course resume" });
    result = "Succeeded";
} catch (err) {
    result = "Failed";
    snowflake.execute({
      sqlText: `insert into error_log VALUES (?,?,?,?)`
      ,binds: [err.code, err.state, err.message, err.stackTraceTxt]
      });
}
return result;
$$;



CREATE OR REPLACE PROCEDURE failure_task2() 
RETURNS varchar 
NOT NULL 
LANGUAGE javascript 
AS $$
var result;
try {
    snowflake.execute({ sqlText:"Alter task task_Instructor resume" });
    result = "Succeeded";
} catch (err) {
    result = "Failed";
    snowflake.execute({
      sqlText: `insert into error_log VALUES (?,?,?,?)`
      ,binds: [err.code, err.state, err.message, err.stackTraceTxt]
      });
}
return result;
$$;


CREATE OR REPLACE PROCEDURE failure_task3() 
RETURNS varchar 
NOT NULL 
LANGUAGE javascript 
AS $$
var result;
try {
    snowflake.execute({ sqlText:"Alter task task_Student resume" });
    result = "Succeeded";
} catch (err) {
    result = "Failed";
    snowflake.execute({
      sqlText: `insert into error_log VALUES (?,?,?,?)`
      ,binds: [err.code, err.state, err.message, err.stackTraceTxt]
      });
}
return result;
$$;


CREATE OR REPLACE PROCEDURE failure_task4() 
RETURNS varchar 
NOT NULL 
LANGUAGE javascript 
AS $$
var result;
try {
    snowflake.execute({ sqlText:"Alter task task_Transaction resume" });
    result = "Succeeded";
} catch (err) {
    result = "Failed";
    snowflake.execute({
      sqlText: `insert into error_log VALUES (?,?,?,?)`
      ,binds: [err.code, err.state, err.message, err.stackTraceTxt]
      });
}
return result;
$$;



call failure_task1()
select * from error_log