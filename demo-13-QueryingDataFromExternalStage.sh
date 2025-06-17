

			         demo-12-QueryingDataFromAnExternalStage

# Loading data from an external stage using Snowpipe

# First go to https://console.aws.amazon.com/

# Login and show the S3 bucket s3://loony-snowflake-source-bucket

# Click through to the bucket and show the data



# Go to the IAM page and show the permissions for loony_user

# This user has S3 full access

# Click on the loony_user -> go to Security Credentials

# Generate a new access key and copy over the credentials


# Switch over to the Snowflake UI

# Create a database and table

CREATE DATABASE STORE_DB;

USE DATABASE STORE_DB;


# Create a named external stage that points to our S3 bucket

CREATE OR REPLACE STAGE STORE_DB.PUBLIC.S3_STORE_DATA_STAGE 
url="s3://loony-snowflake-source-bucket/"
CREDENTIALS=(aws_key_id='' 
             aws_secret_key='');

LIST @S3_STORE_DATA_STAGE;

LIST @S3_STORE_DATA_STAGE/historicalDatasets;


# Create a file format for the CSV data that we'll be loading

CREATE OR REPLACE FILE FORMAT CSVFORMAT 
TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1;


# Query the data in the stage

SELECT hist_data.$1, hist_data.$2, hist_data.$3, hist_data.$4
FROM @S3_STORE_DATA_STAGE/historicalDatasets/historical_data_1.csv (file_format => CSVFORMAT) hist_data 
LIMIT 5;


# Count the number of records

SELECT count(*)
FROM @S3_STORE_DATA_STAGE/historicalDatasets/ (file_format => CSVFORMAT) hist_data;



# Upload a new file to the historicalDatasets folder (2.csv)

# Count the number of records again and show they have gone up


SELECT count(*)
FROM @S3_STORE_DATA_STAGE/historicalDatasets/ (file_format => CSVFORMAT) hist_data;


#################################

# Create an external table

CREATE OR REPLACE EXTERNAL TABLE s3_external_table (
     SOLD_DATE       varchar as (value:c1::varchar),
     Article_ID      int as (value:c2::int),
     Country_Code    varchar as (value:c3::varchar),
     Sold_Units      int as (value:c2::int)
)
WITH LOCATION = @S3_STORE_DATA_STAGE
FILE_FORMAT = (FORMAT_NAME = CSVFORMAT)
PATTERN='.*\.csv$';


# Note the value column
SELECT * FROM s3_external_table;


# Count the number of records
SELECT COUNT(*) FROM s3_external_table;


# Add a 3rd file to the S3 bucket - run the count again (it has NOT gone up)


# Can refresh manually
ALTER EXTERNAL TABLE s3_external_table REFRESH;


# Refershing automatically involves integration with S3 event messages and only supported for AWS regions (if you are integrating with S3)







