INSERT INTO timesheet.dim_department(department_id, name)
SELECT DISTINCT
                department_id,
                department_name
FROM timesheet.raw_employee
WHERE  department_id <> 'department_id';