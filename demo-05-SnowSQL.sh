

				demo-05-SnowSQL


# We now need to load data using SnowSQL

https://docs.snowflake.com/en/user-guide/snowsql


# Open this link (click on Installing SnowSQL at the bottom)

https://docs.snowflake.com/en/user-guide/snowsql-install-config

# Click on "SnowSQL Download"

# Show that you can download the latest version for your OS

# Once downloading is completed -> click on the downloaded file 
# SnowSQL install page will open -> click on "continue" 
# Destination select "Install for me only" -> continue
# Click on "Install" to install - enter username ans passowrd to install the software 
# Before clicking on Close, just go through the steps on what to do next
# Click on close to complete the installation

# Now go to Application -> and click on the SnowSQL application
# New terminal window will open -> follow the below procedure

snowsql --version


# Now, we have to change the log file 
# https://stackoverflow.com/questions/64717416/qmacos-error-failed-to-initialize-log-no-logging-is-enabled-errno-13-perm

cd ~/.snowsql/

ls -l

nano config

# change the code "log_file = ../snowsql_rt.log" to "log_file = ~/.snowsql/snowsql_rt.log" 

# Show that you can configure your account details here so you don't have to specify them each time
# you connect to Snowflake

# Also password is in plaintext

accountname = <account_name>
 username = <account_name>
 password = <password> 


# Ctrl + X to quit


mkdir ~/snowsql_working_directory

cd ~/snowsql_working_directory


# Now run the below code 

snowsql -a DBXQNPG-EAA37615 -u swathi


# Show where you can get this URL (account -> bottom left -> click on account -> Copy account identifier)

# Open this link 


# Now run the below code 

snowsql -a DBXQNPG-EAA37615 -u swathi

# Type out these queries to show how autocomplete works

USE IMDB;

SHOW TABLES;

SELECT COUNT(*) FROM DIRECTORS;


# In a Snowflake session, you can issue commands to take specific actions. All commands in SnowSQL start with an exclamation point (!), followed by the command name.

!queries;

!SET VARIABLE_SUBSTITUTION=TRUE;

!DEFINE FIRST_NAME='Adam'

SELECT * FROM DIRECTORS WHERE NAME LIKE '&FIRST_NAME%';

!SET VARIABLE_SUBSTITUTION=FALSE;

# Here we dont get any result, because variable_substitution=false

SELECT * FROM DIRECTORS WHERE NAME LIKE '&FIRST_NAME%';


# Variable substituion for partial names
!DEFINE FIRST_NAME_PARTIAL='Alan'

!SET VARIABLE_SUBSTITUTION=TRUE;

# Use curly braces

SELECT * FROM DIRECTORS WHERE NAME = '&{FIRST_NAME_PARTIAL} Alda';
                                 

# to check the number of variable which we have right now

!VARIABLES;

# Run the below command to clear the screen

!system clear;


!quit





















