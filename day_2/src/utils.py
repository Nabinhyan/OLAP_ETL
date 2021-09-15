import psycopg2
import json
import pandas as pd
from sqlalchemy import create_engine, engine

def json_file_ins(path):
    data = pd.read_json(path)
    engine = create_engine('postgresql://postgres: @localhost: 5432/Leapfrog')
    data.to_sql('json_raw_employees', engine)
    
def connect():
    return psycopg2.connect(host = "localhost",
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

# def json_file(path):
#     with open(path, 'r', encoding= 'utf-8') as read_json:
#         data = json.load(read_json)
#         json_string = json.dumps(data)
        
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
        
        
# from src.utils import *
