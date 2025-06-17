

				demo-13-SemiStructuredData


# Open up books.json and show the data

CREATE DATABASE LIBRARY;

USE DATABASE LIBRARY;

CREATE OR REPLACE TABLE BOOKS (
	json_data_raw VARIANT
);


# Go to the S3 bucket and show the books.json file is present there
# Open up books.json from datasets and show the file (keep this file open)


CREATE OR REPLACE STAGE "LIBRARY"."PUBLIC"."BOOKS_STAGE" url="s3://loony-snowflake-source-bucket/books.json"
CREDENTIALS=(aws_key_id='' 
             aws_secret_key='');

LIST @BOOKS_STAGE;

# Copy data from the external stage into the BOOKS table

COPY INTO LIBRARY.PUBLIC.BOOKS FROM @BOOKS_STAGE
file_format = (type=json);

SELECT * FROM BOOKS;


# Query the JSON data in the BOOKS tabke

SELECT JSON_DATA_RAW:title, JSON_DATA_RAW:author 
FROM BOOKS;

SELECT JSON_DATA_RAW:title, JSON_DATA_RAW:Availability[0] 
FROM BOOKS;

SELECT JSON_DATA_RAW:title, JSON_DATA_RAW:Availability[0]:Country 
FROM BOOKS;

SELECT JSON_DATA_RAW:title, JSON_DATA_RAW:price, JSON_DATA_RAW:Availability[0]:Cities[0] 
FROM BOOKS;


################################### Unloading data from Snowflake

# This is on the Snowflake UI

CREATE OR REPLACE STAGE UNLOAD_STAGE
FILE_FORMAT = (type=json);

COPY INTO @UNLOAD_STAGE/books 
FROM BOOKS;


# Now switch over to SnowSQL

USE DATABASE LIBRARY;

ls @UNLOAD_STAGE

GET @UNLOAD_STAGE/books_0_0_0.json.gz 
file:///Users/janani/snowsql_working_directory;


# Go to the folder, double click and unzip and show the file is available there




















































