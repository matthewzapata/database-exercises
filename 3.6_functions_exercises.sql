USE employees;
-- Copy the order by exercise and save it as 3.6_functions_exercises.sql.

-- Update your queries for employees whose names start and end with 'E'.
-- Use concat() to combine their first and last name together as a single column named full_name.
SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE 'e%e';

-- Convert the names produced in your last query to all uppercase.
SELECT first_name, last_name, UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'e%e';

-- For your query of employees born on Christmas and hired in the 90s,
-- use datediff() to find how many days they have been working at the company
SELECT *, DATEDIFF(NOW(), hire_date) AS days_working_with_company
FROM employees
WHERE (hire_date LIKE '199%')
AND birth_date LIKE '%-12-25'
ORDER BY birth_date ASC, hire_date DESC;

-- Find the smallest and largest salary from the salaries table.
SELECT MIN(salary) AS lowest_salary, MAX(salary) AS largest_salary
FROM salaries;

-- Use your knowledge of built in SQL functions to generate a username for all of the employees.
-- A username should be all lowercase, and consist of the first character of the employees first name,
-- the first 4 characters of the employees last name, an underscore, the month the employee was born,
-- and the last two digits of the year that they were born.
SELECT LOWER(CONCAT(
	SUBSTR(first_name, 1, 1), 
	SUBSTR(last_name, 1, 4), 
	'_', 
	SUBSTR(birth_date, 6, 2), 
	SUBSTR(birth_date, 3, 2))) AS username, first_name, last_name, birth_date
FROM employees;