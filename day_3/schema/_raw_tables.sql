CREATE SCHEMA IF NOT EXISTS etl;

CREATE TABLE IF NOT EXISTS etl.raw_employee(
        employee_id VARCHAR(200),
        first_name VARCHAR(200),
        last_name VARCHAR(200),
        department_id VARCHAR(200),
        department_name VARCHAR(200),
        manager_employee_id VARCHAR(200),
        employee_role VARCHAR(200),
        salary VARCHAR(200),
        hire_date VARCHAR(200),
        terminated_date VARCHAR(200),
        terminated_reason VARCHAR(200),
        dob VARCHAR(200),
        fte VARCHAR(200),
        location VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS etl.raw_timestamp(
    employee_id VARCHAR(200),
    cost_center VARCHAR(200),
    punch_in_time VARCHAR(200),
    punch_out_time VARCHAR(200),
    punch_apply_date VARCHAR(200),
    hours_worked VARCHAR(200),
    paycode VARCHAR(200)

);

CREATE TABLE IF NOT EXISTS etl.users (
  id SERIAL,
  username VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  password TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS etl.administrators (
  id SERIAL,
  username VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  password TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS etl.categories (
  id SERIAL,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS etl.products (
  id SERIAL,
  name VARCHAR(45) NOT NULL,
  price DOUBLE PRECISION NOT NULL,
  quantity INT NULL,
  image VARCHAR(200) NULL,
  image_large VARCHAR(200) NULL,
  category_id INT NULL,
  PRIMARY KEY (id),
  CONSTRAINT category_fk FOREIGN KEY (category_id) REFERENCES etl.categories (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS etl.sales (
  id SERIAL,
  user_id INT NOT NULL,
  product_id INT NOT NULL,
  price DOUBLE PRECISION NOT NULL,
  quantity INT NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES etl.users (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT product_fk FOREIGN KEY (product_id) REFERENCES etl.products (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);