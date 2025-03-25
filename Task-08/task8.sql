use sql_training;

CREATE TABLE employee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    manager_id INT NULL,
    FOREIGN KEY (manager_id) REFERENCES employee(id)
);

INSERT INTO employee (name, department, salary, manager_id) VALUES
('Alice', 'Management', 150000.00, NULL),  
('Bob', 'IT', 90000.00, 1),                
('Charlie', 'IT', 85000.00, 1),            
('Dave', 'HR', 60000.00, 2),               
('Eve', 'HR', 65000.00, 2),                
('Frank', 'Finance', 70000.00, 3),         
('Grace', 'Finance', 75000.00, 3);         

# Non recursive CTE
#To find the employees earning more than the average salary of their department
WITH dept_avg_salary AS (
	SELECT department, AVG(salary) AS avg_salary 
    FROM employee
    GROUP BY department
)
SELECT e.id, e.name, e.department, ds.avg_salary, e.salary 
FROM employee AS e 
INNER JOIN dept_avg_salary AS ds ON e.department = ds.department 
WHERE e.salary > ds.avg_salary;


# RECURSIVE CTE
-- First time: Only the base query runs.
-- Recursive query starts after the base query finishes.
-- Recursive query runs multiple times, processing level by level.
-- Recursion stops when no more employees match.

# To find their level in the management heirarchy
WITH RECURSIVE employee_hierarchy AS(
	-- Base query
	SELECT id, name, manager_id, 1 AS level
    FROM employee
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive query
    SELECT e.id, e.name, e.manager_id, eh.level+1
    FROM employee AS e INNER JOIN employee_hierarchy AS eh
    ON e.manager_id = eh.id
)
    
SELECT * FROM employee_hierarchy;
