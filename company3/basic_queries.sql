-- 1. Names of the employees and names of the respective departments where they work.
SELECT E.name, D.name
FROM employee E, department D
WHERE E.department = D.code;

-- 2. Names of employees (pair) who work at the same department
SELECT E1.number ,E1.name, E1.department, E2.number, E2.name, E2.department
FROM employee E1, employee E2
WHERE E1.department = E2.department
AND E1.number > E2.number;

-- 3. Calculate income increment (+50) for employees who have started 
-- working before 1/1/2012. Do not list repetitive records
SELECT DISTINCT E.name, P.income + 50 AS new_income
FROM employee E, position P, history H
WHERE E.position = P.code
AND E.number = H.employee
AND H.start_date < '2012-01-01';

-- 4. Name and position of employee who have double or higher income than other.
-- Solution 1
SELECT DISTINCT E.name, P1.title, P1.income
FROM employee E, position P1, position P2
WHERE E.position = P1.code AND P1.income >= P2.income * 2;

-- Solution 2
SELECT E1.name, E1.position
FROM employee E1
WHERE E1.position IN (
    SELECT P1.code
    FROM position P1, position P2
    WHERE P1.income >= P2.income * 2
);

-- Solution 3
SELECT DISTINCT E1.name, E1.position, P1.income
FROM employee E1, employee E2, position P1, position P2
WHERE E1.position = P1.code
AND E2.position = P2.code
AND P1.income >= P2.income * 2;

-- Solution 4
SELECT E.name, E.position, P.income
FROM employee E, position P
WHERE E.position = P.code
AND P.income >= ANY (
    SELECT P1.income * 2
    FROM position P1
);

-- 5. Number, name and income of employees whose names start with L and has at least 3 characters
SELECT E.number, E.name, P.income
FROM employee E, position P
WHERE E.position = P.code
AND E.name LIKE 'L__%';

-- 6. Union employees from DP1 and DP2 department, listing number, name and position
SELECT E.number, E.name, E.position, E.department
FROM employee E
WHERE E.department = 'DP1'
UNION
SELECT E.number, E.name, E.position, E.department
FROM employee E
WHERE E.department = 'DP2';

-- 7. Names of the departments and names of the respective employees 
-- who are supervisors and directors of the department.
-- Solution 1
SELECT department.name, employee.name
FROM employee, department
WHERE director = number
AND director = ANY (
    SELECT DISTINCT supervisor
    FROM employee
);

-- Solution 2
SELECT D.name, E.name
FROM employee E, department D
WHERE E.department = D.code
AND (E.supervisor IS NULL OR E.supervisor = E.number)
AND E.number = D.director;

-- Solution 3
SELECT E2.name, D.name
FROM employee E1, department D, employee E2
WHERE E1.supervisor = E2.number
AND E2.number = D.director;

-- 9. Code of the positions and names of the departments where these positions exist.
SELECT DISTINCT E.position, D.name
FROM department D, employee E
WHERE E.department = D.code;

-- 10. Using EXIST, write this query: Names of the departments and names of the respective employees
-- who are supervisors and directors of the department.
SELECT Director.name, D.name
FROM employee Director, department D
WHERE Director.number = D.director
AND EXISTS (
    SELECT *
    FROM employee E
    WHERE E.supervisor = Director.number
);

-- 11. Numbers of the employees who are directors or supervisors (use Set Operators).
-- Solution 1
SELECT DISTINCT E.supervisor
FROM employee E
WHERE E.supervisor IS NOT NULL
UNION
SELECT DISTINCT director
FROM department D
WHERE NOT (D.director <=> NULL);

-- Solution 2
SELECT E.number, E.name
FROM employee E
WHERE E.number IN (
    SELECT E1.supervisor
    FROM employee E1
    WHERE E1.supervisor IS NOT NULL
)
OR E.number IN (
    SELECT D.director
    FROM department D
);

-- Solution 3
SELECT E1.number
FROM employee E1, employee E2
WHERE E1.number = E2.supervisor
UNION
SELECT E3.number
FROM employee E3, department D
WHERE E3.number = D.director;

