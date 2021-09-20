INSERT INTO sales.fact_sales(product_id, customer_id, bill_date, qty, town_id, selling_rate, gross_price, tax_percent, tax_amt, discount_pc, discount_amt, net_bill_amt, total_profit)
SELECT es.product_id,
       es.customer_id,
       es.bill_date,
       es.qty,
       town.town_id,
       es.price AS selling_rate,
       es.gross_price AS gross_selling_price,
       fp.tax_percent,
       tax_amt,
       es.discount_pc,
       es.discount_amt,
       es.net_bill_amt,
       CAST(((fp.mrp - es.price)*es.qty) AS FLOAT) AS total_profit
FROM sales.extracted_sales es
    LEFT JOIN product.fact_product fp ON es.product_id = fp.product_id
    LEFT JOIN customer.town town ON INITCAP(es.bill_location) = INITCAP(town.town_name)
order by 1;
