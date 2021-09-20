CREATE TABLE IF NOT EXISTS customer.fact_customer(
    customer_id SERIAL PRIMARY KEY,
    user_name VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    country INT,
    town INT,
    active INT,
    FOREIGN KEY(country) REFERENCES customer.country(country_id),
    FOREIGN KEY (town) REFERENCES customer.town(town_id),
    FOREIGN KEY (active) REFERENCES customer.active_status(active_id)
);
