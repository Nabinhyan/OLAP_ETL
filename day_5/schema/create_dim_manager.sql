CREATE TABLE IF NOT EXISTS timesheet.dim_manager(
  id SERIAL PRIMARY KEY,
  client_employee_id VARCHAR(255),
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);