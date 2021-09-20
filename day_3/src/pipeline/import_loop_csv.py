from src.utils import *

if __name__ == '__main__':
    conn = connect()
    cursor = conn.cursor()
    delete_sql = sql_path('day_2\src\sql\queries\delete_raw_timestamp.sql')
    cursor.execute(delete_sql)
    conn.commit()
    cursor.close()
    conn.close()
    extract_raw_employee('day_2\data\_timestamp\_timesheet_2021_05_23.csv', 'day_2\src\sql\queries\loop_raw_timestamp.sql')
    extract_raw_employee('day_2\data\_timestamp\_timesheet_2021_06_23.csv', 'day_2\src\sql\queries\loop_raw_timestamp.sql')
    extract_raw_employee('day_2\data\_timestamp\_timesheet_2021_07_24.csv', 'day_2\src\sql\queries\loop_raw_timestamp.sql')
