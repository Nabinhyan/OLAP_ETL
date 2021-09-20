INSERT INTO customer.active_status(status)
SELECT
    DISTINCT
             active
FROM customer.extracted_customer;