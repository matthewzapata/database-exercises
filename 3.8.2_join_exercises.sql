-- Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;
SELECT * FROM roles r JOIN users u ON u.role_id = r.id;

-- Use join, left join, and right join to combine results from the users and roles tables
-- as we did in the lesson. Before you run each query, guess the expected number of results.
-- join - 4 rows
SELECT *
FROM roles r
JOIN users u
ON u.role_id = r.id;

-- left join - 5 rows
SELECT *
FROM roles r 
LEFT JOIN users u 
ON r.id = u.role_id;

-- right join - 6 rows
SELECT *
FROM roles r
RIGHT JOIN users u
ON r.id = u.role_id;

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries.
-- Use count and the appropriate join type to get a list of roles along with the number of users that has
-- the role. Hint: You will also need to use group by in the query.
SELECT r.name, COUNT(u.role_id)
FROM roles r
LEFT JOIN users u
ON r.id = u.role_id
GROUP BY r.name;

-- Use the employees database.
USE employees;

-- Using the example in the Associative Table Joins section as a guide,
-- write a query that shows each department along with the name of the current manager for that department.
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name)
FROM departments d
JOIN dept_manager dm
ON d.dept_no = dm.dept_no
JOIN employees e
ON e.emp_no = dm.emp_no
WHERE dm.to_date LIKE '9999-%'
ORDER BY d.dept_name;

-- Find the name of all departments currently managed by women.
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name)
FROM departments d
JOIN dept_manager dm
	ON d.dept_no = dm.dept_no
JOIN employees e
	ON e.emp_no = dm.emp_no
WHERE dm.to_date LIKE '9999-%'
	AND e.gender = 'F';

-- Find the current titles of employees currently working in the Customer Service department.
SELECT t.title, COUNT(t.title)
FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no
JOIN titles t
	ON de.emp_no = t.emp_no
WHERE t.to_date LIKE '9999-%' 
	AND de.to_date LIKE '9999-%' 
	AND de.dept_no = 'd009'
GROUP BY t.title;

-- Find the current salary of all current managers.
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name), s.salary
FROM departments d
JOIN dept_manager dm
    ON d.dept_no = dm.dept_no
JOIN employees e
	ON dm.emp_no = e.emp_no
JOIN salaries s
	ON e.emp_no = s.emp_no
WHERE dm.to_date LIKE '9999-%' 
	AND s.to_date LIKE '9999-%'
ORDER BY d.dept_name;

-- Find the number of employees in each department.
SELECT d.dept_no, d.dept_name, COUNT(de.emp_no) AS num_employees
FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no
WHERE de.to_date LIKE '9999-%'
GROUP BY d.dept_no;

-- Which department has the highest average salary?
SELECT d.dept_name, AVG(s.salary)
FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no
JOIN salaries s
	ON de.emp_no = s.emp_no
WHERE de.to_date LIKE '9999_%' AND s.to_date LIKE '9999-%'
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC
LIMIT 1;

-- Who is the highest paid employee in the Marketing department?
SELECT e.first_name, e.last_name, s.salary AS salary
FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no
JOIN employees e
	ON de.emp_no = e.emp_no
JOIN salaries s
	ON e.emp_no = s.emp_no
WHERE s.to_date LIKE '9999-%'
	AND de.to_date LIKE '9999-%'
    AND d.dept_no = 'd001'
ORDER BY s.salary DESC
LIMIT 1;
    
-- Which current department manager has the highest salary?
SELECT d.dept_name, e.first_name, e.last_name, s.salary
FROM departments d
JOIN dept_manager dm
	ON d.dept_no = dm.dept_no
JOIN employees e
	ON dm.emp_no = e.emp_no
JOIN salaries s
	ON e.emp_no = s.emp_no
WHERE dm.to_date LIKE '9999-%'
	AND s.to_date LIKE '9999-%'
ORDER BY s.salary DESC
LIMIT 1;

-- Bonus: Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee,
	d.dept_name,
	CONCAT(e2.first_name, ' ', e2.last_name) AS manager
FROM employees e
JOIN dept_emp de
	ON e.emp_no = de.emp_no
JOIN departments d
	ON de.dept_no = d.dept_no
JOIN dept_manager dm
	ON d.dept_no = dm.dept_no
JOIN employees e2
	ON dm.emp_no = e2.emp_no
WHERE de.to_date LIKE '9999-%'
	AND dm.to_date LIKE '9999-%'
    ORDER BY d.dept_name;

-- Bonus: Find the highest paid employee in each department.
SELECT department_name, MAX(salary) AS max_salary
FROM (SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee, d.dept_name AS department_name, s.salary AS salary
FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no
JOIN employees e
	ON de.emp_no = e.emp_no
JOIN salaries s
	ON e.emp_no = s.emp_no
WHERE de.to_date LIKE '9999-%'
	AND s.to_date LIKE '9999-%') AS salaries
GROUP BY department_name;