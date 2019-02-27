-- Create a new file named 3.5.2_order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.
USE employees;


-- Modify your first query to order by first name. The first result should be Irena Reutenauer and the last result should be Vidya Simmen.
SELECT *
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

-- Update the query to order by first name and then last name. The first result should now be Irena Acton and the last should be Vidya Zweizig.
SELECT *
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

-- Change the order by clause so that you order by last name before first name. Your first result should still be Irena Acton but now the last result should be Maya Zyda.
SELECT *
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- Update your queries for employees with 'E' in their last name to sort the results by their employee number. Your results should not change!
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
ORDER BY emp_no;

-- Now reverse the sort order for both queries.
SELECT *
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY last_name DESC, first_name DESC;

SELECT *
FROM employees
WHERE last_name LIKE 'E%'
ORDER BY emp_no DESC;

-- Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last. It should be Khun Bernini.
SELECT *
FROM employees
WHERE (hire_date LIKE '199%')
AND birth_date LIKE '%-12-25'
ORDER BY birth_date ASC, hire_date DESC;