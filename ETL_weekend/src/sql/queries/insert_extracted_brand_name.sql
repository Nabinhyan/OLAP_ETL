INSERT INTO product.extracted_brand_name(brand_name)
SELECT
    DISTINCT
             INITCAP(brand)
FROM product.raw_product_dump;