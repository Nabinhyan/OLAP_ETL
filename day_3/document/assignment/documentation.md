## Schema ##
Here I have created three schema named as ***_archive_employee_timestamp.sql, _raw_tables.sql, extracted_data.sql*** <br>
The ***_archive_employee_timestamp.sql*** includes the creation of archive tables for the ***_raw_employee and _raw_timestamp*** table.The archieve table includes all the same attributes as in old table. But it also includes the one more attribute named to ***filename*** which will store the file name from which the data has been stores.<br>
The ***_raw_tables.sql*** includes the queries to create the tables like ***raw_employee, raw_timestamp, users, administrators, categories, products, sales*** as required by the problem statement. <br>
The ***extracted_data.sql*** includes the queries to create the ***extracted_data*** which stores the data like **data_id, user_id, username, product_id, product_name, category_id, category_name, current_price, sold_price, sold_quantity, remaining_quantity, sales_date***. All these data are extracted from the tables in ***_raw_tables.sql***.

## Utils package ##
The Utils package includes the function to connect the postgres database, to extract the sql queries from sql files, and to extract the data from csv file and store it to database.
#### Connecting database ###
```
def connect():
    return  psycopg2.connect(host = "localhost",
    database = "Leapfrog",
    user = "postgres",
    password = " ",
    port = 5432
    )
```
#### Extracting sql queries form sql file ####
```
def sql_path(path):
    with open(path, 'r') as create_schema:
        sql = create_schema.readlines()
        sql = ' '.join(sql)
    return sql
```
Here the `join` function will join the lines extracted in list format and return as single query.

#### extracted_data_insert.sql ####
The new table named to  ***extracted_data*** needs the data from ***users, products, categories, sales*** tables. but, Here as per the requirement, the ***sales_data*** need to be in date fromat but we have the ***timestamp*** format data. Thus we used `updated_at::TIMESTAMP::DATE AS sold_date` to extract the date from the timestamp datatype.
```
CREATE TABLE IF NOT EXISTS extracted_schema.extracted_data(
	data_id SERIAL,
	user_id INT,
	username VARCHAR(45),
	product_id INT,
	product_name VARCHAR(45),
	category_id INT,
	category_name VARCHAR(45),
	current_price DOUBLE PRECISION,
	sold_price DOUBLE PRECISION,
	sold_quantity INT NULL,
	remaining_quantity INT, 
	sales_date DATE,
	PRIMARY KEY(data_id)
);
```

#### Extracting csv file and storing data to database ####
```
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
```
To import and insert data from csv file to database, I have previously deleted the pre-existing data. Then I have read the data in loop. The `extract_raw_employee(filepath, sqlpath)` of utils.py will connect the database, read the data from csv file and pass the data to sql query file named loop_raw_employee.sql.

## raw_to_extracted.py ##
This file will insert the raw data to the database table. The data has been defined in the `sql/queries/_raw_insert_into_tables.sql` file. Also the `exec_sql_files(path)` function will read the path of sql file and split to list of queries by splitting the query files by `;` if necessary. Then the queries in the file will get executed sequentially.
```
def exec_sql_files(path):    
    conn = connect() 
    cursor = conn.cursor()
    sql = sql_path(path)
    sql = re.split(r'[;]', sql) #splitting the queries by ;
    for query in sql:
        if query.strip():
            print(query)
            cursor.execute(query)
    conn.commit()
    conn.close()
```
## archive_create.py ##
This file will create the archive table of existing table. This will append the data to a ***archive_raw_timestamp / archive_raw_employee*** table if the new data is added. This file includes ***add_filename(row, filename)*** which will add the filename to each row of the raw table and return new tuple.<br> 
```
def add_filename(row, filename):
    list_row = list(row)
    list_row.append(filename[-1])
    new_row = tuple(list_row)
    return new_row
```
The ***archive_call(filepath, sqlpath)*** Also it will delete the data from ***archive_raw_timestamp / archive_raw_employee*** if the file name from which the data has been passed is same as previously used file to store data and store the data from new file instead along with the new file name. 
