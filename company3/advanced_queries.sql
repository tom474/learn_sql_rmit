-- 0. Names of all employees whose salary is between 200 and 600
SELECT E.name
FROM employee E, position P
WHERE E.position = P.code
AND P.income BETWEEN 200 AND 600;

-- 0. Names of the departments and (total) number of employees who work there
SELECT D.name, COUNT(*)
FROM department D, employee E
WHERE E.department = D.code
GROUP BY D.code;

-- 0. Names of the supervisors and the number of employees who they supervise
SELECT S.name, COUNT(E.supervisor)
FROM employee E, employee S
WHERE E.supervisor = S.number
GROUP BY S.number;

-- 1. Names of the supervisors and the number of employees who they
-- supervise and these employees must not work in Hanoi
-- Solution 1
SELECT S.name, COUNT(*)
FROM employee E, employee S, department D
WHERE E.supervisor = S.number
AND E.department = D.code
AND D.location <> 'Hanoi'
GROUP BY S.number;

-- Solution 2
SELECT E1.number, E1.name, COUNT(E2.supervisor)
FROM employee E1, (
    SELECT E3.supervisor, E3.number
    FROM employee E3, department D
    WHERE E3.department = D.code
    AND D.location <> 'Hanoi'
) AS E2
WHERE E1.number = E2.supervisor
GROUP BY E1.number;

-- Solution 3
SELECT S.name, COUNT(E.supervisor)
FROM employee E, employee S
WHERE E.supervisor = S.number
AND E.department IN (
    SELECT D.code
    FROM department D
    WHERE D.location <> 'Hanoi'
)
GROUP BY S.number;

-- 2. Codes of the positions, names of the departments and the number of
-- employees who are holding those positions in the respective department
-- Solution 1
SELECT E.position, D.name, COUNT(*)
FROM department D, employee E
WHERE E.department = D.code
GROUP BY E.position, D.name;

-- Solution 2
SELECT nE.position, D.name AS Dept, nE.total
FROM department D, (
    SELECT position, department, COUNT(*) AS total
    FROM employee
    GROUP BY position, department
) AS nE
WHERE code = nE.department;

-- 3. Codes of the position, income for the position and the number of
-- employees in each position and the employees must not work in Hanoi
-- Solution 1
SELECT P.code, P.income, COUNT(*)
FROM position P, department D, employee E
WHERE E.position = P.code
AND E.department = D.code
AND D.location <> 'Hanoi'
GROUP BY P.code;

-- Solution 2
SELECT E.position, P.income, count(*)
FROM employee E, position P
WHERE E.position = P.code
AND E.department NOT IN (
    SELECT D.code
    FROM department D
    WHERE D.location = 'Hanoi'
)
GROUP BY E.position, P.income;

-- 4. Names of the employees, and respective annual incomes (12 months),
-- whose incomes are around the company’s average monthly income with a
-- maximum deviation of 100 dollars
-- Solution 1
SELECT E.name, P.income * 12
FROM employee E, position P
WHERE E.position = P.code
AND income - (
    SELECT AVG(income)
    FROM employee E2, position P2
    WHERE E2.position = P2.code
)
BETWEEN -100 AND 100;

-- Solution 2
SELECT E.name, P.income * 12 AS Annual_Income
FROM employee E, position P
WHERE E.position = P.code
AND ABS(P.income - (
    SELECT AVG(P.income)
    FROM employee E1, position P
    WHERE E1.position = P.code
)) <= 100;

-- 5. Names, income of ALL employees who work in Hanoi with highest salary
-- Solution 1
SELECT E.name, P.income
FROM employee E, position P, department D
WHERE E.position = P.code
AND E.department = D.code
AND D.location = 'Hanoi'
AND P.income = (
    SELECT MAX(income)
    FROM position P1, employee E1
    WHERE E1.position = P1.code
);

-- Solution 2
SELECT E.name, P.income
FROM employee E, position P, department D
WHERE E.position = P.code
AND E.department = D.code
AND D.location = 'Hanoi'
AND P.income >= ALL (
    SELECT income
    FROM position P1, employee E1
    WHERE E1.position = P1.code
);

