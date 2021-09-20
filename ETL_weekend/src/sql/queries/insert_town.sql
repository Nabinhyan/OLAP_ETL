INSERT INTO customer.town(town_name)
SELECT
    DISTINCT
             town
FROM customer.extracted_customer;