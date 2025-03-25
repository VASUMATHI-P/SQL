USE sql_training;

# PROCEDURE
-- Performs a set of operations (e.g., inserts, updates, deletes, calculations)
-- Can return using OUT parameters
-- Cannot be used in SELECT statements

# Procedure to calculate Total orders in the given date range
DELIMITER $$
CREATE PROCEDURE calculate_orders (IN start_date DATE, IN end_date DATE, OUT total_orders INT)
BEGIN
SELECT COUNT(order_id) INTO total_orders FROM orders WHERE order_date between start_date AND end_date;
END $$
DELIMITER ;

# Calling the procedure
SET @total_orders = 0;
CALL calculate_orders('2025-03-01', '2025-03-15', @total_orders);
SELECT @total_orders;



# FUNCTIONS
-- simple reusable calculation
-- Must return a single value using return
-- Can be used in SELECT, WHERE, and JOIN

# Function to calculate the bonus for employee based on their salary
DELIMITER $$
CREATE FUNCTION calculate_bonus(salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE bonus DECIMAL(10,2);
    IF salary < 60000 THEN
		SET bonus = salary * 0.10;
	ELSEIF salary < 75000 THEN
		SET bonus = salary * 0.07;
	ELSE
		SET bonus = salary * 0.05;
	END IF;
    RETURN bonus;
END $$

DELIMITER ;

# Calling the function using SELECT
SELECT 
	id, 
    name, 
    department, 
    salary, 
    calculate_bonus(salary) 
FROM employees ORDER BY department;