-- 6. Names and number of supervisors who supervise the greatest number
-- of employees together with the number of employees they supervise
-- Solution 1
SELECT Super.number, Super.name, COUNT(*)
FROM employee Super,employee E
WHERE Super.number = E.supervisor
GROUP BY Super.number, Super.name
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*)
    FROM employee E
    WHERE supervisor IS NOT NULL
    GROUP BY supervisor
);

-- Solution 2
SELECT S.name, S.number, COUNT(E.supervisor)
FROM employee E, employee S
WHERE E.supervisor = S.number
GROUP BY S.number
HAVING COUNT(E.supervisor) >= ALL (
    SELECT COUNT(E1.supervisor)
    FROM employee E1, employee S1
    WHERE E1.supervisor = S1.number
    GROUP BY S1.number
);

-- Solution 3
SELECT t1.name, t1.number, t1.employee
FROM (
    SELECT S.name, S.number, COUNT(*) AS employee
    FROM employee S, employee E
    WHERE S.number = E.supervisor
    GROUP BY S.number
) AS t1
WHERE t1.employee = (
    SELECT MAX(t.employee)
    FROM (
        SELECT COUNT(*) AS employee
        FROM employee S, employee E
        WHERE S.number = E.supervisor
        GROUP BY S.number
    ) AS t
);

-- 7. Names of director, the department they manage and the
-- total number of employees in that department
SELECT Dir.name, D.name, COUNT(*) AS No_Employee
FROM department D, employee E, employee Dir
WHERE E.department = D.code
AND Dir.number = D.director
GROUP BY D.code;

-- 8. Names of director whose department has the most number of
-- employees together with the department name and the number of employees.
-- Solution 1
SELECT Dir.name, D.name, COUNT(*)
FROM employee E, department D, employee Dir
WHERE E.department = D.code
AND D.director = Dir.number
GROUP BY E.department
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*)
    FROM employee E1
    GROUP BY E1.department
);

-- Solution 2
SELECT E.name, D.name, dp_count.employees_count
FROM department D, employee E, (
    SELECT department, COUNT(*) AS employees_count
    FROM employee
    GROUP BY department
    HAVING COUNT(*) >= ALL (
        SELECT COUNT(*)
        FROM employee
        GROUP BY department
    )
) AS dp_count
WHERE D.director = E.number
AND D.code = dp_count.department;

-- 9. For each department with more than 3 employees, select
-- name, number of the director and the number of employees in the
-- department whose income is greater than 300.
-- Solution 1
SELECT Dir.name, Dir.number, COUNT(*)
FROM employee E, position P, employee Dir, department D
WHERE E.position = P.code
AND E.department = D.code
AND Dir.number = D.director
AND P.income > 300
AND E.department IN (
    SELECT E1.department
    FROM employee E1
    GROUP BY E1.department
    HAVING COUNT(*) > 2
)
GROUP BY D.code;

-- Solution 2
SELECT E.name, E.number, qualified_employees.em_count
FROM department D, employee E, (
    SELECT E.department, COUNT(*) AS em_count
    FROM employee E, position P
    WHERE E.position = P.code
    AND P.income > 300
    GROUP BY department
) AS qualified_employees -- Number of employees satisfied income > 300
WHERE D.director = E.number
AND E.department = qualified_employees.department
AND E.department IN (
    SELECT E.department
    FROM employee E
    GROUP BY department
    HAVING COUNT(*)> 2
) -- Department has more than 2 employees
GROUP BY E.name, E.number;

-- 10. For each department where the department average income
-- is greater than the company's average income, select the
-- employee with the lowest income in that department.
SELECT E1.number, E1.name
FROM employee E1, position P1
WHERE E1.position = P1.code
AND (E1.department, P1.income) IN (
    SELECT E.department, MIN(P.income)
    FROM employee E, position P
    WHERE E.position = P.code
    GROUP BY E.department
    HAVING AVG(P.income) > (
        SELECT AVG(P1.income)
        FROM employee E1, position P1
        WHERE E1.position = P1.code
    )
);

