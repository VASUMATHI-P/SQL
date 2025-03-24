USE sql_training;

#To calculate average salary of employees
SELECT (SUM(salary) / COUNT(salary)) AS avg_salary 
FROM employees;

SELECT AVG(salary) AS avg_salary 
FROM employees;

#To count the number of employees per dept
SELECT 
	department, 
    COUNT(id) as employee_count
FROM employees 
GROUP BY department;

#To find the departments having average salary more than 75000
SELECT 
	department,
    AVG(salary) as avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 75000;

