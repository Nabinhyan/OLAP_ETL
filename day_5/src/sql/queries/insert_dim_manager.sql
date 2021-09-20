INSERT INTO timesheet.dim_manager(client_employee_id, first_name, last_name)
SELECT
    DISTINCT
                m.client_employee_id,
                m.first_name,
                m.last_name
FROM timesheet.employee e
    INNER JOIN timesheet.employee m
        ON e.manager_employee_id = m.client_employee_id;