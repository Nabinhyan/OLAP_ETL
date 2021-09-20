INSERT INTO customer.extracted_customer(user_name, first_name, last_name, country, town, active)
SELECT
       user_name,
       INITCAP(first_name) AS first_name,
       INITCAP(last_name) AS last_name,
       INITCAP(country) AS country,
       INITCAP(town) AS town,
       INITCAP(active) AS active
FROM customer.raw_customer_dump;