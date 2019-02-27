USE ada_665;

-- Using the example from the lesson, re-create the employees_with_departments table.
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT e.emp_no, e.first_name, e.last_name, d.dept_no, d.dept_name
FROM employees.employees e
JOIN employees.dept_emp de USING(emp_no)
JOIN employees.departments d USING(dept_no)
LIMIT 100;

-- Add a column named full_name to this table.
-- It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
ALTER TABLE employees_with_departments ADD full_name VARCHAR(50);

-- Update the table so that full name column contains the correct data
UPDATE employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);
SELECT * FROM employees_with_departments;

-- Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- What is another way you could have ended up with this same table?
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT e.emp_no, d.dept_no, d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees.employees e
JOIN employees.dept_emp de USING(emp_no)
JOIN employees.departments d USING(dept_no)
LIMIT 100;

-- Create a temporary table based on the payments table from the sakila database.
CREATE TEMPORARY TABLE sakila_temp AS SELECT * FROM sakila.payment;
SELECT * FROM sakila_temp;

-- Write the SQL necessary to transform the amount column such that it is stored
-- as an integer representing the number of cents of the payment.
-- For example, 1.99 should become 199.
ALTER TABLE sakila_temp MODIFY amount DECIMAL(6,2);
UPDATE sakila_temp SET amount = amount * 100;
ALTER TABLE sakila_temp MODIFY amount INTEGER;
SELECT * FROM sakila_temp;

-- Find out how the average pay in each department compares to the overall average pay.
-- In order to make the comparison easier, you should use the Z-score for salaries.
-- In terms of salary, what is the best department to work for? The worst?


-- finding average and std dev
SELECT AVG(salary), STDDEV(salary)
FROM employees.salaries
WHERE to_date > NOW();

-- get z
SELECT emp_no, salary, ((salary-72012)/17310) AS z_salary
FROM employees.salaries
WHERE to_date > NOW();

-- get department
SELECT s.emp_no, d.dept_name, s.salary, ((s.salary-72012)/17310) AS z_salary
FROM employees.salaries s
JOIN employees.dept_emp de ON s.emp_no = de.emp_no
JOIN employees.departments d ON de.dept_no = d.dept_no
WHERE s.to_date > NOW();

-- get average z by dept

SELECT dept_name, AVG(z_salary) AS avg_z_salary FROM
(SELECT s.emp_no, d.dept_name, s.salary, ((s.salary-72012)/17310) AS z_salary
FROM employees.salaries s
JOIN employees.dept_emp de ON s.emp_no = de.emp_no
JOIN employees.departments d ON de.dept_no = d.dept_no
WHERE s.to_date > NOW()) A
GROUP BY dept_name;

-- create temp table
CREATE TEMPORARY TABLE agg AS SELECT AVG(salary) AS average, STDDEV(salary) AS std_dev FROM employees.salaries WHERE to_date > NOW();
SELECT * FROM agg;

DROP TABLE agg;

-- make another table using agg table
CREATE TEMPORARY TABLE z_score_departments AS SELECT dept_name, AVG(z_salary) AS avg_z_salary FROM
(SELECT s.emp_no, d.dept_name, s.salary, ((s.salary-agg.average)/agg.std_dev) AS z_salary
FROM employees.salaries s
JOIN agg
JOIN employees.dept_emp de ON s.emp_no = de.emp_no
JOIN employees.departments d ON de.dept_no = d.dept_no
WHERE s.to_date > NOW()) A
GROUP BY dept_name;

SELECT * FROM z_score_departments;

-- What is the average salary for an employee based on the number of years they have been with the company?
-- Express your answer in terms of the Z-score of salary.
-- Since this data is a little older, scale the years of experience by subtracting the minumum from every row.


SELECT FLOOR(datediff(current_date(), e.hire_date)/365)AS years_exp, s.salary, ((s.salary - agg.average)/agg.std_dev) AS z_salary
FROM employees.employees e
JOIN agg
JOIN employees.salaries s
	USING (emp_no)
WHERE s.to_date > NOW()
LIMIT 10;

CREATE TEMPORARY TABLE years_avg_z AS SELECT years_exp, AVG(z_salary) FROM 
(SELECT FLOOR(datediff(current_date(), e.hire_date)/365)AS years_exp, s.salary, ((s.salary - agg.average)/agg.std_dev) AS z_salary
FROM employees.employees e
JOIN agg
JOIN employees.salaries s
	USING (emp_no)
WHERE s.to_date > NOW()) AS A
GROUP BY years_exp;

SELECT * FROM years_avg_z;