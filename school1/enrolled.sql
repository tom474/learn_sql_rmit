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
);

-- Insert some values into enrolled table
INSERT INTO enrolled
VALUES
(123456, 'MATH2239', 'D'),
(123456, 'MATH2240', 'D'),
(682634, 'ISYS2077', 'A'),
(632461, 'ISYS2040', 'C');

-- Select all records from enrolled table
SELECT *
FROM enrolled;
