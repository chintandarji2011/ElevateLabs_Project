/* Goal: Load raw CSV data into a postgreSQL database, 
clean/transform it, 
track changes via logs, and
prepare the final cleaned data */

/*
8. SQL ETL Pipeline Simulation
Objective: Simulate ETL (Extract, Transform, Load) using SQL.
Tools: SQLite + DB Browser
Mini Guide:
1.Import raw data (CSV) into staging tables. wrap in procedure `load_staging_employees`(input parameter)
** Automate all below tasks in trigger function `Clean_Transform_data_insert_log_clear_staging` 
and trigger 'trg_insert_data_log_cleanup_staging' **
	3.Transform and move to production tables.
	4.Create audit table for tracking insert logs.
	5.Automate cleanup using triggers.

6.Export final tables, audit table and documentation. wrap in procedure 'Export_final_table'(input parameter) and 'Export_Audit_table'(input parameter).

Deliverables:
SQL scripts, ETL logs, cleaned production tables.

*/

-- staging table (RAW)
CREATE TABLE staging_employees 
(
	id TEXT,
	name TEXT,
	age TEXT,
	department TEXT,
	salary TEXT
);

-- Production table (cleaned)
CREATE TABLE employees
(
	emp_id INT PRIMARY KEY,
	name VARCHAR(100),
	age INT,
	department VARCHAR(100),
	salary NUMERIC(10,2),
	inserted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit Table
CREATE TABLE etl_audit_log
(
	log_id SERIAL PRIMARY KEY,
	action TEXT,
	affected_table TEXT,
	inserted_row INT,
	run_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
