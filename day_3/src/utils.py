from os import curdir
import psycopg2
    
def connect():
    return  psycopg2.connect(host = "localhost",
    database = "Leapfrog",
    user = "postgres",
    password = " ",
    port = 5432
    )


def sql_path(path):
    with open(path, 'r') as create_schema:
        sql = create_schema.readlines()
        sql = ' '.join(sql)
    return sql

def archive_create(select_query, archive_sql, filename):
    conn = connect()
    cursor = conn.cursor()
    sql_fetch = sql_path(select_query)
    sql_ins = sql_path(archive_sql)
    cursor.execute(sql_fetch)
    data = cursor.fetchall()
    for row in data:
        cursor.execute(sql_ins,(row, filename))
    conn.commit()
    conn.close()

def extract_raw_employee(filepath, sqlpath):
    conn = connect()
    cursor = conn.cursor()
    with open(filepath, 'r') as file:
        i = 0
        for line in file:
            if i == 0:
                i+=1
                continue
            else:
                row = line.strip().split(",")
                sql = sql_path(sqlpath)
                cursor.execute(sql, row)
                i+=1
    conn.commit()
    conn.close()   
    
