-- Delete the tables if they already exist
DROP TABLE IF EXISTS dept;
DROP TABLE IF EXISTS emp;

-- Create the dept table
CREATE TABLE dept (
    dept_no INT PRIMARY KEY,
    dept_name VARCHAR(14) NOT NULL,
    loc VARCHAR(13)
);

-- Create the emp table
CREATE TABLE emp (
    emp_no INT PRIMARY KEY,
    emp_name VARCHAR(10),
    job VARCHAR(9),
    mgr INT,
    hire_date DATE,
    sal INT,
    comm INT,
    dept_no INT,
    FOREIGN KEY (dept_no) REFERENCES dept(dept_no)
);

-- Insert some values into dept table
INSERT INTO dept
VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

-- Insert some values into emp table
INSERT INTO emp
VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-12-17', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1980-02-17', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '1982-12-17', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1980-12-01', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-02-17', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1982-12-7', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1983-02-17', 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1980-12-07', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1980-02-17', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1980-12-1', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1982-02-17', 950, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-01-17', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1980-12-7', 1300, NULL, 10);
