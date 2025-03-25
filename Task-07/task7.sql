# Window functions calculate values for each row while looking at a specific group of rows (a "window"). 

# Windows Functions
--   ROW_NUMBER() → Gives a unique number to each row.

--   RANK() → Assigns the same rank for ties but skips numbers.

--   DENSE_RANK() → Assigns the same rank for ties but doesn’t skip numbers.

--   LAG() → Gets the previous row’s value.

--   LEAD() → Gets the next row’s value.

USE sql_training;

# To rank employees by salary within each department
SELECT id, name, department, salary,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS row_num,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank_num,
    LAG(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS prev_salary,
    LEAD(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS next_salary
FROM employees;
