-- Drop the enrolled table if already exists
DROP TABLE IF EXISTS enrolled;

-- Create the students table
DROP TABLE IF EXISTS students;
CREATE TABLE students (
    sid INT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    age INT NOT NULL,
    gpa REAL(2, 1) NOT NULL,
    -- PRIMARY KEY
    CONSTRAINT pk_student PRIMARY KEY (sid)
);

-- Insert some values into students table
INSERT INTO students
VALUES 
(474747, 'Cuong', 'Tran', 20, 4.0),
(682634, 'John', 'Smith', 20, 3.0),
(632461, 'Phu', 'Nguyen', 21, 1.0),
(612352, 'Thong', 'Nguyen', 19, 2.7),
(603111, 'Tam', 'Quach', 20, 0.8),
(123456, 'Donald', 'Trump', 23, 0.1);

-- Select all records from students table
SELECT *
FROM students;

-- Update the student's gpa
UPDATE students S
SET S.gpa = S.gpa * 1.5
WHERE S.gpa < 1;

-- Select all records from students table
SELECT *
FROM students;

-- Delete a student with first_name = 'Cuong'
DELETE FROM students
WHERE first_name = 'Cuong';

-- Select all records from students table
SELECT *
FROM students;
