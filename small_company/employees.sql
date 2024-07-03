-- Create the employees table
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT,
    last_name VARCHAR(20),
    first_name VARCHAR(20),
    salary INT,
    dept_id INT,
    PRIMARY KEY (employee_id)
);

-- Insert data into the employees table
INSERT INTO employees
VALUES
(1001, 'Smith', 'John', 62000, 500),
(1002, 'Nguyen', 'Jane', 57600, 500),
(1003, 'Tran', 'Hang', 71000, 501),
(1004, 'Le', 'Nguyen', 42000, 502);

-- Select all the records from the employees table
SELECT *
FROM employees;

-- Select all the records from the employees table whose salary is less than or equal to $52,500
SELECT *
FROM employees
WHERE salary <= 52500;

-- Update the salary for "Smith John" to $62500
UPDATE employees
SET salary = 62500
WHERE first_name = 'John';

-- Update the dept_id for all the records whose dept_id equals to “501” to “5001”
UPDATE employees
SET dept_id = 5001
WHERE dept_id = 501;

-- Delete the employee whose name is “Smith John” from the table
DELETE FROM employees
WHERE first_name = 'John';

-- Delete all employees whose dept_ID equals to 500
DELETE FROM employees
WHERE dept_id = 500;

-- Delete all employees whose salary is less than $50,000 and belongs to department “5001”
DELETE FROM employees
WHERE salary < 50000 AND dept_id = 5001;

-- Delete table employees
DROP TABLE employees;
