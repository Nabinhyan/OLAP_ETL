from src.utils import *
import re

def add_filename(row, filename):
    list_row = list(row)
    list_row.append(filename[-1])
    new_row = tuple(list_row)
    return new_row
def archive_call(filepath, sqlpath):
    sql = sql_path(sqlpath)
    sql = re.split(r'[;]', sql)
    filename = filepath.split('\\')
    print(filename[-1])
    print(sql[1])
    conn = connect()
    cursor = conn.cursor()
    # cursor.execute(sql[4])
    # conn.commit()
    # cursor.execute(sql[1])
    # data = cursor.fetchall()
    cursor.execute(sql[1])
    data = cursor.fetchall()
    print(sql[2])
    cursor.execute(sql[2])
    old_data = cursor.fetchall()
    for row in old_data:
        if (row[-1] == filename):
            cursor.execute('''DELETE FROM etl.archive_raw_timestamp WHERE filename = filename''')
            conn.commit()
    for row in data:
        new_row = add_filename(row, filename)
        cursor.execute(sql[3], new_row)
        conn.commit()
    conn.close()
    
if __name__ == '__main__':
    filepath = 'day_3\data\_timestamp\_timesheet_2021_05_23.csv'
    sqlpath = 'day_3\src\sql\queries\_raw_timestamp.sql'    
    archive_call(filepath, sqlpath)
    
    
