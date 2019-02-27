USE employees;

-- Find all the employees with the same hire date as employee 101010 using a sub-query. 69 rows.
SELECT first_name, last_name
FROM employees
WHERE hire_date =
	(SELECT hire_date
    FROM employees
    WHERE emp_no = 101010
    );
    
-- Find all the titles held by all employees with the first name Aamod. 314 total titles, 6 unique titles.
SELECT title, COUNT(title)
FROM titles
WHERE emp_no IN (
	SELECT emp_no
    FROM employees
    WHERE first_name = 'Aamod'
    )
GROUP BY title
WITH ROLLUP;

-- How many people in the employees table are no longer working for the company?
SELECT COUNT(emp_no)
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
    FROM dept_emp
    WHERE to_date > NOW()
    );
    
-- Find all the current department managers that are female.
SELECT CONCAT(first_name, ' ', last_name)
FROM employees
WHERE gender = 'F'
	AND emp_no IN (
		SELECT emp_no
        FROM dept_manager
        WHERE to_date > NOW()
		);
        
-- Find all the employees that currently have a higher than average salary.
-- 154543 rows in total. 
SELECT CONCAT(e.first_name, ' ', e.last_name), s.salary
FROM employees e
JOIN salaries s
	ON e.emp_no = s.emp_no
WHERE s.to_date > NOW()
AND s.salary > (
	SELECT AVG(salary)
    FROM salaries
    );
    
-- How many current salaries are within 1 standard deviation of the highest salary?
-- (Hint: you can use a built in function to calculate the standard deviation.)
-- What percentage of all salaries is this?
-- 78 salaries.
SELECT COUNT(*)
FROM salaries
WHERE to_date > NOW()
	AND salary >= (
		SELECT MAX(salary) - STDDEV(salary)
        FROM salaries);

-- percentage
SELECT (SELECT COUNT(*)
		FROM salaries
		WHERE to_date > NOW()
		AND salary > (
			SELECT MAX(salary) - STDDEV(salary)
			FROM salaries
            )
		)/COUNT(salary)*100
FROM salaries
WHERE to_date > NOW();
        
-- Find all the department names that currently have female managers.
SELECT dept_name
FROM departments d
JOIN dept_manager dm
	ON d.dept_no = dm.dept_no
JOIN employees e
	ON dm.emp_no = e.emp_no
WHERE dm.to_date > NOW()
	AND dm.emp_no IN (
		SELECT emp_no
        FROM employees
        WHERE gender = 'F'
        );
        
-- Find the first and last name of the employee with the highest salary.
SELECT e.first_name, e.last_name
FROM employees e
JOIN salaries s
	ON e.emp_no = s.emp_no
WHERE s.salary = (
	SELECT MAX(salary)
    FROM salaries
    );
    
-- Find the department name that the employee with the highest salary works in.
SELECT dept_name
FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no
WHERE emp_no = (
			SELECT emp_no
            FROM salaries
            WHERE salary = (
					SELECT MAX(salary)
                    FROM salaries
                    )
			);