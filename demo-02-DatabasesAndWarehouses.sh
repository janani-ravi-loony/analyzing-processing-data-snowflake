

						demo-02-DatabasesAndWarehouses


###########

# Creating and Working with Warehouses

# Run the query

SELECT current_warehouse(), current_database(), current_schema();

# We can see the currently selected warehouse, database and schema
# Go to Admin -> Warehouses and there we can see 1 default warehouse and we can see the sizes

# Click on the Warehouse and show "Warehouse Activity" and "Query History"

# Let's create a new warehouse 

# Click on +Warehouse and give the following information
	# Name: MY_WAREHOUSE
	# Size: Let's select the smallest size (X-Small)
    # Click on Advanced Options and show the options
    # Explain the options here
    # Click on multi-cluster warehouses and show what it is used for
	# Select "Query Acceleration" and show what it is used for
	# Show the options here (see notes below)
	# Auto Suspend: 5 minutes


# NOTES: 
# Multi-cluster Warehouse

# The Scaling Policy (Standard vs Economy). This policy will dictate when a warehouse should auto scale-out and back in. Standard policy will focus on minimizing queuing where an Economy policy will look at fully utilizing the current cluster before adding an additional cluster (will only create a new cluster if it will be busy for 6 mins)


# Click on Create Warehouse

# Go here to understand the warehouse size and its impact on credit usage and billing: https://docs.snowflake.com/en/user-guide/warehouses-overview.html#warehouse-size

# We can see a new warehouse has been added 
# Now, if click on the recently created warehouse, we can see the load over time


# But to see the graph we will have to use the warehouse and for that we'll have to run some queries that consume credits


# Back to the worksheet

# Show that you can change the warehouse on the top-righ

# Run the following query

USE WAREHOUSE MY_WAREHOUSE;

SELECT current_warehouse(), current_database(), current_schema();

# We can see now the current_warehouse() has been changed to our newly created one

SELECT * FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1000"."CUSTOMER";

# The query takes 2-3 minutes to run

# Use the left navigation pane to find the table. Show that the table is > 10GB

# Go to Activity -> Query History and show the running status of the query


SELECT * FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF100"."PART" WHERE P_RETAILPRICE < 1000;


# Click on the query ID and show that each query has a unique id

# Show the history tab and the query id again

# Re-run the query
SELECT * FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF100"."PART" WHERE P_RETAILPRICE < 1000;

# This query runs faster (Snowflake clearly caches the query under the hood)


# Go to the history

# Go to History and we see even though the query is the same the query ids are different

# Hover over the bytes scanned and show that the warehouse is not used at all. 
# for the second run of the query. This is retrieval optimization where 
# we use persisted query results


# NOTE
# If a user repeats a query that has already been run, and the data in the table(s) hasn’t changed 
# since the last time that the query was run, then the result of the query is the same. Instead of running 
# the query again, Snowflake simply returns the same result that it returned previously. This can substantially 
# reduce query time because Snowflake bypasses query execution and, instead, retrieves the result 
# directly from the cache.


# Go to Warehouses

# Select the MY_WAREHOUSE -> Show the chart with the warehouse load

# Go ahead and DELETE this warehouse


############################################
# Creating and working with Databases
############################################


# Dataset: https://www.kaggle.com/holoong9291/gdp-of-all-countries19602020

# Lets create a database :

# Click on Data -> Databases and Click on +Database

# Name : "IMDB" 
# Comment : "Movies and directors information"

# Click on Create

# Let's create a table within this database 

# Click on the IMDB and show that there are 2 schemas automatically created

# Select the PUBLIC schema, we will create a table in this schema

# Click on Create and show all the options. Choose Table -> Standard

# Switch over to the worksheet

CREATE TABLE "IMDB"."PUBLIC"."MOVIES" 
("ID" INTEGER NOT NULL, 
 "TITLE" STRING, 
 "BUDGET" INTEGER, 
 "RELEASE_DATE" DATE, 
 "REVENUE" INTEGER, 
 "TAGLINE" STRING, 
 "RATING" FLOAT,
 "DIRECTOR_ID" INTEGER NOT NULL) 
 COMMENT = 'Movie information';

# Show that the table has been created


# Go to Admin -> Warehouses

# Click on Create and give the following information
    # Name: DATALOAD_WH
    # Size: Let's select the smallest size (X-Small)
    # Comment: "Warehouse use to load data into Snowflake"
    # "Advanced Warehouse Options" -> Auto Suspend: 5 minutes


# Back to Databases -> Tables. Select the "Movies" table

# Click on "Load Data" on the top right

# Select the DATALOAD_WH on the top right

# Drag the movies.csv file into the dialog

# Make sure you are loading into the MOVIES table

# Click Next, choose the file format


File format: CSV or TSV
Header: Skip first line
Field delimiter: Comma
Trim space: True
Field optionally enclosed by: Double quotes

# Show the other options, leave them as default


# Load the data

# For the table show:

Columns
Data Preview
Copy History


############################################

# Back to Snowsight worksheet

# Make sure Database + Schema = IMDB.PUBLIC
# Make sure COMPUTE_WH is selected (top-right)

SELECT * FROM MOVIES;


# Expand the page and we can see the query results
# Click on Query Details it shows you the compilation and execution timings as well


# Let's create one more table

CREATE TABLE "IMDB"."PUBLIC"."DIRECTORS" 
("NAME" STRING, 
 "ID" INTEGER NOT NULL, 
 "GENDER" INTEGER) 
COMMENT = 'Directors information';


# Click on "Load Data" on the top right

# Select the DATALOAD_WH on the top right

# Drag the directors.csv file into the dialog

# Make sure you are loading into the DIRECTORS table

# Click Next, choose the file format


File format: CSV or TSV
Header: Skip first line
Field delimiter: Comma
Trim space: True
Field optionally enclosed by: Double quotes

# Show the other options, leave them as default


# Load the data

# Run a query
SELECT * FROM DIRECTORS;



############################################

# Extra - creating a file format (only if needed)


# We will have to create a new File Format, let's create a csv file format so click on +

create or replace file format CSV_FORMAT
    type = CSV
    FIELD_DELIMITER = ',' 
    SKIP_HEADER = 1 
    FIELD_OPTIONALLY_ENCLOSED_BY='"'
    TRIM_SPACE = TRUE
    FILE_EXTENSION = 'csv'
    COMMENT = 'Format of CSV file'








































