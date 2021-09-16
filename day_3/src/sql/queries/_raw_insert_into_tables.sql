INSERT INTO etl.users(username, email, password)
VALUES ('Tushar', 'tushar@gmail.com', 'encpsswrd'),
  ('Kabir', 'kabir_2011@yahoo.com', 'kbr_2011'),
  ('Kundan', 'kd1998@gmail.com', '98dan_pass'),
  ('Praveen', 'coolprv@yahoo.com', 'veen_strg');

INSERT INTO etl.administrators (username, email, password)
VALUES ('admin', 'admin@admin.com', 'admin@123'),
  ('ram', 'ram@admin.com', 'ram@1010'),
  ('rani', 'rani@admin.com', 'strgpsswrd');

INSERT INTO etl.categories (name)
VALUES ('Clothing'),
  ('Electornics'),
  ('Home Appliance');

INSERT INTO etl.products(name, price, quantity, category_id)
VALUES ('Red T-Shirt', 500, 1000, 1),
  ('Green T-Shirt', 550, 800, 1),
  ('Jeans', 2000, 1500, 1),
  ('IPhone 11', 90000, 100, 2),
  ('Sony TV', 100000, 10, 2),
  ('Toaster', 3000, 251, 3),
  ('Vaccum Cleaner', 20000, 505, 3);

INSERT INTO etl.sales(user_id, product_id, price, quantity)
VALUES (1, 2, 550, 1),
  (1, 4, 90000, 1),
  (1, 6, 3500, 1),
  (2, 7, 20000, 2),
  (3, 3, 1800, 1),
  (3, 5, 100000, 2),
  (2, 1, 570, 3);

