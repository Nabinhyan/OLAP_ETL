from typing import final
from src.utils import *
import re
import os

def exec_sql_files(path):    
    conn = connect() 
    cursor = conn.cursor()
    sql = sql_path(path)
    sql = re.split(r'[;]', sql)
    for query in sql:
        if query.strip():
            print(query)
            cursor.execute(query)
    conn.commit()
    conn.close()
   
if __name__ == '__main__':
    try:
        exec_sql_files('day_3\schema\_raw_tables.sql')
        exec_sql_files('day_3\src\sql\queries\_raw_insert_into_tables.sql')
        exec_sql_files('day_3\schema\extracted_data.sql')
        exec_sql_files('day_3\src\sql\queries\extracted_data_insert.sql')
        
    except Exception as e:
        print(e)
        
    finally:
        print("Sql file Execution completed!")

        
