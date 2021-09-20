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
