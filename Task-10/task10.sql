DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

CREATE TABLE orderdetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

INSERT INTO customers (name, email, phone) VALUES
('Alice Johnson', 'alice@example.com', '9876543210'),
('Bob Smith', 'bob@example.com', '8765432109'),
('Charlie Brown', 'charlie@example.com', '7654321098'),
('David Wilson', 'david@example.com', '6543210987'),
('Emma Davis', 'emma@example.com', '5432109876');

INSERT INTO products (name, category, price, stock_quantity) VALUES
('Laptop', 'Electronics', 75000.00, 2),
('Smartphone', 'Electronics', 50000.00, 20),
('Headphones', 'Accessories', 2500.00, 50),
('Backpack', 'Bags', 2000.00, 30),
('Gaming Mouse', 'Accessories', 1500.00, 40);

-- Create Trigger to auto-update stock in products
DELIMITER //
CREATE TRIGGER trg_update_stock
AFTER INSERT ON orderdetails
FOR EACH ROW
BEGIN
    DECLARE stock_left INT;
    -- Get available stock
    SELECT stock_quantity INTO stock_left FROM products WHERE product_id = NEW.product_id;
    
    -- Prevent negative stock
    IF stock_left < NEW.quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough stock available!';
    ELSE
        UPDATE products 
        SET stock_quantity = stock_quantity - NEW.quantity 
        WHERE product_id = NEW.product_id;
    END IF;
END;
//
DELIMITER ;

-- Step 8: Transactions for Orders
START TRANSACTION;
INSERT INTO orders (customer_id, total_amount) VALUES (1, 52500.00);
SET @order_id1 = LAST_INSERT_ID();
INSERT INTO orderdetails (order_id, product_id, quantity, price) VALUES
(@order_id1, 2, 1, 50000.00), 
(@order_id1, 3, 1, 2500.00);
COMMIT;

START TRANSACTION;
INSERT INTO orders (customer_id, total_amount) VALUES (2, 77000.00);
SET @order_id2 = LAST_INSERT_ID();
INSERT INTO orderdetails (order_id, product_id, quantity, price) VALUES
(@order_id2, 1, 1, 75000.00), 
(@order_id2, 4, 1, 2000.00);
COMMIT;

START TRANSACTION;
INSERT INTO orders (customer_id, total_amount) VALUES (3, 51500.00);
SET @order_id3 = LAST_INSERT_ID();
INSERT INTO orderdetails (order_id, product_id, quantity, price) VALUES
(@order_id3, 2, 1, 50000.00), 
(@order_id3, 5, 1, 1500.00);
COMMIT;

-- Indexing for Optimization
CREATE INDEX idx_email ON customers(email);
CREATE INDEX idx_category_price ON products(category, price);
CREATE INDEX idx_orders ON orders(customer_id, order_date);
CREATE INDEX idx_orderdetails_order ON orderdetails(order_id);
CREATE INDEX idx_orderdetails_product ON orderdetails(product_id);

EXPLAIN SELECT * FROM customers WHERE email = "alice@example.com";
SELECT * FROM orders;
SELECT * FROM orders WHERE customer_id = 1 AND order_date = '2025-03-27';
SELECT * FROM products WHERE CATEGORY = 'Electronics' AND price BETWEEN 50000 AND 100000;
SELECT * FROM orderdetails WHERE order_id = 1;
SELECT * FROM orderdetails WHERE product_id = 1;


--  Query to Check if Trigger Works (Stock Quantity Should Update)
SELECT product_id, name, stock_quantity FROM products;

-- Create View for Customer Order Summary
CREATE VIEW customer_order_summary AS
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders, SUM(o.total_amount) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- Queries to Use the View
SELECT * FROM customer_order_summary WHERE total_orders != 0;
SELECT * FROM customer_order_summary WHERE total_spent > 75000;
