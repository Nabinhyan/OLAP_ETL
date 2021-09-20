CREATE SCHEMA extracted_schema;

CREATE TABLE IF NOT EXISTS extracted_schema.extracted_data(
	data_id SERIAL,
	user_id INT,
	username VARCHAR(45),
	product_id INT,
	product_name VARCHAR(45),
	category_id INT,
	category_name VARCHAR(45),
	current_price DOUBLE PRECISION,
	sold_price DOUBLE PRECISION,
	sold_quantity INT NULL,
	remaining_quantity INT, 
	sales_date DATE,
	PRIMARY KEY(data_id)
);