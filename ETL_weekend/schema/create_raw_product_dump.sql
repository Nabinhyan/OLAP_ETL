CREATE TABLE IF NOT EXISTS product.raw_product_dump(
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255),
    description VARCHAR(255),
    price VARCHAR(255),
    mrp VARCHAR(255),
    pieces_per_case VARCHAR(255),
    weight_per_piece VARCHAR(255),
    umo VARCHAR(255),
    brand VARCHAR(255),
    category VARCHAR(255),
    tax_percent VARCHAR(255),
    active VARCHAR(255),
    created_by VARCHAR(255),
    created_date VARCHAR(255),
    updated_by VARCHAR(255),
    updated_date VARCHAR(255)
);