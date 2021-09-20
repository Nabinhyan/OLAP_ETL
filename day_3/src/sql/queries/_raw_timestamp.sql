INSERT INTO etl.raw_timestamp("employee_id","cost_center","punch_in_time","punch_out_time","punch_apply_date","hours_worked","paycode")
VALUES
(%s,%s,%s,%s,%s,%s,%s);

SELECT * FROM etl.raw_timestamp;

SELECT * FROM etl.archive_raw_timestamp;

INSERT INTO etl.archive_raw_timestamp("employee_id","cost_center","punch_in_time","punch_out_time","punch_apply_date",
"hours_worked","paycode","filename")
VALUES
(%s,%s,%s,%s,%s,%s,%s,%s);

DELETE FROM etl.archive_raw_timestamp;