INSERT INTO etl.raw_timestamp("employee_id","cost_center","punch_in_time","punch_out_time","punch_apply_date","hours_worked","paycode")
VALUES
(%s,%s,%s,%s,%s,%s,%s);