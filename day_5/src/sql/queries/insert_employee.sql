INSERT INTO timesheet.employee(client_employee_id, first_name, last_name, department_id, manager_employee_id, salary, hire_date, term_date, term_reason, dob, fte, weekly_hours, role) 
SELECT
       employee_id as client_emoployee_id,
       INITCAP(first_name) as first_name,
       INITCAP(last_name) as last_name,
       d.id as department_id,
       (CASE WHEN manager_employee_id = '-' THEN NULL ELSE manager_employee_id END ) as manager_employee_id,
       CAST(salary AS FLOAT),
       CAST(hire_date AS DATE),
       CAST(CASE WHEN terminated_date = '01-01-1700' THEN NULL ELSE terminated_date END AS DATE),
       terminated_reason,
       CAST(dob AS DATE) AS dob,
       CAST(fte as FLOAT) AS fte,
       CAST(fte as FLOAT) * 40 AS weekly_hours,
       (CASE WHEN employee_role LIKE '%Mgr%' OR employee_role LIKE '%Sup%' THEN 'Manager' ELSE 'Employee' END ) AS role
FROM timesheet.raw_employee
JOIN timesheet.dim_department d
    ON timesheet.raw_employee.department_id = d.department_id
WHERE employee_id <> 'employee_id';
