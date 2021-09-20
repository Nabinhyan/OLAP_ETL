INSERT INTO timesheet.fact_timesheet
SELECT
       e.employee_id,
       et.work_date,
       et.department_id as department_id,
       et.hours_worked AS hours_worked,
       st.id AS shift_type_id,
       et.shift_start_time AS punch_in_time,
       et.shift_end_time AS punch_out_time,
       et.attendance as attendance,
       et.work_code as work_code,
       et.has_taken_break as has_taken_break,
       et.break_hour AS break_hour,
       et.was_charge AS was_charge,
       et.charge_hour AS charge_hour,
       et.was_on_call AS was_on_call,
       et.call_hour AS on_call_hour,
       et.work_day AS is_weekend,
       et.num_teammates_absent AS num_teammates_absent
from timesheet.extracted_timesheet et INNER JOIN timesheet.fact_employee e on e.client_employee_id = et.employee_id
    INNER JOIN timesheet.dim_shift_type st ON et.shift_type = st.name;