-- 11.For each position whose income is smaller than the
-- company's average income, select the average income of the
-- supervisors who supervise employees in those position.
SELECT E.position, AVG(Pos.income) AS Average_Income
FROM employee E, employee Sup, position Pos
WHERE E.supervisor = Sup.number
AND Sup.position = Pos.code
AND E.position IN (
    SELECT P.code
    FROM position P
    WHERE P.income < (
        SELECT AVG(P1.income)
        FROM employee E, position P1
        WHERE E.position = P1.code
    )
)
GROUP BY E.position;

-- 0. Codes of the positions and total number of employees of each
-- position who has a higher income than the company's average income.
-- Assume that a given position may NOT have any employee.
SELECT P.code, COUNT(E.number)
FROM position P
LEFT JOIN employee E
ON P.code = E.position
WHERE P.income > (
    SELECT AVG(income)
    FROM position P1, employee E1
    WHERE E1.position = P1.code
)
GROUP BY P.code;

-- 0. Names of the departments, positions' titles, starting dates
-- and names of the employees who were the first employees with these
-- positions. Assume that an employee cannot move to a different department.
SELECT P.code, D.name, P.title, H.start_date, E.name
FROM employee E, department D, position P, history H
WHERE H.position = P.code
AND E.department = D.code
AND H.employee = E.number
AND (P.code, H.start_date) IN (
    SELECT H1.position, MIN(H1.start_date)
    FROM history H1, employee E1
    WHERE H1.employee = E1.number
    GROUP BY H1.position
);

-- 1 Names of the departments and names of the respective employees
-- who have the highest incomes of the department.
SELECT D.name, E.name
FROM department D, employee E, position P
WHERE E.department = D.code
AND E.position = P.code
AND (E.department, P.income) IN (
    SELECT E1.department, MAX(P1.income)
    FROM employee E1, position P1
    WHERE E1.position = P1.code
    GROUP BY E1.department
);

-- 2. Names of the departments and codes of the positions which two
-- or more employees belong to.
SELECT D.name, E.position, COUNT(*)
FROM employee E, department D
WHERE E.department = D.code
GROUP BY D.name, E.position
HAVING COUNT(*) >= 2;

-- 3. Create a view, named employees_most_positions_department,
-- which has two columns: names of the departments and names of the
-- respective employees who already had more than 3 different
-- positions. Assume that an employee cannot move to a different department
CREATE OR REPLACE VIEW employees_most_positions_department AS
SELECT D.name AS Dept_Name, E.name AS Emp_Name, COUNT(*)
FROM employee E, department D, history H
WHERE E.department = D.code
AND E.number = H.employee
GROUP BY D.code, H.employee
HAVING COUNT(*) > 3;

-- 4. Names of the departments where the average income of the
-- respective employees is lower than all the average incomes of the
-- departments which their directors' names start with the letter P.
SELECT D.name, AVG(P.income)
FROM employee E, position P, department D
WHERE E.position = P.code
AND E.department = D.code
GROUP BY E.department
HAVING AVG(P.income) < (
    SELECT AVG(P1.income)
    FROM employee E1, position P1, department D1, employee Dir
    WHERE E1.position = P1.code
    AND E1.department = D1.code
    AND D1.director = Dir.number
    AND Dir.name LIKE 'P%'
);

-- 5. Names of the departments which have employees from all
-- positions. That is, names of the departments which there is no
-- position for which there are no employees who have that position.
-- Solution 1
SELECT D.name
FROM employee E, department D
WHERE E.department = D.code
GROUP BY E.department
HAVING COUNT(DISTINCT E.position) = (
    SELECT COUNT(*)
    FROM position
);

-- Solution 2
SELECT D.name
FROM department D
WHERE NOT EXISTS (
    SELECT *
    FROM position P
    WHERE NOT EXISTS (
        SELECT *
        FROM employee E
        WHERE E.position = P.code
        AND E.department = D.code
    )
);
