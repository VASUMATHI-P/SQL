
CREATE DATABASE sql_training;
USE sql_training;

CREATE TABLE employees (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(25),
    department VARCHAR(25),
    salary INTEGER,
    email VARCHAR(50) UNIQUE,
    age INTEGER
);

INSERT INTO employees (name, department, salary, email, age)  
VALUES  
    ('Monkey D. Luffy', 'IT', 85000, 'luffy@gmail.com', 22),  
    ('Roronoa Zoro', 'HR', 58000, 'zoro@gmail.com', 27),  
    ('Nami', 'Finance', 92000, 'nami@gmail.com', 25),  
    ('Usopp', 'Marketing', 72000, 'usopp@gmail.com', 24),  
    ('Sanji', 'Sales', 65000, 'sanji@gmail.com', 26),  
    ('Tony Tony Chopper', 'IT', 78000, 'chopper@gmail.com', 20),  
    ('Nico Robin', 'HR', 60000, 'robin@gmail.com', 30),  
    ('Franky', 'Finance', 88000, 'franky@gmail.com', 36),  
    ('Brook', 'Marketing', 71000, 'brook@gmail.com', 90),  
    ('Jinbe', 'Sales', 68000, 'jinbe@gmail.com', 45),  
    ('Portgas D. Ace', 'IT', 91000, 'ace@gmail.com', 23),  
    ('Trafalgar Law', 'HR', 59000, 'law@gmail.com', 29),  
    ('Boa Hancock', 'Finance', 97000, 'hancock@gmail.com', 28),  
    ('Shanks', 'Marketing', 75000, 'shanks@gmail.com', 39),  
    ('Dracule Mihawk', 'Sales', 64000, 'mihawk@gmail.com', 43),  
    ('Bon Clay', 'HR', 62000, 'bonchan@gmail.com', 35);  


SELECT * FROM employees;
