SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS history;
DROP TABLE IF EXISTS commission;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS position;
DROP VIEW IF EXISTS employee_more_positions_per_department;

CREATE TABLE position (
    code VARCHAR(3),
    title VARCHAR(50) NOT NULL,
    income INT NOT NULL,
    CONSTRAINT pk_position PRIMARY KEY(code)
);

CREATE TABLE employee (
    number INT UNSIGNED,
    name VARCHAR(50) NOT NULL,
    position VARCHAR(3),
    department VARCHAR(3),
    supervisor INT UNSIGNED,
    CONSTRAINT pk_employee PRIMARY KEY(number),
    CONSTRAINT fk_employee_position FOREIGN KEY (position) REFERENCES position (code)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_employee_department FOREIGN KEY (department) REFERENCES department (code)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_employee_supervisor FOREIGN KEY (supervisor) REFERENCES employee (number)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE department (
    code VARCHAR(3),
    name VARCHAR(150) NOT NULL,
    location VARCHAR(50) NOT NULL,
    director INT UNSIGNED,
    CONSTRAINT pk_department PRIMARY KEY(code),
    CONSTRAINT fk_department_director FOREIGN KEY (director) REFERENCES employee(number)
);

CREATE TABLE commission (
    employee INT UNSIGNED,
    date DATE NOT NULL,
    value INT NOT NULL,
    CONSTRAINT pk_commission PRIMARY KEY(employee, date),
    CONSTRAINT fk_commission_employee FOREIGN KEY (employee) REFERENCES employee(number)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE history (
    employee INT UNSIGNED,
    position VARCHAR(3),
    start_date DATE,
    CONSTRAINT pk_history PRIMARY KEY(employee, position, start_date),
    CONSTRAINT fk_history_employee FOREIGN KEY (employee) REFERENCES employee (number)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_history_position FOREIGN KEY (position) REFERENCES position (code)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

INSERT INTO position (code, title, income) 
VALUES 
('CS1', 'Salesman', 100);
('CS2', 'Manager', 400),
('CS3', 'Development director', 300),
('CS4', 'Digital strategy manager', 600),
('CS5', 'Director of communications', 700);

INSERT INTO employee (number, name, position, department, supervisor)
VALUES
(1, 'George Constanza', 'CS2', 'DP1', 4),
(2, 'Anna Nguyen', 'CS5', 'DP1', NULL),
(3, 'Peter', 'CS3', 'DP2', 3),
(4, 'Liam', 'CS3', 'DP1', 2),
(5, 'Mason', 'CS1', 'DP3', 8),
(6, 'Jacob', 'CS2', 'DP3', NULL),
(7, 'William','CS4', 'DP2', 9),
(8, 'Ethan', 'CS5', 'DP1', NULL),
(9, 'Liam', 'CS4', 'DP2', 10),
(10, 'James', 'CS3', 'DP3', NULL),
(11, 'Mary', 'CS4', 'DP2', 9),
(12, 'John', 'CS1', 'DP1', NULL),
(13, 'Hang', 'CS4', 'DP1', NULL);

INSERT INTO department (code, name, location, director)
VALUES
('DP1', 'Sales Department', 'Hanoi', 2),
('DP2', 'Research Department', 'Hanoi', 3),
('DP3', 'International Department', 'HCMC', 5);

INSERT INTO commission(employee, date, value)
VALUES
(1,'2016-07-30', 50),
(1,'2016-08-12', 150),
(2,'2015-07-30', 550),
(3,'2016-06-10', 550),
(5,'2009-03-01', 300),
(5,'2009-02-10', 250),
(7,'2012-08-12', 100),
(7,'2010-08-12', 150);

INSERT INTO history (employee, position, start_date)
VALUES
(1,'CS1', '2015-01-10'),
(1,'CS4', '2017-05-07'),
(1,'CS3', '2017-03-09'),
(1,'CS5', '2013-04-10'),
(2,'CS1', '2013-01-10'),
(4,'CS3', '2014-05-07'),
(7,'CS1', '2011-05-07'),
(7,'CS2', '2011-05-07'),
(7,'CS3', '2011-05-07'),
(7,'CS5', '2014-01-01');

COMMIT;
SET FOREIGN_KEY_CHECKS = 1;
