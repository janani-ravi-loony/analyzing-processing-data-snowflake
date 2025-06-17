

				demo-08-DataSampling


# BERNOULLI (or ROW): Includes each row with a probability of p/100. Similar to flipping a weighted coin for each row.

# SYSTEM (or BLOCK): Includes each block of rows with a probability of p/100. Similar to flipping a weighted coin for each block of rows. This method does not support fixed-size sampling.



# Query the whole data

# There are 100 classes and 11 distinct categories

SELECT I_CLASS, I_WHOLESALE_COST, I_CATEGORY
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.ITEM;


# Note how many classes and categories there are

SELECT I_CLASS, I_WHOLESALE_COST, I_CATEGORY
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.ITEM
LIMIT 200;


SELECT I_CLASS, I_WHOLESALE_COST, I_CATEGORY
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.ITEM
SAMPLE ROW(200 rows);

# TABLESAMPLE is an alias of SAMPLE

SELECT I_CLASS, I_WHOLESALE_COST, I_CATEGORY
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.ITEM
TABLESAMPLE ROW(200 rows);  

# Sample 2% of the data

SELECT I_CLASS, I_WHOLESALE_COST, I_CATEGORY
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.ITEM
SAMPLE ROW(2);

# Sample 0.002% of the data

SELECT I_CLASS, I_WHOLESALE_COST, I_CATEGORY
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.ITEM
SAMPLE ROW(0.002);


# BERNOULLI is the same as ROW
# Repeatable gives us the same result each time

# Running this multiple times will give us different number of rows each time
SELECT I_CLASS, I_WHOLESALE_COST, I_CATEGORY
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.ITEM
SAMPLE BERNOULLI(0.002);

# Run this twice (will get the same number of rows because of repeatable)
SELECT I_CLASS, I_WHOLESALE_COST, I_CATEGORY
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.ITEM
SAMPLE BERNOULLI(0.002) repeatable (222);


# Block sampling can be much faster on larger datasets
# The data distribution of the sample will not be as good as the original data
# For good data distribution use ROW or BERNOULLI sampling

# Bernoulli sampling will take 1 min for 2.9m rows

SELECT CR_ITEM_SK, CR_REFUNDED_ADDR_SK, CR_REASON_SK
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CATALOG_RETURNS
SAMPLE BERNOULLI(0.02);

# Block sampling will take 2.5 seconds

SELECT CR_ITEM_SK, CR_REFUNDED_ADDR_SK, CR_REASON_SK
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CATALOG_RETURNS
SAMPLE SYSTEM(0.02);
















