-- 1. Import raw data (CSV) into staging tables, wrap in procedure `load_staging_employees`(input parameter)

CREATE OR REPLACE PROCEDURE load_staging_employees(file_path TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
	-- Import raw data (CSV) into staging tables from source address (file_path) by use 'EXECUTE' to build the command dynamically as text
	EXECUTE format ('COPY public.staging_employees FROM %L DELIMITER '','' CSV HEADER', file_path);
END;
$$





