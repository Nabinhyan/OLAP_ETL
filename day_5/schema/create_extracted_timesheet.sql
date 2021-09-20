CREATE TABLE IF NOT EXISTS timesheet.extracted_timesheet(
    employee_id VARCHAR(255),
    work_date DATE,
    department_id INT,
    hours_worked FLOAT,
    shift_type VARCHAR(255),
    shift_start_time TIME,
    shift_end_time TIME,
    attendance VARCHAR(255),
    work_code VARCHAR(255),
    has_taken_break VARCHAR(255),
    break_hour FLOAT,
    was_charge VARCHAR(255),
    charge_hour FLOAT,
    was_on_call VARCHAR(255),
    call_hour FLOAT,
    work_day VARCHAR(255),
    num_teammates_absent INT
);
