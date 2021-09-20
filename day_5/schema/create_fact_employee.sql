CREATE TABLE IF NOT EXISTS timesheet.fact_employee(
    employee_id SERIAL PRIMARY KEY,
    client_employee_id VARCHAR(255),
    department_id INT,
    manager_id INT,
    role_id INT,
    salary FLOAT,
    active_status_id INT,
    weekly_hours FLOAT,
    FOREIGN KEY (department_id) REFERENCES timesheet.dim_department(id),
    FOREIGN KEY (role_id) REFERENCES timesheet.dim_role(role_id),
    FOREIGN KEY (active_status_id) REFERENCES timesheet.dim_status(status_id),
    FOREIGN KEY (manager_id) REFERENCES timesheet.dim_manager(id)
);