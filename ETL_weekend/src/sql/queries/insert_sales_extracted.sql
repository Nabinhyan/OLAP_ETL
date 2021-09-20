INSERT INTO sales.extracted_sales(bill_date, product_id, customer_id, qty, bill_location, price, gross_price, tax_amt, discount_pc, discount_amt, net_bill_amt, created_by)
SELECT
    bill_date,
    CAST(product_id AS INT) AS product_id,
    CAST(customer AS INT) AS customer_id,
    CAST(qty AS INT) AS qty,
    bill_location,
    CAST(price AS FLOAT) AS price,
    CAST(gross_price AS FLOAT) AS gross_price,
    CAST(tax_amt AS FLOAT) AS tax_amt,
    CAST(discount_pc AS FLOAT) discount_pc,
    CAST(discount_amt AS FLOAT) discount_amt,
    CAST(net_bill_amt AS FLOAT) AS net_bill_amt,
    created_by
FROM sales.raw_sales_dump 
GROUP BY customer,
        product_id,
        qty,
        price,
        gross_price,
        tax_amt,
        discount_pc,
        discount_amt,
        net_bill_amt,
        bill_location,
        created_by,
        bill_date
;
