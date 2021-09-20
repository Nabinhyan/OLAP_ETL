INSERT INTO customer.country(country_name)
SELECT
    DISTINCT
             country
FROM customer.extracted_customer;