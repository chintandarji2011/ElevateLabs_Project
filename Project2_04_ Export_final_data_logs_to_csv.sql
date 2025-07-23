-- 6.Export final tables, audit table and documentation. wrap in procedure 'Export_final_table'(input parameter) and 'Export_Audit_table'(input parameter).


-- Export final table
CREATE OR REPLACE PROCEDURE Export_final_table (desti_path TEXT)
LANGUAGE plpgsql 
AS $$

BEGIN
	-- Export final tables to desti_path (destination address) by use 'EXECUTE' to build the command dynamically as text
	EXECUTE format ('COPY employees TO %L DELIMITER '','' CSV HEADER', desti_path);
END;
$$

-- Export Audit table 
CREATE OR REPLACE PROCEDURE Export_Audit_table (desti_path TEXT)
LANGUAGE plpgsql 
AS $$

BEGIN
	-- Export Audit tables to desti_path (destination address) by use 'EXECUTE' to build the command dynamically as text
	EXECUTE format ('COPY etl_audit_log TO %L DELIMITER '','' CSV HEADER', desti_path);
END;
$$