-- 12.Codes of the positions which belonged to employees of departments
-- located in Hanoi, and currently are positions of employees of
-- departments whose director's name starts with the letter P. 
-- (Assume that an employee cannot change department). [No sub queries needed here]
SELECT E1.position
FROM department D, employee E1, employee Dir
WHERE E1.department = D.code
AND D.location = 'Hanoi'
AND Dir.number = D.director
AND Dir.name LIKE 'P_%';

-- 13. Names, incomes, and department names of the supervisors who do
-- not supervised employees who work in Hanoi.
-- Solution 1
SELECT Sup.name, P.income, D1.name
FROM employee Sup, employee E2, position P, department D1
WHERE P.code = Sup.position
AND D1.code = Sup.department
AND E2.supervisor = Sup.number
AND E2.department NOT IN (
    SELECT D2.code
    FROM department D2
    WHERE D2.location = 'Hanoi'
);

-- Solution 2
SELECT DISTINCT E1.name, P.income, D.name
FROM employee E1, position P , department D
WHERE E1.position = P.code
AND E1.department = D.code
AND E1.number IN (
    SELECT E2.supervisor
    FROM employee E2
    WHERE E2.department NOT IN (
        SELECT D1.code
        FROM department D1
        WHERE D1.location = 'Hanoi'
    )
);

-- 14. Name of employee with highest income
-- Solution 1
SELECT E.name, P.income
FROM employee E, position P
WHERE E.position = P.code
AND P.income >= ALL (
    SELECT income 
    FROM position
);

-- Solution 2
SELECT E.name, P.income
FROM employee E, position P
WHERE E.position = P.code
AND P.income = (
    SELECT MAX(P2.income)
    FROM position P2, employee E2
    WHERE E2.position = P2.code
);

-- 15. Names and id of employees who supervise at least one another person.
-- Solution 1
SELECT E1.name, E1.number
FROM employee E1
WHERE E1.number IN (
    SELECT supervisor
    FROM employee
    WHERE supervisor IS NOT NULL
);

-- Solution 2
SELECT name, number AS ID
FROM employee
WHERE number = ANY (
    SELECT supervisor
    FROM employee
);

-- Solution 3
SELECT DISTINCT S.number, S.name
FROM employee S, employee E
WHERE S.number = E.supervisor;

-- 16. Names of employees whose salary is higher than all employees in department DP1
SELECT E.name
FROM employee E, position P
WHERE E.position = P.code
AND P.income > ALL (
    SELECT income
    FROM employee E1, position P1
    WHERE E1.position = P1.code
    AND E1.department = 'DP1'
);

-- 17. Names and id of employees who do not supervise anyone
-- Solution 1
SELECT name, E1.number ID
FROM employee E1
WHERE NOT EXISTS (
    SELECT *
    FROM employee E2
    WHERE E1.number = E2.supervisor
);

-- Solution 2
SELECT E.name, E.number
FROM employee E
WHERE E.number NOT IN (
    SELECT E1.supervisor
    FROM employee E1
    WHERE E1.supervisor IS NOT NULL
);

-- 18. Names of employees who supervise all employees who work in HCMC
-- Solution 1
SELECT name
FROM employee
WHERE number = ALL (
    SELECT supervisor
    FROM employee, department
    WHERE department = code
    AND location = 'HCMC'
);

-- Solution 2
SELECT Sup.name
FROM employee Sup
WHERE NOT EXISTS (
    SELECT *
    FROM employee E, department D
    WHERE E.department = D.code
    AND NOT (E.supervisor <=> Sup.number)
    AND D.location = 'HCMC'
);

-- Solution 3
SELECT Sup.name
FROM employee Sup
WHERE NOT EXISTS (
    SELECT *
    FROM employee E, department D
    WHERE E.department = D.code
    AND (E.supervisor <> Sup.number OR E.supervisor IS NULL)
    AND D.location = 'HCMC'
);
