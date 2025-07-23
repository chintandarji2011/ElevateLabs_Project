-- Steps for executions

-- Runs Store procedure for insert raw data in staging table
CALL public.load_staging_employees('D:\employees_raw.csv');
CALL public.load_staging_employees('D:\employees_raw_2.csv');

-- Export employees(production) table to destination folder in CSV formate
CALL public.export_final_table('D:\ETL_sql_project_file\Final_employees.csv');

-- Export Audit(logs) table to destination in CSV formate
CALL public.export_audit_table('D:\ETL_sql_project_file\Final_etl_audit_log.csv');


------------------- Testing queries --------------------------------------------------------------------
-- display staging table
SELECT * FROM public.staging_employees;
-- clear staging table
TRUNCATE TABLE public.staging_employees;

-- Display employees table
SELECT * FROM public.employees;
-- clear employees table
TRUNCATE TABLE public.employees;

-- Display Audir table
SELECT * FROM public.etl_audit_log;
-- Clear Audit table
TRUNCATE TABLE public.etl_audit_log;
--reset the identity 
TRUNCATE TABLE public.etl_audit_log RESTART IDENTITY;
