


				demo-11-BulkLoadingDataUsingCOPYCommand

# Snowflake support two kinds of data stages
# Internal stage(managed by snowflake) or External Stage(managed by cloud provider)

#### Bulk loading from Local File System

# Login to SnowSQL

snowsql -a DBXQNPG-EAA37615 -u swathi

create database organization;

use database organization;


USE ORGANIZATION;


USE WAREHOUSE DATALOAD_WH;

############################################ User stage

# Copy over the file from my file system

cp ~/Desktop/iMovieLibrary/OReilly/Snowflake_OLT/final_code/datasets/uk_customers.csv .


# PUT the file into the user's stage (data in the user stage belongs to the user and can be loaded into any table)

PUT file:///Users/janani/snowsql_working_directory/uk_customers.csv @~/staged_customers;


list @~;

list @~/staged_customers;


rm @~/staged_customers;


list @~/staged_customers;


PUT file:///Users/janani/snowsql_working_directory/uk_customers.csv @~/staged_customers;


# Now switch over to the Snowflake UI

USE WAREHOUSE DATALOAD_WH;

CREATE OR REPLACE TABLE ORGANIZATION.PUBLIC.CUSTOMERS (
    "ID" INTEGER NOT NULL,
    "NAME" STRING,
    "SURNAME" STRING,
    "GENDER" STRING,
    "AGE" INTEGER,
    "REGION" STRING,
    "JOB_CLASSIFICATION" STRING,
    "BALANCE" FLOAT
);


# This will result in an error

COPY INTO ORGANIZATION.PUBLIC.CUSTOMERS FROM @~/staged_customers
FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',');

# Use ON_ERROR=CONTINUE to continue loading the file inspite of the error
# Observe the errors in the results pane (only the first error is show)

COPY INTO ORGANIZATION.PUBLIC.CUSTOMERS FROM @~/staged_customers
FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',') ON_ERROR=CONTINUE;


# This returns all the errors which were the result of your copy
SELECT * FROM TABLE(validate(ORGANIZATION.PUBLIC.CUSTOMERS, job_id => '_last'));

# Note the quotes around the JOB_CLASSIFICATION field values
# Note that we have a header

SELECT * FROM CUSTOMERS;

TRUNCATE TABLE CUSTOMERS;


# Copy with the right format and this will throw no errors

COPY INTO ORGANIZATION.PUBLIC.CUSTOMERS FROM @~/staged_customers
FILE_FORMAT = (TYPE = 'CSV' 
               FIELD_DELIMITER = ',' 
               SKIP_HEADER = 1 
               FIELD_OPTIONALLY_ENCLOSED_BY='''');

# Now the fields should look proper

SELECT * FROM CUSTOMERS;


# Data in the user stage can be loaded into any table
# Here we load the data into a table named account_holders

CREATE OR REPLACE TABLE ORGANIZATION.PUBLIC.ACCOUNT_HOLDERS (
    "ID" INTEGER NOT NULL,
    "NAME" STRING,
    "SURNAME" STRING,
    "GENDER" STRING,
    "AGE" INTEGER,
    "REGION" STRING,
    "JOB_CLASSIFICATION" STRING,
    "BALANCE" FLOAT
);

COPY INTO ORGANIZATION.PUBLIC.ACCOUNT_HOLDERS FROM @~/staged_customers
FILE_FORMAT = (TYPE = 'CSV' 
               FIELD_DELIMITER = ',' 
               SKIP_HEADER = 1 
               FIELD_OPTIONALLY_ENCLOSED_BY='''');

SELECT * FROM ACCOUNT_HOLDERS;


# Back to SnowSQL - the file should still be there in the user's stage

list @~/staged_customers;


############################################ Table stage

# Continue in SnowSQL

TRUNCATE TABLE CUSTOMERS;

TRUNCATE TABLE ACCOUNT_HOLDERS;

# List the files in the customers table stage, should be empty

list @%customers;


PUT file:///Users/janani/snowsql_working_directory/uk_customers.csv @%customers/staged_customers;


list @%customers;

# Load from the customer table stage to the customers table

COPY INTO ORGANIZATION.PUBLIC.CUSTOMERS FROM @%customers
FILE_FORMAT = (TYPE = 'CSV' 
               FIELD_DELIMITER = ',' 
               SKIP_HEADER = 1 
               FIELD_OPTIONALLY_ENCLOSED_BY='''');

# The files should have been successfully loaded

SELECT * FROM CUSTOMERS LIMIT 5;


## Cannot load into account_holders from the customers stage, this will be an error!

COPY INTO ORGANIZATION.PUBLIC.ACCOUNT_HOLDERS FROM @%customers
FILE_FORMAT = (TYPE = 'CSV' 
               FIELD_DELIMITER = ',' 
               SKIP_HEADER = 1 
               FIELD_OPTIONALLY_ENCLOSED_BY='''');


############################################ Named stage

# In Snowsight

TRUNCATE TABLE CUSTOMERS;

TRUNCATE TABLE ACCOUNT_HOLDERS;

# Let's create a new named stage

CREATE OR REPLACE STAGE customers_data_stage
FILE_FORMAT = (TYPE = 'CSV' 
               FIELD_DELIMITER = ',' 
               SKIP_HEADER = 1 
               FIELD_OPTIONALLY_ENCLOSED_BY='''');


SHOW STAGES;

# In SnowSQL

PUT file:///Users/janani/snowsql_working_directory/uk_customers.csv @customers_data_stage/staged_customers;


list @customers_data_stage;



COPY INTO ORGANIZATION.PUBLIC.CUSTOMERS FROM @customers_data_stage;


COPY INTO ORGANIZATION.PUBLIC.ACCOUNT_HOLDERS FROM @customers_data_stage
FILE_FORMAT = (TYPE = 'CSV' 
               FIELD_DELIMITER = ',' 
               SKIP_HEADER = 1 
               FIELD_OPTIONALLY_ENCLOSED_BY='''');


SELECT * FROM CUSTOMERS LIMIT 5;


SELECT * FROM ACCOUNT_HOLDERS LIMIT 5;





















