CREATE TABLE IF NOT EXISTS product.extracted_created_by(
    id SERIAL PRIMARY KEY,
    created_by_name VARCHAR(255),
    created_date DATE
);