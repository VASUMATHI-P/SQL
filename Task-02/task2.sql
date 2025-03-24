USE sql_training;

SELECT * FROM employees WHERE department = "HR" OR department = "IT" ORDER BY department, salary;

SELECT * from Employees WHERE age > 25 AND (department = "HR" OR department = "Finance") ORDER BY age DESC;