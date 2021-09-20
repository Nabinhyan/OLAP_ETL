CREATE TABLE IF NOT EXISTS product.product(
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255),
    mrp FLOAT,
    brand VARCHAR(255),
    category VARCHAR(255),
    active VARCHAR(255),
    created_by VARCHAR(255),
    created_date DATE
);