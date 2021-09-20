INSERT INTO timesheet.fact_employee(client_employee_id, department_id, manager_id, role_id, salary, active_status_id, weekly_hours)
SELECT
       e.client_employee_id,
       e.department_id,
       m.id as manager_id,
       r.role_id as role_id,
       e.salary,
       s.status_id AS active_status_id,
       e.weekly_hours
FROM timesheet.employee e
    LEFT JOIN timesheet.dim_manager m ON e.manager_employee_id = m.client_employee_id
    LEFT JOIN timesheet.dim_role r on e.role = r.name LEFT JOIN
    timesheet.dim_status s on e.term_date = s.terminate_date
;