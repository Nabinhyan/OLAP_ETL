from src.utils import *
import re
import os

###function to execute the sql query in .sql files
def exec_sql_files(path):    
    conn = connect() 
    cursor = conn.cursor()
    sql = sql_path(path)
    cursor.execute(sql)
    conn.commit()
    conn.close()

###function to delete the pre-existing data    
def del_table_date(query):
    conn = connect()
    cur = conn.cursor()
    cur.execute(query)
    conn.commit()
    conn.close()
    
###function to insert data in table of customer schema
def insert_raw_customer(path):
    del_table_date('''DELETE FROM customer.raw_customer_dump''')
    exec_sql_files(path)
    
def insert_town(path):
    del_table_date('''DELETE FROM customer.town''')
    exec_sql_files(path)
    
def insert_extracted_customer(path):
    del_table_date('''DELETE FROM customer.extracted_customer''')
    exec_sql_files(path)
    
def insert_country(path):
    del_table_date('''DELETE FROM customer.country''')
    exec_sql_files(path)
    
def insert_active_status(path):
    del_table_date('''DELETE FROM customer.active_status''')
    exec_sql_files(path)

def insert_fact_customer(path):
    del_table_date('''DELETE FROM customer.fact_customer''')
    exec_sql_files(path)
    
###function to insert data in table of product schema
def insert_raw_product(path):
    del_table_date('''DELETE FROM product.raw_product_dump''')
    exec_sql_files(path)
    
def insert_product_name(path):
    del_table_date('''DELETE FROM product.extracted_product_name''')
    exec_sql_files(path)
    
def insert_brand_name(path):
    del_table_date('''DELETE FROM product.extracted_brand_name''')
    exec_sql_files(path)
    
def insert_category_name(path):
    del_table_date('''DELETE FROM product.extracted_category_name''')
    exec_sql_files(path)
    
def insert_status(path):
    del_table_date('''DELETE FROM product.extracted_status''')
    exec_sql_files(path)
    
def insert_created_by(path):
    del_table_date('''DELETE FROM product.extracted_created_by''')
    exec_sql_files(path)
    
def insert_fact_product(path):
    del_table_date('''DELETE FROM product.fact_product''')
    exec_sql_files(path)
    
###function to insert data in table of sales schema
def insert_sales_raw(path):
    del_table_date('''DELETE FROM sales.raw_sales_dump''')
    exec_sql_files(path)   
    
def insert_sales_created(path):
    del_table_date('''DELETE FROM sales.extracted_created_by''')
    exec_sql_files(path)   
    
def insert_sales_extracted(path):
    del_table_date('''DELETE FROM sales.extracted_sales''')
    exec_sql_files(path) 

def insert_sales_fact(path):
    del_table_date('''DELETE FROM sales.fact_sales''')
    exec_sql_files(path)  
    
if __name__ == '__main__':
    try:
        ###creating schema for each datasheet
        create_customer_schema = '''CREATE SCHEMA IF NOT EXISTS customer;'''
        create_product_schema = '''CREATE SCHEMA IF NOT EXISTS product;'''
        create_sales_schema = '''CREATE SCHEMA IF NOT EXISTS sales;'''
        conn = connect()
        cur = conn.cursor()
        cur.execute(create_customer_schema)
        conn.commit()
        cur.execute(create_product_schema)
        conn.commit()
        cur.execute(create_sales_schema)
        conn.commit()
        conn.close()
        
        ###creating tables for customer schema
        create_customer_queries = ['ETL_weekend\schema\create_raw_customer.sql',
                          'ETL_weekend\schema\create_extracted_customer.sql',
                          'ETL_weekend\schema\create_active_status.sql',
                          'ETL_weekend\schema\create_country.sql',
                          'ETL_weekend\schema\create_town.sql',
                          'ETL_weekend\schema\create_fact_customer.sql'
                          ]
        for query in create_customer_queries:
            exec_sql_files(query)
        
        ###creating tables for product schema
        create_product_queries = ['ETL_weekend\schema\create_raw_product_dump.sql',
                                 'ETL_weekend\schema\create_extracted_product_name.sql',
                                 'ETL_weekend\schema\create_extracted_brand_name.sql',
                                 'ETL_weekend\schema\create_extracted_category_name.sql',
                                 'ETL_weekend\schema\create_extracted_status.sql',
                                 'ETL_weekend\schema\create_extracted_created_by.sql',
                                 'ETL_weekend\schema\create_fact_product.sql'
                                 ]
        for query in create_product_queries:
            exec_sql_files(query)
        
        ###creating tables for sales schema
        create_sales_queries = ['ETL_weekend\schema\create_raw_sales.sql',
                                'ETL_weekend\schema\create_sales_created.sql',
                                'ETL_weekend\schema\create_sales_extracted.sql',
                                'ETL_weekend\schema\create_fact_sales.sql'
                                ]
        for query in create_sales_queries:
            exec_sql_files(query)
        
        ###Executing insertition ETL for customer schema   
        insert_raw_customer('ETL_weekend\src\sql\queries\insert_raw_customer.sql')
        insert_town('ETL_weekend\src\sql\queries\insert_town.sql')
        insert_extracted_customer('ETL_weekend\src\sql\queries\insert_extracted_customer.sql')
        insert_country('ETL_weekend\src\sql\queries\insert_country.sql')
        insert_active_status('ETL_weekend\src\sql\queries\insert_active_status.sql')
        insert_fact_customer('ETL_weekend\src\sql\queries\insert_fact_customer.sql') 
         
        ###Executing insertition ETL for product schema        
        insert_raw_product('ETL_weekend\src\sql\queries\insert_raw_product.sql')
        insert_product_name('ETL_weekend\src\sql\queries\insert_extracted_product_name.sql')
        insert_brand_name('ETL_weekend\src\sql\queries\insert_extracted_brand_name.sql')
        insert_category_name('ETL_weekend\src\sql\queries\insert_extracted_category_name.sql')
        insert_status('ETL_weekend\src\sql\queries\insert_extracted_status.sql')
        insert_created_by('ETL_weekend\src\sql\queries\insert_extracted_created_by.sql')
        insert_fact_product('ETL_weekend\src\sql\queries\insert_fact_product.sql')
        
        ###Executing insertition ETL for sales schema   
        insert_sales_raw('ETL_weekend\src\sql\queries\insert_sales_raw.sql')
        insert_sales_created('ETL_weekend\src\sql\queries\insert_sales_created.sql')
        insert_sales_extracted('ETL_weekend\src\sql\queries\insert_sales_extracted.sql')
        insert_sales_fact('ETL_weekend\src\sql\queries\insert_sales_fact.sql')
        
    except Exception as e:
        print(e)
        
    finally:
        print("Sql file Execution completed!")
        
