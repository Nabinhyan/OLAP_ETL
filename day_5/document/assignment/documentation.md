## Setting up the setup for managing the relative path
Initially for  importing the packages using relative path I have install the setup.py file using following command
    pip install -e .
This will find all the packages and setup it to the project

## Establishing Connection:
For establishing the connection with postgresql database we used the psycopg2 package. 

## Utils package
The utils package includes the codes which might get repeatedly called during the execution of program. It includes:
### connect() ###
    This function will connect to the postgres database.
### sql_path(path)
    This fuction will read the sql from the sql path and return it to the program.

## Creating the schema:
Here I have maintained one table for each dimension and fact tables. Also I have maintained the tabel to store the cleaned data. 
- raw_employee :: stores the raw details of employee
- raw_timestamp :: sotres the raw details of timesheets
- dim_department :: stores the details of department
- dim_manager :: stores the details of manager
- dim_role :: stores the details of role
- dim_shift_type :: detect the type of shift based on time period and stores the details of shift  which are futher cleaned from extracted_timesheet
- dim_status :: stores the detail of active status of employee
- employee :: stores the cleaned detail of employee
- extracted_timesheet :: stores the cleaned details of timesheet
- fact_timesheet :: stores the facts of timesheet
- fact_employee :: stores the facts of employee

Before transformation of the data to reqired data type, it was previously set to varchar. This is because, we have no any idea that what type of data will the client send. so all the data are stored to varchar and changed according to our necessicity while extracting and transforming the data form the extracted timesheet table I have followed following query.
```
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
```

    while creating worked_hour I have considered that if the sum of worked_hour with paycode 'CHARGE' and 'WKR' is greater than 1 is marked as work hour. While determining the shift, I have taken the time bench mark of 5 am to 11 am as morning shift, 12 pm to 10 pm as evening shift, and 11 pm to 4:30 am is morning shift. Similar to work hour, if the work hour is greater than or equal to 1 hr, then the attendance is marked to present else it is marked to absent.