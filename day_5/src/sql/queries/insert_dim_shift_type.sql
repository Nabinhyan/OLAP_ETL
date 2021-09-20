INSERT INTO timesheet.dim_shift_type(name)
SELECT
    DISTINCT
            shift_type
FROM timesheet.extracted_timesheet;