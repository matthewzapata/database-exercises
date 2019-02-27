USE employees;
-- lists all tables in the employees DB
SHOW tables;
-- different datatypes in the employees table
DESCRIBE employees;
-- numeric type: dept_emp, dept_manager, employees, salaries, titles
-- string type: departments, dept_emp, dept_manager, employees, titles
-- date type: dept_emp, dept_manager, employees, salaries, titles
DESCRIBE employees;
DESCRIBE departments;
-- the dept_emp table relates the departments table to the employees table, showing employees and their dept
DESCRIBE dept_emp;
-- shows the SQL of the dept_manager table, "open value in viewer"
SHOW CREATE TABLE dept_manager;