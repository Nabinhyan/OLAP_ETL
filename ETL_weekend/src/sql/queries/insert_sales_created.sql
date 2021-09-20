INSERT INTO sales.extracted_created_by(name)
SELECT DISTINCT INITCAP(created_by)
FROM sales.raw_sales_dump;