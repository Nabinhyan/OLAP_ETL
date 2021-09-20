COPY customer.raw_customer_dump
FROM 'D:\leapfrog\Leapfrog_Database_note\OLAP_ETL\ETL_weekend\data\customer_dump.csv'
DELIMITER ','
CSV HEADER;