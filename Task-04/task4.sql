USE sql_training;

CREATE TABLE customers(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
	customer_name VARCHAR(30) NOT NULL,
    customer_email VARCHAR(50) UNIQUE
);

CREATE TABLE orders(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_name VARCHAR(50),
    order_date DATE,
    order_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


#Insert values to customer 
INSERT INTO customers (customer_name, customer_email) VALUES  
    ('Tony Stark', 'ironman@avengers.com'),  
    ('Steve Rogers', 'captain@avengers.com'),  
    ('Thor Odinson', 'thor@avengers.com'),  
    ('Bruce Banner', 'hulk@avengers.com'),  
    ('Natasha Romanoff', 'blackwidow@avengers.com'),  
    ('Clint Barton', 'hawkeye@avengers.com'),  
    ('Peter Parker', 'spiderman@avengers.com');
    
INSERT INTO orders (customer_id, product_name, order_date, order_amount) VALUES  
    (1, 'Pizza', '2025-03-01', 499.00),  
    (2, 'Cheese Burger', '2025-03-02', 249.00),  
    (3, 'Chicken Sandwich', '2025-03-03', 199.00),  
    (4, 'Chicken Pizza', '2025-03-04', 599.00),  
    (5, 'Veggie Burger', '2025-03-05', 229.00);
    
SELECT * FROM customers;
SELECT * FROM orders;

#To retrieve customer names along with their order details
#INNER JOIN
SELECT c.customer_name, o.order_id, o.product_name, o.order_date, o.order_amount
FROM customers as c
INNER JOIN orders as o ON c.customer_id = o.customer_id;

#LEFT JOIN (If there are no matching records, then that fields will be marked NULL)
SELECT c.customer_name, o.order_id, o.product_name, o.order_date, o.order_amount
FROM customers as c
LEFT JOIN orders as o ON c.customer_id = o.customer_id;

#RIGHT JOIN
SELECT c.customer_name, o.order_id, o.product_name, o.order_date, o.order_amount
FROM customers as c
RIGHT JOIN orders as o ON c.customer_id = o.customer_id;


