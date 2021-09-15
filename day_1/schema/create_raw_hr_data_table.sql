CREATE SCHEMA IF NOT EXISTS etl;

CREATE TABLE IF NOT EXISTS etl.punch_time(
    punch_id SERIAL PRIMARY KEY,
    punch_on_time TIME,
    punch_out_time TIME,
    punch_date DATE,
    punch_day VARCHAR(10),
    pay_code VARCHAR(12) NOT NULL,
    cover_status BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS etl.department(
    department_id SMALLSERIAL PRIMARY KEY,
    department_name VARCHAR(70) NOT NULL
);

CREATE TABLE IF NOT EXISTS etl.shift(
    shift_id SMALLSERIAL PRIMARY KEY,
    shift_start_time TIME,
    shift_type VARCHAR(9)
);

CREATE TABLE IF NOT EXISTS etl.role(
    role_id SMALLSERIAL PRIMARY KEY,
    role_nane VARCHAR(70)
);

CREATE TABLE IF NOT EXISTS etl.bi_week(
    bi_week_id SERIAL PRIMARY KEY,
    start_date DATE,
    to_date DATE
);

CREATE TABLE IF NOT EXISTS etl.employee(
    punch_id INT,
    shift_id SMALLINT,
    role_id SMALLINT,
    department_id SMALLINT,
    bi_week_id INT,
    employee_id INT,
    work_hour FLOAT,
    salary NUMERIC(10, 2),
    FOREIGN KEY (punch_id) REFERENCES etl.punch_time(punch_id),
    FOREIGN KEY (shift_id) REFERENCES etl.shift(shift_id),
    FOREIGN KEY (role_id) REFERENCES etl.role(role_id),
    FOREIGN KEY (department_id) REFERENCES etl.department(department_id),
    FOREIGN KEY (bi_week_id) REFERENCES etl.bi_week(bi_week_id)
);