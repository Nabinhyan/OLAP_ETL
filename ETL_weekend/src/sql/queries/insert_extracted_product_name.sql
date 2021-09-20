INSERT INTO product.extracted_product_name(product_name)
SELECT
    DISTINCT
             INITCAP(product_name)
FROM product.raw_product_dump;