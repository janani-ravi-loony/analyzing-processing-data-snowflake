


				demo-10-WindowFunctions


# Create an employees table in a new database

create database organization;

use database organization;

DROP TABLE IF EXISTS employees;

CREATE TABLE IF NOT EXISTS employees
(id varchar(20),
 name varchar(50),
 salary int,
 department varchar(20),
 tenure int,
 title varchar(20)
);

INSERT INTO employees VALUES
('E1', 'Randal', 150000, 'HR', 6, 'Vice President'),
('E2', 'Stephanie', 140000, 'Operations', 4, 'Vice President'),
('E3', 'James', 55000, 'Engineering', 3, 'Software Engineer'),
('E4', 'Julie', 95000, 'Engineering', 6, 'Software Engineer'),
('E5', 'Alan', 20000, 'Engineering', 1, 'Analyst'),
('E6', 'Dora', 35000, 'Engineering', 3, 'Analyst'),
('E7', 'Joseph', 335000, 'Engineering', 7, 'Vice President'),
('E8', 'Nancy', 35000, 'HR', 3, 'Analyst'),
('E9', 'Nina', 57000, 'Operations', 3, 'Manager'),
('E10', 'Seth', 98000, 'Engineering', 8, 'Manager'),
('E11', 'John', 70000, 'HR', 10, 'Manager'),
('E11', 'Peter', 60000, 'Operations', 7, 'Manager');


# Ordinary grouping

SELECT department, max(salary)
FROM employees
GROUP BY department;

# Window function over all the contents of the table

SELECT name, salary, max(SALARY) OVER () AS max_salary
FROM EMPLOYEES;

# Window computing percent of total over entire table

SELECT name, salary, 100 * ratio_to_report(SALARY) OVER () AS percent_of_total
FROM EMPLOYEES
ORDER BY salary;


# Window function computing percent of total salary within department

SELECT name, salary, department, 
       100 * ratio_to_report(SALARY) OVER (PARTITION BY department) AS percent_of_total
FROM EMPLOYEES
ORDER BY department, salary;


# Compute rank based on salary within each department

SELECT name, salary, department, rank() OVER (PARTITION BY department ORDER BY salary) AS ranking
FROM EMPLOYEES
ORDER BY department, ranking;


SELECT name, salary, department, rank() OVER (PARTITION BY department ORDER BY salary DESC) AS ranking
FROM EMPLOYEES
ORDER BY department, ranking;



### Please note that you can select the cells in the "Salary" column to show sum and average


# -- Cumulative frame

# Cumulative sum of salaries within department

SELECT name, salary, department, 
    sum(SALARY) OVER (PARTITION BY department 
                      ORDER BY salary 
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum
FROM EMPLOYEES
ORDER BY department, cumulative_sum;


# Minimum salary in the window current row and all following rows

SELECT name, salary, department, 
    min(SALARY) OVER (PARTITION BY department 
                      ORDER BY salary
                      ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS min_salary
FROM EMPLOYEES
ORDER BY department, salary;



# -- Sliding frame

SELECT name, salary, department, 
    avg(SALARY) OVER (PARTITION BY department 
                      ORDER BY salary
                      ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS avg_salary
FROM EMPLOYEES
ORDER BY department;





































