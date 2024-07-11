-- Add a new employee named Swanton in department 30. Swanton unique number is 7999
INSERT INTO emp (emp_no, emp_name, dept_no)
VALUES
(7999, 'Swanton', 30);

-- Increase the salary of all clerks by $500
UPDATE emp
SET sal = sal + 500
WHERE job = "CLERK";

-- How much will it cost the company if we give a rise of 20% of the salary of all salesmen?
SELECT SUM(sal * 1.2) AS cost
FROM emp
WHERE job = 'SALESMAN';

-- Who is the manager of the employee Allen?
SELECT M.emp_name
FROM emp E, emp M
WHERE E.emp_name = 'Allen' and E.mgr = M.emp_no;

-- Find the total salary of all employees in the research department
SELECT SUM(E.sal) AS total_salary
FROM emp E, dept D
WHERE E.dept_no = D.dept_no AND D.dept_name = 'RESEARCH';

-- What is the average salary of an employee in the company?
SELECT AVG(sal)
FROM emp;

-- For each manager, list his/her name plus names and jobs of all the employees he/she manages
SELECT E.mgr, M.emp_name, E.emp_no, E.emp_name, E.job
FROM emp E, emp M
WHERE M.emp_no = E.mgr
ORDER BY M.emp_name;

-- Find the subtotal salaries for all Clerks, Analysts and Salesmen
-- Then list the names and salaries of all employees who fit in those categories ordered by the job and salaries within that job
SELECT job, SUM(sal)
FROM emp
GROUP BY job
HAVING job IN ('CLERK', 'SALESMAN', 'ANALYST');

SELECT job, emp_name, sal
FROM emp
WHERE job IN ('CLERK', 'SALESMAN', 'ANALYST')
ORDER BY job, sal;

-- For both the Accounting and the Sales departments, list the names and salaries for all their employees and the average and maximum salary within each department
SELECT D.dept_name, SUM(sal), AVG(sal), MAX(sal)
FROM emp E, dept D
WHERE E.dept_no = D.dept_no AND (D.dept_name = 'ACCOUNTING' OR D.dept_name = 'SALES')
GROUP BY D.dept_no;

-- Sack all managers and delete all their data
DELETE FROM emp
WHERE emp_no IN (
    SELECT *
    FROM (SELECT mgr FROM emp) AS manager
);
