INSERT INTO product.extracted_created_by(created_by_name, created_date)
SELECT
    DISTINCT
             INITCAP(created_by),
             CAST(created_date::TIMESTAMP::DATE AS DATE) AS created_date
FROM product.raw_product_dump;