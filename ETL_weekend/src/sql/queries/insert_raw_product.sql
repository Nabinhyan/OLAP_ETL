COPY product.raw_product_dump
FROM 'D:\leapfrog\Leapfrog_Database_note\OLAP_ETL\ETL_weekend\data\product_dump .csv'
DELIMITER ','
CSV HEADER;