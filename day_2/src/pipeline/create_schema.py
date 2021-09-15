from src.utils import *
def create_schema():
    table_list = ['day_2\schema\create_schema.sql', 'day_2\schema\create_raw_employee.sql', 'day_2\schema\create_raw_timestamp.sql']
    conn = connect()
    cursor = conn.cursor()
    for x in table_list:
        sql =sql_path(x)
        cursor.execute(sql)
    conn.commit()
    conn.close()