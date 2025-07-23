-- Automate all below tasks in trigger function `Clean_Transform_data_insert_log_clear_staging` and trigger 'trg_insert_data_log_cleanup_staging'
-- 2.Clean data (remove duplicates, nulls) 
-- 3.Transform and move to production tables.
-- 4. insert logs to audit table
-- 5. Automate cleanup Staging table using triggers.

CREATE OR REPLACE FUNCTION Clean_Transform_data_insert_log_clear_staging()
RETURNS TRIGGER AS $$
DECLARE insert_count INT;
BEGIN
	-- Clean and transform data from `staging_employees` to `employees`
	INSERT INTO employees(emp_id, name, age, department, salary)
	SELECT DISTINCT CAST(id AS INT), name, CAST(age AS INT), department, CAST(salary AS NUMERIC(10,2))
	FROM public.staging_employees
	WHERE id IS NOT NULL AND name IS NOT NULL;

	-- Count down How many rows we moved
	GET DIAGNOSTICS insert_count = ROW_COUNT;

	-- Insert Log in Audit Table
	INSERT INTO public.etl_audit_log (action, affected_table, inserted_row)
	VALUES ('Data Load', 'employees', insert_count);
	
	-- cleanup Staging table
	DELETE FROM public.staging_employees;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- create trigger `trg_insert_data_log_cleanup_staging` on staging table
CREATE OR REPLACE TRIGGER trg_insert_data_log_cleanup_staging
AFTER INSERT ON public.staging_employees
FOR EACH STATEMENT
EXECUTE FUNCTION Clean_Transform_data_insert_log_clear_staging();



