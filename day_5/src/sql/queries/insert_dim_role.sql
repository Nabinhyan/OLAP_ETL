INSERT INTO timesheet.dim_role(name)
SELECT DISTINCT
                role
from timesheet.employee;
