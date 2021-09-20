INSERT INTO product.extracted_category_name(category_name)
SELECT
    DISTINCT
             INITCAP(category)
FROM product.raw_product_dump;