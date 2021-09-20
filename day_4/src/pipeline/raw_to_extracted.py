from typing import final
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
   
if __name__ == '__main__':
    try:
        exec_sql_files('day_4\schema\create_temporary_tables.sql')
        exec_sql_files('day_4\src\sql\queries\_raw_insert_into_tables.sql')
        exec_sql_files('day_4\src\sql\queries\extract_data.sql')
        
    except Exception as e:
        print(e)
        
    finally:
        print("Sql file Execution completed!")

    
    
    