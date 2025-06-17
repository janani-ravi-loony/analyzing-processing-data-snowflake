

				demo-07-Views

# Creating a regular view

CREATE OR REPLACE VIEW MOVIES_AND_DIRECTORS
AS
SELECT title, tagline, release_date, name 
FROM MOVIES JOIN DIRECTORS ON MOVIES.director_id = DIRECTORS.id;

SELECT * FROM MOVIES_AND_DIRECTORS;


# Click on the 3 dots ...
# Click on the query profile and you can see that when you query the view the underlying
# join operation is performed and you can see what exactly is the subquery 


CREATE OR REPLACE SECURE VIEW MOVIES_AND_DIRECTORS_SECURED
AS
SELECT title, tagline, release_date, name 
FROM MOVIES JOIN DIRECTORS ON MOVIES.director_id = DIRECTORS.id;

SELECT * FROM MOVIES_AND_DIRECTORS_SECURED;


# Click on the 3 dots ...
# Click on the query profile and you can see that when you query the view the underlying
# join operation is performed and you CANNOT see what exactly is the subquery


# Regular and materialized views

SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CUSTOMER LIMIT 10;


SELECT COUNT(*) FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CUSTOMER;


CREATE OR REPLACE VIEW YOUNGER_CUSTOMERS
AS
SELECT *
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CUSTOMER 
WHERE C_BIRTH_YEAR > 1985;


# The results will not be generated faster (also lot's more data will be scanned)
# Open query profile and show

SELECT * FROM YOUNGER_CUSTOMERS;



CREATE OR REPLACE MATERIALIZED VIEW YOUNGER_CUSTOMERS_MATERIALIZED
AS
SELECT *
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CUSTOMER 
WHERE C_BIRTH_YEAR > 1985;


# This should give you results much faster (less data will be scanned)

SELECT * FROM YOUNGER_CUSTOMERS_MATERIALIZED;
















