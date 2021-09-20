from src.utils import *
import re
import os

def exec_sql_files(path):    
    conn = connect() 
    cursor = conn.cursor()
    sql = sql_path(path)
    cursor.execute(sql)
    conn.commit()
    conn.close()
    
def del_table_date(query):
    conn = connect()
    cur = conn.cursor()
    cur.execute(query)
    conn.commit()
    conn.close()
    
def insert_raw_employee(path):
    del_table_date('''DELETE FROM timesheet.raw_employee''')
    exec_sql_files(path)

def insert_raw_timesheet(path):
    del_table_date('''DELETE FROM timesheet.raw_timestamp''')
    exec_sql_files(path)
    
def insert_extracted_timesheet(path):
    del_table_date('''DELETE FROM timesheet.extracted_timesheet''')
    exec_sql_files(path)
    
def insert_dim_department(path):
    del_table_date('''DELETE FROM timesheet.dim_department''')
    exec_sql_files(path)
    
def insert_employee(path):
    del_table_date('''DELETE FROM timesheet.employee''')
    exec_sql_files(path)
    
def insert_dim_manager(path):
    del_table_date('''DELETE FROM timesheet.dim_manager''')
    exec_sql_files(path)
    
def insert_dim_role(path):
    del_table_date('''DELETE FROM timesheet.dim_role''')
    exec_sql_files(path)
    
def insert_dim_shift_type(path):
    del_table_date('''DELETE FROM timesheet.dim_shift_type''')
    exec_sql_files(path)
    
def insert_dim_status(path):
    del_table_date('''DELETE FROM timesheet.dim_status''')
    exec_sql_files(path)
    
def insert_fact_employee(path):
    del_table_date('''DELETE FROM timesheet.fact_employee''')
    exec_sql_files(path)

def insert_fact_timesheet(path):
    del_table_date('''DELETE FROM timesheet.fact_timesheet''')
    exec_sql_files(path)
   
if __name__ == '__main__':
    try:
        create_schema = '''CREATE SCHEMA IF NOT EXISTS timesheet;'''
        conn = connect()
        cur = conn.cursor()
        cur.execute(create_schema)
        conn.commit()
        conn.close()
        create_queries = ['day_5\schema\create_raw_employee.sql',
                          'day_5\schema\create_raw_timesheet.sql',
                          'day_5\schema\create_extracted_timesheet.sql',
                          'day_5\schema\create_dim_department.sql',
                          'day_5\schema\create_dim_employee.sql',
                          'day_5\schema\create_dim_manager.sql',
                          'day_5\schema\create_dim_role.sql',
                          'day_5\schema\create_dim_shift_type.sql',
                          'day_5\schema\create_dim_status.sql',
                          'day_5\schema\create_fact_employee.sql',
                          'day_5\schema\create_fact_timesheet.sql'
                          ]
        for query in create_queries:
            exec_sql_files(query)
        
        insert_raw_timesheet('day_5\src\sql\queries\insert_raw_timesheet.sql')
        insert_raw_employee('day_5\src\sql\queries\insert_raw_employee.sql')
        insert_extracted_timesheet('day_5\src\sql\queries\insert_extracted_timesheet.sql')
        insert_dim_department('day_5\src\sql\queries\insert_dim_department.sql')
        insert_employee('day_5\src\sql\queries\insert_employee.sql')
        insert_dim_manager('day_5\src\sql\queries\insert_dim_manager.sql')
        insert_dim_role('day_5\src\sql\queries\insert_dim_role.sql')
        insert_dim_shift_type('day_5\src\sql\queries\insert_dim_shift_type.sql')
        insert_dim_status('day_5\src\sql\queries\insert_dim_statu.sql')
        insert_fact_employee('day_5\src\sql\queries\insert_fact_employee.sql')
        insert_fact_timesheet('day_5\src\sql\queries\insert_fact_timesheet.sql')        

        
    except Exception as e:
        print(e)
        
    finally:
        print("Sql file Execution completed!")
    
