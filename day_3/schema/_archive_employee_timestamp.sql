CREATE SCHEMA IF NOT EXISTS etl;

CREATE TABLE IF NOT EXISTS etl.archive_raw_employee(
        employee_id VARCHAR(200),
        first_name VARCHAR(200),
        last_name VARCHAR(200),
        department_id VARCHAR(200),
        department_name VARCHAR(200),
        manager_employee_id VARCHAR(200),
        employee_role VARCHAR(200),
        salary VARCHAR(200),
        hire_date VARCHAR(200),
        terminated_date VARCHAR(200),
        terminated_reason VARCHAR(200),
        dob VARCHAR(200),
        fte VARCHAR(200),
        location VARCHAR(200),
        filename VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS etl.archive_raw_timestamp(
    employee_id VARCHAR(200),
    cost_center VARCHAR(200),
    punch_in_time VARCHAR(200),
    punch_out_time VARCHAR(200),
    punch_apply_date VARCHAR(200),
    hours_worked VARCHAR(200),
    paycode VARCHAR(200),
    filename VARCHAR(200)
);