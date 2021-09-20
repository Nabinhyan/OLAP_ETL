INSERT INTO product.extracted_status(status)
SELECT
    DISTINCT
             INITCAP(active)
FROM product.raw_product_dump;