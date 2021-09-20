CREATE TABLE IF NOT EXISTS timesheet.dim_department(
    id SERIAL PRIMARY KEY,
    department_id VARCHAR(255),
    name VARCHAR(255)
);