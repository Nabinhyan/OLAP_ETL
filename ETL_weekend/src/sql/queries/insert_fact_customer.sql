INSERT INTO customer.fact_customer(user_name, first_name, last_name, country, town, active)
SELECT
       e.user_name,
       e.first_name,
       e.last_name,
       c.country_id,
       t.town_id,
       a.active_id
FROM customer.extracted_customer e INNER JOIN
    customer.country c ON e.country = c.country_name
    INNER JOIN customer.town t ON e.town = t.town_name
    INNER JOIN customer.active_status a ON  e.active = a.status
;
