CREATE TABLE IF NOT EXISTS timesheet.dim_status(
    status_id SERIAL PRIMARY KEY,
    terminate_date DATE,
    name VARCHAR(255)
);