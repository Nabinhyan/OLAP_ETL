CREATE TABLE IF NOT EXISTS sales.extracted_sales(
    id SERIAL PRIMARY KEY,
    bill_date VARCHAR(255),
    product_id INT,
    customer_id INT,
    qty INT,
    bill_location VARCHAR(255),
    price FLOAT,
    gross_price FLOAT,
    tax_amt FLOAT,
    discount_pc FLOAT,
    discount_amt FLOAT,
    net_bill_amt FLOAT,
    created_by VARCHAR(255)
);