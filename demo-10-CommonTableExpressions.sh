
				demo-09-CommonTableExpressions

# A CTE (common table expression) is a named subquery defined in a WITH clause. You can think of the CTE as a temporary view for use in the statement that defines the CTE. The CTE defines the temporary view's name, an optional list of column names, and a query expression (i.e. a SELECT statement).

# Simple CTE

WITH MOVIES_DIRECTORS_CTE AS (
    SELECT title, name, tagline, release_date, rating 
    FROM MOVIES JOIN DIRECTORS ON MOVIES.director_id = DIRECTORS.id
    ORDER BY release_date
)
SELECT title, name, release_date FROM MOVIES_DIRECTORS_CTE;


# Multi-step CTE (2 steps)

WITH MOVIES_DIRECTORS_CTE AS (
    SELECT title, name, tagline, release_date, rating 
    FROM MOVIES JOIN DIRECTORS ON MOVIES.director_id = DIRECTORS.id
    ORDER BY release_date
),
MOVIES_DIRECTORS_FROM_THE_1940S_CTE AS (
  SELECT * FROM MOVIES_DIRECTORS_CTE
  WHERE release_date > '1940-01-01' AND release_date < '1949-12-31'
)
SELECT title, name, release_date FROM MOVIES_DIRECTORS_FROM_THE_1940S_CTE;


# Multi-step CTE (3 steps)

WITH MOVIES_DIRECTORS_CTE AS (
    SELECT title, name, tagline, release_date, rating 
    FROM MOVIES JOIN DIRECTORS ON MOVIES.director_id = DIRECTORS.id
    ORDER BY release_date
),
MOVIES_DIRECTORS_FROM_THE_1940S_CTE AS (
  SELECT * FROM MOVIES_DIRECTORS_CTE
  WHERE release_date > '1940-01-01' AND release_date < '1949-12-31'
),
MOVIES_DIRECTORS_1940S_HIGH_RATED_CTE AS (
  SELECT * FROM MOVIES_DIRECTORS_FROM_THE_1940S_CTE
  WHERE rating > 7.5
)
SELECT title, name, release_date, rating FROM MOVIES_DIRECTORS_1940S_HIGH_RATED_CTE;


# Recursive CTE

SELECT DISTINCT(round(rating)) AS rating 
FROM MOVIES 
WHERE RELEASE_DATE > '2005-01-01' AND RELEASE_DATE < '2005-12-31' order by rating;


SELECT count(*) 
FROM MOVIES 
WHERE RELEASE_DATE > '2005-01-01' AND RELEASE_DATE < '2005-12-31';



WITH RECURSIVE MOVIE_RATINGS_CTE(TITLE, RELEASE_DATE, RATING, RATING_INDICATOR) AS (
    -- Anchor Clause
    SELECT TITLE, RELEASE_DATE, round(RATING) as RATING, '####' 
    FROM MOVIES 
    WHERE RATING = 4 AND RELEASE_DATE > '2005-01-01' AND RELEASE_DATE < '2005-12-31'
    
    UNION ALL 
    -- Recursive Clause
    SELECT MOVIES.TITLE, MOVIES.RELEASE_DATE, round(MOVIES.RATING) as RATING, MOVIE_RATINGS_CTE.RATING_INDICATOR || '#'
    FROM MOVIE_RATINGS_CTE JOIN MOVIES 
    ON round(MOVIES.RATING) = MOVIE_RATINGS_CTE.RATING + 1 AND 
       MOVIES.RATING <= 10 AND 
       MOVIES.RELEASE_DATE > '2005-01-01' AND MOVIES.RELEASE_DATE < '2005-12-31'
)
SELECT DISTINCT * FROM MOVIE_RATINGS_CTE ORDER BY RATING DESC;



# From the Snowflake documentation

# Create and insert data into table

create database organization;

use database organization;

create or replace table employees (title varchar, employee_id integer, manager_id integer);

insert into employees (title, employee_id, manager_id) values
    ('President', 1, null),  -- The President has no manager.
        ('Vice President Engineering', 10, 1),
            ('Programmer', 100, 10),
            ('QA Engineer', 101, 10),
        ('Vice President HR', 20, 1),
            ('Health Insurance Analyst', 200, 20);


# Self-join to find managers

select
     emps.title,
     emps.employee_id,
     mgrs.employee_id as manager_id, 
     mgrs.title as "MANAGER TITLE"
  from employees as emps left outer join employees as mgrs
    on emps.manager_id = mgrs.employee_id
  order by mgrs.employee_id nulls first, emps.employee_id;
  

# Recursive CTE (output not ordered based on the reporting hierarchy)
  
with recursive managers 
      -- Column names for the "view"/CTE
      (indent, employee_id, manager_id, employee_title) 
    as
      -- Common Table Expression
      (

        -- Anchor Clause
        select '' as indent, employee_id, manager_id, title as employee_title
          from employees
          where title = 'President'

        union all

        -- Recursive Clause
        select indent || '--- ',
            employees.employee_id, employees.manager_id, employees.title
          from employees join managers 
            on employees.manager_id = managers.employee_id
      )

  -- This is the "main select".
  select indent || employee_title as title, employee_id, manager_id
    from managers
  ;  


# Create a sort key which concatenates the key of the manager with the key
# of the report


create or replace function skey(id varchar)
  returns varchar
  as
  $$
    substring('0000' || id::varchar, -4) || ' '
  $$
  ;
  

select skey(23);

# Recursive CTE (output ordered based on the reporting hierarchy)

with recursive managers 
      -- Column list of the "view"
      (indent, employee_id, manager_id, employee_title, sort_key) 
    as 
      -- Common Table Expression
      (
        -- Anchor Clause
        select '' as indent, 
            employee_id, manager_id, title as employee_title, skey(employee_id)
          from employees
          where title = 'President'

        union all

        -- Recursive Clause
        select indent || '--- ',
            employees.employee_id, employees.manager_id, employees.title, 
            sort_key || skey(employees.employee_id)
          from employees join managers 
            on employees.manager_id = managers.employee_id
      )

  -- This is the "main select".
  select 
         indent || employee_title as title, employee_id, 
         manager_id, 
         sort_key
    from managers
    order by sort_key
  ;  









































































