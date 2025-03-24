USE sql_training;

INSERT INTO orders (customer_id, product_name, order_date, order_amount) VALUES  
    (1, 'Cheeseburger', '2024-11-05', 250.00),  
    (2, 'Pepperoni Pizza', '2024-11-18', 450.00),  
    (3, 'BBQ Chicken Wings', '2024-12-02', 320.00),  
    (4, 'Vegetable Sandwich', '2024-12-22', 180.00),  
    (5, 'Spaghetti Bolognese', '2025-01-08', 380.00),  
    (6, 'Sushi Platter', '2025-01-19', 650.00),  
    (7, 'Chocolate Milkshake', '2025-01-25', 200.00),  
    (1, 'Double Cheeseburger', '2025-02-05', 300.00),  
    (2, 'Grilled Chicken Wrap', '2025-02-15', 350.00),  
    (3, 'Blueberry Pancakes', '2025-03-01', 280.00),  
    (4, 'Strawberry Smoothie', '2025-03-12', 220.00),  
    (5, 'Beef Steak', '2025-03-20', 750.00),
    (6, 'Vegetable Sandwich', '2025-03-24', 180.00);


# To find orders placed within 30 days
SELECT order_id, customer_id, product_name, order_date
FROM orders
WHERE DATEDIFF(CURDATE(), order_date) <= 30;

# To calculate the estimate delivery date by adding 7 days to order date
SELECT order_id, customer_id, product_name, order_date, 
	DATE_ADD(order_date, INTERVAL 1 WEEK) AS estimated_delivery_date
FROM orders WHERE order_date = CURDATE();

# To format order_date as 'DD-MM-YYYY' using DATE_FORMAT
SELECT order_id, customer_id, product_name, 
	DATE_FORMAT(order_date, '%d-%m-%Y') AS formatted_order_date
FROM orders;

# To format order_date like 'March 24, 2025' using DATE_FORMAT
SELECT order_id, customer_id, product_name, 
	DATE_FORMAT(order_date, '%M %e, %Y') AS formatted_order_date
FROM orders;