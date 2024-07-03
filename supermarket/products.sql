-- Create the products table
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id INT NOT NULL,
    name VARCHAR(10),
    price DECIMAL(8, 2),
    PRIMARY KEY (id)
);

-- Insert a product into products table
INSERT INTO products
VALUES 
(1, 'Pen', 1.20);

-- Select a product with id = 1
SELECT *
FROM products
WHERE id = 1;

-- Insert a product with no price into products table
INSERT INTO products (id, name)
VALUES 
(2, 'Pencil');

-- Select a product with id = 2
SELECT *
FROM products
WHERE id = 2;

-- Update a row in product table
UPDATE products
SET price = 0.8
WHERE id = 2;

-- Select all records from products table
SELECT *
FROM products;

-- Add a new column - stock - to the products table
ALTER TABLE products
ADD stock INT;

-- Update a row in product table
UPDATE products
SET stock = 32
WHERE id = 1;

-- Select all records from products table
SELECT *
FROM products;

-- Delete a row from products table
DELETE FROM products
WHERE id = 2;

-- Select all records from products table
SELECT *
FROM products;

-- Insert back the deleted row into products table
INSERT INTO products
VALUES
(2, 'Pencil', 0.8, 12);

-- Select all records from products table
SELECT *
FROM products;
