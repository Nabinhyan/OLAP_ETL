CREATE TABLE IF NOT EXISTS product.fact_product(
    id SERIAL PRIMARY KEY,
    product_id INT,
    selling_price FLOAT,
    mrp FLOAT,
    brand INT,
    category INT,
    tax_percent FLOAT,
    active INT,
    created_by INT,
    FOREIGN KEY (product_id) REFERENCES product.raw_product_dump(product_id),
    FOREIGN KEY (brand) REFERENCES product.extracted_brand_name(id),
    FOREIGN KEY (category) REFERENCES product.extracted_category_name(id),
    FOREIGN KEY (created_by) REFERENCES product.extracted_created_by(id),
    FOREIGN KEY (active) REFERENCES product.extracted_status(id)
);