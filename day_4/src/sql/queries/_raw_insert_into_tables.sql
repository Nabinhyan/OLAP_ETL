DELETE FROM etl.raw_timestamp;

COPY etl.raw_timestamp
FROM 'D:\leapfrog\Leapfrog_Database_note\OLAP_ETL\day_4\data\_timestamp\_timesheet_2021_07_24.csv'
DELIMITER ','
CSV HEADER;

DELETE FROM etl.raw_employee;
COPY etl.raw_employee
FROM 'D:\leapfrog\Leapfrog_Database_note\OLAP_ETL\day_4\data\employee\employee_2021_08_01.csv'
DELIMITER ','
CSV HEADER;