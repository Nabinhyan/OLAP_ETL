INSERT INTO product.fact_product(product_id, selling_price, mrp, brand, category, tax_percent, active, created_by)
SELECT
    CAST(rpd.product_id AS INT) AS product_id,
    CAST(rpd.price AS FLOAT) AS price,
    CAST(rpd.mrp AS FLOAT) AS mrp,
    ebn.id AS brand_id,
    ecn.id as category_name_id,
    CAST(rpd.tax_percent AS FLOAT) AS tax_percent,
    status.id AS active_status_id,
    ecb.id AS created_by_id
FROM product.raw_product_dump rpd
    LEFT JOIN product.extracted_brand_name ebn ON INITCAP(rpd.brand) = INITCAP(ebn.brand_name)
    LEFT JOIN product.extracted_product_name epn ON INITCAP(epn.product_name) = INITCAP(rpd.product_name)
    LEFT JOIN product.extracted_category_name ecn ON INITCAP(rpd.category) = INITCAP(ecn.category_name)
    LEFT JOIN product.extracted_status status ON INITCAP(rpd.active) = INITCAP(status.status)
    LEFT JOIN product.extracted_created_by ecb ON INITCAP(rpd.created_by) = INITCAP(ecb.created_by_name)
;