SELECT *
FROM etl.temporary_punch_detail,
     etl.temporary_hours_worked,
     etl.temporary_attendance,
     etl.temporary_break_taken,
     etl.temporary_break_hour,
     etl.temporary_charge_status,
     etl.temporary_charge_hour,
     etl.temporary_on_call_status,
     etl.temporary_on_call_hour,
     etl.temporary_num_teammates_absent

;