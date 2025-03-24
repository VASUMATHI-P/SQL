USE sql_training;

#To find the employees who have salary more than the average salary of the department
SELECT id, name, department, salary 
FROM employees e
WHERE salary > (
	SELECT AVG(salary) AS avg_salary
    FROM employees
    WHERE department = e.department
) ORDER BY department;

#dynamic column - department_avg_salary 
#It is computed during query run time 
SELECT
	id,
    name,
    department,
    salary,
    (SELECT AVG(salary) FROM employees WHERE department = e.department) AS department_avg_salary
FROM employees e ORDER BY department;

#Non-correlated subquery
#Runs once before the outer query. Independent. 
SELECT id, name, age, department, salary 
FROM employees 
WHERE salary > ( SELECT AVG(salary) FROM employees );

#Correlated subquery
#Runs for every row. Dependent on the outer query
SELECT id, name, department, salary 
FROM employees e
WHERE salary > (
    SELECT AVG(salary) 
    FROM employees 
    WHERE department = e.department
);
