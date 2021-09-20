CREATE TABLE IF NOT EXISTS sales.fact_sales(
    id SERIAL PRIMARY KEY,
    product_id INT,
    customer_id INT,
    bill_date VARCHAR(255),
    qty INT,
    town_id INT,
    selling_rate FLOAT,
    gross_price FLOAT,
    tax_percent FLOAT,
    tax_amt FLOAT,
    discount_pc FLOAT,
    discount_amt FLOAT,
    net_bill_amt FLOAT,
    total_profit FLOAT
);