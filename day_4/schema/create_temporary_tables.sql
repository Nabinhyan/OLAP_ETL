CREATE SCHEMA IF NOT EXISTS etl;

CREATE TABLE IF NOT EXISTS etl.raw_employee(
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
        location VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS etl.raw_timestamp(
    employee_id VARCHAR(200),
    cost_center VARCHAR(200),
    punch_in_time VARCHAR(200),
    punch_out_time VARCHAR(200),
    punch_apply_date VARCHAR(200),
    hours_worked VARCHAR(200),
    paycode VARCHAR(200)

);

CREATE TABLE IF NOT EXISTS etl.dim_department(
    id SERIAL PRIMARY KEY,
    client_department_id VARCHAR(255),
    client_department_name VARCHAR(255)
);

INSERT INTO etl.dim_department("client_department_id", "client_department_name")
    (SELECT department_id, department_name FROM etl.raw_employee
    );

CREATE TABLE IF NOT EXISTS etl.temporary_punch_detail AS (
    SELECT employee_id,
           d.id,
           MIN(punch_in_time::TIMESTAMP::TIME)  AS shift_start_time,
           MAX(punch_out_time::TIMESTAMP::TIME) AS shift_end_time,
           CAST(punch_apply_date AS DATE) AS shift_date,
           CASE
               WHEN punch_in_time::TIMESTAMP::TIME BETWEEN '05:00' AND '11:00'::TIME THEN 'Morning'
               WHEN punch_in_time::TIMESTAMP::TIME >= '12:00'::TIME THEN 'Evening'
               ELSE NULL END AS shift_type
    FROM etl.raw_timestamp e LEFT JOIN etl.dim_department d on e.cost_center = d.client_department_id
    group by employee_id, punch_apply_date, employee_id, punch_out_time, punch_in_time, d.id
);

CREATE TABLE IF NOT EXISTS etl.temporary_hours_worked AS(
    SELECT
        SUM(CAST(hours_worked AS FLOAT)) AS hours_worked
    FROM etl.raw_timestamp
    WHERE paycode = 'WRK'
    GROUP BY employee_id, punch_apply_date, hours_worked
);

CREATE TABLE IF NOT EXISTS etl.temporary_attendance AS (
    SELECT CAST(CASE
                    WHEN SUM(CAST(hours_worked AS FLOAT)) > '2.0' THEN 'T'
                    ELSE 'F' END AS BOOLEAN) AS attendance
    FROM etl.raw_timestamp
    WHERE paycode IN ('WRK', 'CHARGE')
    GROUP BY employee_id, punch_apply_date
);

CREATE TABLE IF NOT EXISTS etl.temporary_break_taken AS (
    SELECT
       CAST(CASE WHEN SUM(CAST(hours_worked AS FLOAT)) > '0.0' THEN 'T'
        ELSE 'F' END AS BOOLEAN) AS has_taken_break
    FROM etl.raw_timestamp WHERE paycode = 'BREAK' GROUP BY employee_id, punch_apply_date
    );

CREATE TABLE IF NOT EXISTS etl.temporary_break_hour AS (
    SELECT
           SUM(CAST(hours_worked AS FLOAT)) AS break_hour
    FROM etl.raw_timestamp
    WHERE paycode = 'BREAK'
    GROUP BY employee_id, punch_apply_date, hours_worked
);

CREATE TABLE IF NOT EXISTS etl.temporary_charge_status AS(
    SELECT
       CAST(CASE WHEN SUM(CAST(hours_worked AS FLOAT)) > '0.0' THEN 'T'
           ELSE 'F' END AS BOOLEAN) AS was_charge
    FROM etl.raw_timestamp WHERE paycode = 'CHARGE' GROUP BY employee_id, punch_apply_date
);

CREATE TABLE IF NOT EXISTS etl.temporary_charge_hour AS (
    SELECT
           SUM(CAST(hours_worked AS FLOAT)) AS charge_hour
    FROM etl.raw_timestamp
    WHERE paycode = 'CHARGE'
    GROUP BY employee_id, punch_apply_date, hours_worked
);

CREATE TABLE IF NOT EXISTS etl.temporary_on_call_status AS (
    SELECT
           CAST(CASE
                    WHEN SUM(CAST(hours_worked AS FLOAT)) > '0.0' THEN 'T'
                    ELSE 'F' END AS BOOLEAN) AS was_on_call
    FROM etl.raw_timestamp
    WHERE paycode = 'ON_CALL'
    GROUP BY employee_id, punch_apply_date
);

CREATE TABLE IF NOT EXISTS etl.temporary_on_call_hour AS (
    SELECT SUM(CAST(hours_worked AS FLOAT)) AS on_call_hour
    FROM etl.raw_timestamp
    WHERE paycode = 'ON_CALL'
    GROUP BY employee_id, punch_apply_date, hours_worked
);

CREATE TABLE IF NOT EXISTS etl.temporary_num_teammates_absent AS (
    SELECT
           COUNT(paycode) AS num_teammates_absent
    FROM etl.raw_timestamp
    WHERE paycode = 'ABSENT'
    GROUP BY cost_center, paycode, punch_apply_date
);


