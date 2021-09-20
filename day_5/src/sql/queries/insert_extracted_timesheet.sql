INSERT INTO timesheet.extracted_timesheet
SELECT
       employee_id,
       CAST(punch_apply_date AS DATE) AS shift_date,
       d.id AS department_id,
       CASE
            WHEN paycode = 'WRK' OR paycode = 'CHARGE' OR paycode = 'ON_CALL' THEN
                CASE
                    WHEN SUM(CAST(hours_worked AS FLOAT))>='1.0' THEN CAST(hours_worked AS float)
                    ELSE '0.0' END
            ELSE '0.0' END AS worked_hour,

       CASE
            WHEN punch_in_time::TIMESTAMP::TIME BETWEEN '5:00' and '11:00' THEN 'Morning'
            WHEN punch_in_time::TIMESTAMP::TIME BETWEEN '12:00' and '22:00' THEN 'Evening'
            WHEN punch_in_time::TIMESTAMP::TIME BETWEEN '23:00' and '4:30' THEN 'Night'
            ELSE 'NULL' END AS shift_type,

       MIN(punch_in_time::TIMESTAMP::TIME) AS shift_start_time,

       MAX(punch_out_time::TIMESTAMP::TIME) AS shift_END_time,

       CASE
            WHEN paycode = 'WRK' OR paycode = 'CHARGE' OR paycode = 'ON_CALL' THEN
                CASE
                     WHEN SUM(CAST(hours_worked AS FLOAT))>='1.0' THEN 'Present'
                     ELSE 'Absent' END
            ELSE 'Absent' END AS attendance,

       paycode AS work_code,

       CASE
            WHEN paycode = 'BREAK' THEN
                CASE
                    WHEN SUM(CAST(hours_worked AS FLOAT))>'0.0' THEN 'Yes'
                    ELSE 'No' END
            ELSE 'No' END AS has_taken_break,

       CASE
            WHEN paycode = 'BREAK' THEN SUM(CAST(hours_worked AS FLOAT))
            ELSE '0' END AS break_hour,

       CASE
            WHEN paycode = 'CHARGE' THEN
                 CASE
                    WHEN SUM(CAST(hours_worked AS FLOAT))>'0.0' THEN 'Yes'
                    ELSE 'No' END
            ELSE 'NO' END AS was_charge,

       CASE
            WHEN paycode = 'CHARGE' THEN SUM(CAST(hours_worked AS FLOAT))
            ELSE '0.0' END AS charge_hour,

       CASE
            WHEN paycode = 'ON_CALL' THEN
                CASE
                    WHEN SUM(CAST(hours_worked AS FLOAT))>'0.0' THEN 'Yes'
                    ELSE 'No' END
            ELSE 'No' END AS was_on_call,

       CASE
            WHEN paycode = 'ON_CALL' THEN SUM(CAST(hours_worked AS FLOAT))
            ELSE '0.0' END AS call_hour,

       CASE
           WHEN to_char(CAST(punch_apply_date AS DATE), 'day') = 'sunday ' OR to_char(CAST(punch_apply_date AS DATE), 'day') = 'saturday '
           THEN 'Weekend' ELSE 'Workday' END AS is_weekend,

       CASE
            WHEN paycode = 'Absent' THEN COUNT(*)
            ELSE '0' END AS num_teammates_absent

FROM timesheet.raw_timestamp
JOIN timesheet.dim_department d ON timesheet.raw_timestamp.cost_center = d.department_id
GROUP BY employee_id, d.id, punch_in_time, punch_out_time, punch_apply_date, paycode,  hours_worked, paycode
;
