##Setting up the setup for managing the relative path
Initially for  importing the packages using relative path I have install the setup.py file using following command
    pip install -e .
This will find all the packages and setup it to the project

##Establishing Connection:
For establishing the connection with postgresql database we used the psycopg2 package. 

##utils package
The utils package includes the codes which might get repeatedly called during the execution of program. It includes:
    ###json_file_ins(path)
    This fuction will create engine and store the data from json file to database.
    ###connect()
    This function will connect to the postgres database.
    ###sql_path(path)
    This fuction will read the sql from the sql path and return it to the program.
    ###extract_raw_employee(filepath, sqlpath)
    This function will extract the data from csv file and call the insert query file to insert the data. 

##Creating the schema:
For creating the schema I have maintained the schema folder which includes the sql file to create the schema and tables seperatly. 
The schema will be created if the defined schema name is not exists in the database.
Similarly, for creating the tables I have declared IF NOT EXISTS condition which specifies that the table will be created if there doesnot exists the named table in query. While creating the tables, specifically for this assignment we used the DATATYPE VARCHAR(200). This is because, till the time we have not done any data validation and in future, the datatype of any field may get changed specifically in DATE datatyp. Thus we will used VARCHAR(200).

    While creating the schema, I have passed the list of path of the sql file to be created along with the file name so that we can create the sql file using loop. 

##Importing data from json file:
To import the data from json file, we have used the pandas library to read the json file using read_json() function of pandas. The sqlalchemy package is used to create the database engine. The inbuilt function to_sql() is used to store the json file to postgres database. On using pandas library to store json file data to database, we don't need to create the table previously. The engine itself will create table and store data from json file to database.

##Importing data from xml file:
To import the data from XML files, I have used xml.etree.ElementTree inbuilt package. I have basically used the concept of scrapping. 
Before inserting the data into database I have cleared the previously stored data.
The findall() function of the used package has been used, which will find all the keywords in the xml file. Then I have used the find() to find the attributes of table in xml file. The use of findall('Employee') and find(attribute_name) will find all the data inside the 'Employee' tag and the attribute_name tag. 
The extracted data is passed to sql file import_raw_employee.sql which contains the insert query. 

##Importing data from CSV file using Loop method:
To import and insert data from csv file to database, I have previously deleted the pre-existing data. Then I have read the data in loop. The extract_raw_employee(filepath, sqlpath) of utils.py will connect the database, read the data from csv file and pass the data to sql query file named loop_raw_employee.sql. In this function I have implemented the increment by 1 if the index value is 0. This is to avoid the insertion of header row of csv file to database. I have called the extract_raw_employee(filepath, sqlpath) function for 3 times to store the data of 3 CSV file. Meanwhile it can be done by creating the list of path of CSV file and running it into loop.

##Importing data from CSV file using COPY command:
For the bulk insertion of data into database using csv file I have used COPY command. This will copy the data from CSV file and store it into database in bulk. The CSV HEADER will eliminate the header row of csv file. I have used the regex to seperate the list of sql queries into list. Similarly to previous steps, previously i have deleted all the record in database and only then I have read the query to insert the data inorder to eradicate the data redundancy.
