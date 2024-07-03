-- ---------- Integrity Constraints Violations Examples ----------

-- UNIQUE / PRIMARY KEY VIOLATION -- (same sid) => returns error 'duplicate entry'
INSERT INTO students
VALUES 
(682634, 'AnotherJohn', 'Costa', 10, 1.0);

-- UNIQUE / PRIMARY KEY VIOLATION -- (id 123456 already existed) => returns error 'duplicate entry'
UPDATE students
SET sid = 123456
WHERE (sid = 603111);

-- INSERTING A NULL PRIMARY KEY  => returns error 'sid cannot be null'
INSERT INTO students
VALUES
(null, 'Anna', 'Barbosa', 1, 0);

-- INCORRECT VALUE FOR FOREIGN KEY -- (there is no student with id 111111) => returns error about syntax
INSERT INTO enrolled
VALUES (111111, 'MATH2239', 'D');

-- DELETING A REFERENCED VALUE (the student 123456 is referenced by two rows from table enrolled) => returns error: cannot delete ...
DELETE FROM students
WHERE sid = 123456;

-- UPDATING A REFERENCED VALUE (the student 123456 is referenced by two rows from table enrolled) => returns error: cannot delete ...
UPDATE students
SET sid = 555555
WHERE (sid = 123456);

-- ---------- ON DELETE CASCADE and ON UPDATE CASCADE Examples ----------

-- Create the enrolled table
DROP TABLE IF EXISTS enrolled;
CREATE TABLE enrolled (
    sid INT,
    cid VARCHAR(20),
    grade CHAR(1) NOT NULL,
    -- PRIMARY KEY
    CONSTRAINT pk_enrolled PRIMARY KEY (sid, cid),
    -- FOREIGN KEY
    CONSTRAINT fk_enrolled_sid FOREIGN KEY (sid) REFERENCES students(sid)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Insert some values into enrolled table
INSERT INTO enrolled
VALUES
(123456, 'MATH2239', 'D'),
(123456, 'MATH2240', 'D'),
(682634, 'ISYS2077', 'A'),
(632461, 'ISYS2040', 'C');

-- DELETING A REFERENCED VALUE
-- In this case the student 682634 and its references will be deleted from the database
DELETE FROM students WHERE sid = 682634;

-- Check content of tables students and enrolled
SELECT *
FROM students;

SELECT *
FROM enrolled;

-- UPDATING A REFERENCED VALUE
-- In this case the id of the the student 123456 will be update and all its references
UPDATE students SET sid = 555555 WHERE (sid = 123456);

-- Check content of tables students and enrolled
SELECT *
FROM students;

SELECT *
FROM enrolled;
