from src.utils import *
from create_schema import *
import re

if __name__ == '__main__':
    create_schema()
    conn = connect()
    cursor = conn.cursor()

    delete_sql = sql_path('day_2\src\sql\queries\delete_raw_employees.sql')
    cursor.execute(delete_sql)
    conn.commit()

    sql = sql_path('day_2\src\sql\queries\copy_raw_timestamp.sql')
    sql = re.split(r'[;]', sql)

    for query in sql:
        if query.strip():
            cursor.execute(query)
    conn.commit()
    conn.close()