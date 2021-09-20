INSERT INTO timesheet.dim_status(terminate_date, name)
SELECT
       term_date,
       CASE WHEN term_date IS NULL THEN 'Active' ELSE 'De-Activated' END AS active_status
FROM timesheet.employee;