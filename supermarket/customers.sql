-- Create the customers table
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    id INT NOT NULL,
    first_name VARCHAR(10),
    last_name VARCHAR(10),
    address VARCHAR(100),
    PRIMARY KEY (id)
);

-- Insert some values into customers table
INSERT INTO customers
VALUES 
(1, 'John', 'Doe', '32 Cherry Blvd'),
(2, 'Angela', 'Yu', '12 Sunset Drive');

-- Select a customer with first_name = 'John'
SELECT *
FROM customers
WHERE first_name = 'John';
