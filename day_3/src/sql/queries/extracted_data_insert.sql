INSERT INTO extracted_schema.extracted_data("user_id","username","product_id","product_name","category_id",
											"category_name","current_price","sold_price","sold_quantity",
											"remaining_quantity","sales_date")
                                            SELECT u.id AS user_id, u.username AS username, pro.id AS product_id, 
                                            pro.name AS product_name, cat.id AS category_id, cat.name AS category_name,
                                            pro.price AS current_price, s.price AS sold_price, s.quantity AS sold_quantity,
                                            (pro.quantity - s.quantity) AS remaining_quantity, s.updated_at::TIMESTAMP::DATE AS sold_date
                                            FROM
                                            (
                                                (
                                                    (
                                                        etl.users u LEFT JOIN etl.sales s ON u.id = s.user_id
                                                    )
                                                    LEFT JOIN etl.products pro ON s.product_id = pro.id
                                                )
                                                LEFT JOIN etl.categories cat ON pro.category_id = cat.id
                                            );