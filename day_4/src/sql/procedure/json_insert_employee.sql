CREATE Procedure json_insert_employees
(@json VARCHAR(MAX) = '')
AS
BEGIN


INSERT INTO etl.raw_employee
SELECT *
	FROM OPENJSON(@json)
	WITH (
        employee_id VARCHAR(200) '$.employee_id'
        first_name VARCHAR(200) '$.first_name',
        last_name VARCHAR(200) '$.last_name',
        department_id VARCHAR(200) '$.department_id',
        department_name VARCHAR(200) '$.department_name',
        manager_employee_id VARCHAR(200) '$.manager_employee_id',
        employee_role VARCHAR(200) '$.employee_role',
        salary VARCHAR(200) '$.salary',
        hire_date VARCHAR(200) '$.hire_date',
        terminated_date VARCHAR(200) '$.terminated_date',
        terminated_reason VARCHAR(200) '$.terminated_reason',
        dob VARCHAR(200) '$.dob',
        fte VARCHAR(200) '$.fte',
        location VARCHAR(200) '$.location'
		)