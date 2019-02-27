USE employees;
DESCRIBE employees;
-- all employees with first name Irena, Vidya, or Maya
SELECT * FROM employees WHERE first_name IN('Irena', 'Vidya', 'Maya');
-- find all employees whose last name starts with an 'E'
SELECT * FROM employees WHERE last_name LIKE 'E%';
-- find all employees hired in the 1990's
SELECT * FROM employees WHERE hire_date LIKE '199%';
-- find all employees born on Christmas
SELECT * FROM employees WHERE birth_date LIKE '%-12-25';
-- find all employees with a 'q' in their last name
SELECT * FROM employees WHERE last_name LIKE '%q%';
-- find Irena, Vidya, or Maya using OR
SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
-- find males whose name is either Irena, Vidya, or Maya
SELECT *
FROM employees
WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = 'M';
-- all employees whose last name starts or ends with an 'e'
SELECT * FROM employees WHERE last_name LIKE 'E%' OR last_name LIKE '%e';
-- find all employees whose last name starts and ends with an 'E'
SELECT * FROM employees WHERE last_name LIKE 'e%e';
-- all employees hired in the 90's and born on Christmas
SELECT *
FROM employees
WHERE (hire_date LIKE '199%')
AND birth_date LIKE '%-12-25';
-- find all employees with a 'q' in their last name but not 'qu'
SELECT *
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';