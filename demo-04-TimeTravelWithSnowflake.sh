

				demo-04-TimeTravelWithSnowflake

# Create a table with a fixed retention period

# Note that we cannot have a table with more than 90 days of retention period
# This throws error
# SQL compilation error: Exceeds maximum allowable retention time (90). 

CREATE OR REPLACE TABLE movies_2017
("ID" INTEGER NOT NULL, 
 "TITLE" STRING, 
 "BUDGET" INTEGER, 
 "RELEASE_DATE" DATE, 
 "REVENUE" INTEGER, 
 "TAGLINE" STRING, 
 "RATING" FLOAT,
 "DIRECTOR_ID" INTEGER NOT NULL) 
DATA_RETENTION_TIME_IN_DAYS = 100;

# A retention period of 0 days for an object effectively disables Time Travel for the object.

CREATE OR REPLACE TABLE movies_2017
("ID" INTEGER NOT NULL, 
 "TITLE" STRING, 
 "BUDGET" INTEGER, 
 "RELEASE_DATE" DATE, 
 "REVENUE" INTEGER, 
 "TAGLINE" STRING, 
 "RATING" FLOAT,
 "DIRECTOR_ID" INTEGER NOT NULL) 
DATA_RETENTION_TIME_IN_DAYS = 0;


# The data retention period specifies the number of days for which this historical data is 
# preserved and, therefore, Time Travel operations (SELECT, CREATE … CLONE, UNDROP) 
# can be performed on the data.

CREATE OR REPLACE TABLE movies_2016 
("ID" INTEGER NOT NULL, 
 "TITLE" STRING, 
 "BUDGET" INTEGER, 
 "RELEASE_DATE" DATE, 
 "REVENUE" INTEGER, 
 "TAGLINE" STRING, 
 "RATING" FLOAT,
 "DIRECTOR_ID" INTEGER NOT NULL) 
DATA_RETENTION_TIME_IN_DAYS = 5;

SHOW TABLES LIKE 'movies_%';

# Show the retention period is 5 days for this table


INSERT INTO MOVIES_2016
SELECT * FROM MOVIES
WHERE release_date between '2016-01-01' and '2016-12-31';

SELECT COUNT(*) FROM MOVIES_2016;


ALTER SESSION SET TIMEZONE = 'UTC';

SELECT GETDATE();

# Copy the date from the bottom right

// 2024-04-20 07:33:50.996 +0000

DELETE FROM MOVIES_2016 WHERE BUDGET < 100000;

# Copy the query ID

// 01b3ca66-0001-20e6-0000-00043caa283d

SELECT COUNT(*) FROM MOVIES_2016;

SELECT COUNT(*) FROM MOVIES_2016
BEFORE (statement => '');

SELECT count(*) FROM MOVIES_2016 
AT(timestamp => ''::timestamp); 

SELECT count(*) FROM MOVIES_2016 
BEFORE(offset => -60*5);


DROP TABLE MOVIES_2016;

# This will be an error
SELECT * FROM MOVIES_2016;

UNDROP TABLE MOVIES_2016;

# This will work
SELECT * FROM MOVIES_2016;


DROP TABLE movies_2017;

# This will not work
UNDROP TABLE movies_2017;







