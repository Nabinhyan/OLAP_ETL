CREATE TABLE IF NOT EXISTS customer.extracted_customer(
    customer_id SERIAL PRIMARY KEY,
    user_name VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    country VARCHAR(255),
    town VARCHAR(255),
    active VARCHAR(255)
);