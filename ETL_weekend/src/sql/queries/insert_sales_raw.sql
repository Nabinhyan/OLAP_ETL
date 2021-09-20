COPY sales.raw_sales_dump
FROM 'D:\leapfrog\Leapfrog_Database_note\OLAP_ETL\ETL_weekend\data\sales_dump.csv'
DELIMITER ','
CSV HEADER;