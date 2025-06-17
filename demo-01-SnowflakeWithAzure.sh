

						demo-01-SnowflakeWithAzure

https://www.snowflake.com/pricing/

# Show the pricing options in different platforms and different regions


# Choose the enterprise edition


# Select GET STARTED on any of the links
# Show the form for the free trial signup

# This is our Snowflake account:

https://dbxqnpg-eaa37615.snowflakecomputing.com


# Goes directly to the Snowsight view (classic view no longer available)


# Show the links on the left hand side

# Projects

# -- Worksheets

# -- Streamlit

# -- Dashboards

# -- App Packages

# Data

# -- Databases (select snowflake_sample_data and show the schemas within it)
# Click on Private Sharing and Provider Studio

# Data Products

# Marketplace (no reason to go into other options here)


# Monitoring

# -- Activity (show query history)

# -- Admin
# Here show Warehouses, Cost Management, Users & roles, Accounts



# Go to Databases

# Click on SNOWFLAKE_SAMPLE_DATA and we can see all the Table Name in that database

# Explore this structure


# Let's head back to worksheet and run some queries

# Create a new worksheet (using + on the top right)

# Show that no warehouse is selected (top-right)
# Show the account that we're using to run the query

# Just above the worksheet notice

SHOW DATABASES;

# Note that we have not selected a database or a schema to run this


# Click on Run (on the top right) to run the query (Cmd + Enter will also run the query)


USE DATABASE SNOWFLAKE_SAMPLE_DATA;

# Show on the UI top-right that this SNOWFLAKE_SAMPLE_DATA is selected as the current database

SHOW TABLES;

# Go to Warehouses

# Show that the COMPUTE_WH is still disabled (if it is not go ahead and suspend this)


SELECT * FROM TPCH_SF1.CUSTOMER;


# Note on the top-right COMPUTE_WH is shown in green indicating it's running

# Go to Warehouses

# Show that the COMPUTE_WH has now been started (under Status it should say "Started")


# Back to the worksheet

# Click on the arrow on the left hand side (This will show you the databases that you have)

# Place your cursor on a new row in the worksheet

# Go to snowflake_sample_data -> SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CALL_CENTER

# Details of the table will show up

# Click on the ...

# Select "place name in editor"

# Again click on ...

# Select "Add columns in editor"

# Can use this to construct a query


# Click on the top-left and show you can rename the sheet (Queries)

# Use the menu to delete the worksheet




##########################################

# Technologies

# Streamlit

# Streamlit is an open-source Python library that makes it easy to create and share custom web apps for machine learning and data science. By using Streamlit you can quickly build and deploy powerful data applications. For more information about the open-source library, see the Streamlit Library documentation.

# Streamlit in Snowflake helps developers securely build, deploy, and share Streamlit apps on Snowflake’s data cloud. Using Streamlit in Snowflake, you can build applications that process and use data in Snowflake without moving data or application code to an external system.

# Dynamic tables

# Dynamic tables are new declarative way of defining your data pipeline in Snowflake. It's a new kind of Snowflake table which is defined as a query to continuously and automatically materialize the result of that query as a table. Dynamic Tables can join and aggregate across multiple source objects and incrementally update results as sources change.















