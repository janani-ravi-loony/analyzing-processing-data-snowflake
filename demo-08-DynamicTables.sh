

				demo-08-DynamicTables

# What are Dynamic Tables?
# Dynamic tables are Snowflake-managed tables that automatically update based on the latest upstream data changes.
# They simplify data pipelines by handling incremental refreshes internally.
# Useful in ELT workflows where transformation logic needs to stay current with source data.

CREATE DATABASE SALES_DB;

USE DATABASE SALES_DB;

# Source table
CREATE OR REPLACE TABLE source_sales (
    sale_id INT,
    product VARCHAR,
    category VARCHAR,
    amount NUMBER,
    sale_date DATE
);

# Data in the source table
INSERT INTO source_sales VALUES
(1, 'Bluetooth Headphones', 'Electronics', 100, '2025-06-01'),
(2, 'Smartwatch Pro', 'Electronics', 200, '2025-06-02'),
(3, 'Wireless Charger', 'Electronics', 150, '2025-06-03'),
(4, 'Organic Green Tea', 'Beverages', 50, '2025-06-01'),
(5, 'Ceramic Coffee Mug', 'Kitchenware', 80, '2025-06-04');

# Create a dynamic table

CREATE OR REPLACE DYNAMIC TABLE total_sales_by_category
  TARGET_LAG = '1 minute'
  WAREHOUSE = COMPUTE_WH
  REFRESH_MODE = auto
  INITIALIZE = on_create
AS
SELECT
    category,
    SUM(amount) AS total_amount
FROM source_sales
GROUP BY category;

# Query dynamic table
SELECT * FROM total_sales_by_category;


# Now go to Databases from the left (open in new tab)

# For SALES_DB.PUBLIC

# Show that we have a table and a dynamic table

# Click on the dynamic table and show the following

Table Details
Columns
Data Preview
Graph
Refresh History

# Back in queries

SHOW TABLES;

SHOW DYNAMIC TABLES;

# Insert data into source table
INSERT INTO source_sales VALUES
(6, 'Espresso Machine', 'Kitchenware', 300, '2025-06-05'),
(7, 'Herbal Chamomile Tea', 'Beverages', 60, '2025-06-06'),
(8, 'Noise Cancelling Earbuds', 'Electronics', 180, '2025-06-07'),
(9, 'Stainless Steel Knife Set', 'Kitchenware', 120, '2025-06-07'),
(10, 'Cold Brew Coffee Maker', 'Beverages', 90, '2025-06-08');

# Go to refresh history (uncheck warehouse)

# Hit refresh till you see the refresh run

# Back in queries (new records information should be included in the aggregation)
SELECT * FROM total_sales_by_category;

# Insert more data
INSERT INTO source_sales VALUES
(11, 'Yoga Mat', 'Fitness', 70, '2025-06-09'),
(12, 'Desk Lamp', 'Home Decor', 85, '2025-06-10');


# Go to refresh history (uncheck warehouse)

# Hit refresh till you see the refresh run

# Back in queries (new records information should be included in the aggregation)
SELECT * FROM total_sales_by_category;










