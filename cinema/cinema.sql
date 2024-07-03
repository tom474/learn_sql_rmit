-- Delete the tables if they already exist
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS reviewers;
DROP TABLE IF EXISTS ratings;

-- Create the movies table
CREATE TABLE movies (
    movie_id INT,
    title VARCHAR(50),
    year INT,
    director VARCHAR(50)
);

-- Create the reviewers table
CREATE TABLE reviewers (
    reviewer_id INT,
    name VARCHAR(50)
);

-- Create the ratings table
CREATE TABLE ratings (
    rating_id INT,
    movie_id INT,
    stars INT,
    rating_date DATE
);

-- movie_id is a key for movies
ALTER TABLE movies CHANGE movie_id movie_id INT UNIQUE NOT NULL;

-- (title, year) is a key for Movie
ALTER TABLE movies ADD CONSTRAINT pk_movies PRIMARY KEY (title, year);

-- reviewer_id is a key for reviewers
ALTER TABLE reviewers ADD PRIMARY KEY (reviewer_id);

-- (rating_id, movie_id, rating_date) is a key for ratings but NULL values allowed
ALTER TABLE ratings ADD CONSTRAINT UNIQUE (rating_id, movie_id, rating_date);

-- reviewers.name may not be NULL
ALTER TABLE reviewers CHANGE name name VARCHAR(50) NOT NULL;

-- ratings.stars may not be NULL
ALTER TABLE ratings CHANGE stars stars INT NOT NULL;

-- movies.year must be after 1900
ALTER TABLE movies ADD CONSTRAINT valid_year CHECK (year > 1900);

-- ratings.stars must be in {1, 2, 3, 4, 5}
ALTER TABLE ratings ADD CONSTRAINT valid_stars1 CHECK (stars >= 1 AND stars <= 5);
-- or
ALTER TABLE ratings ADD CONSTRAINT valid_stars2 CHECK (stars IN (1,2,3,4,5));

-- ratings.rating_date must be after 2000
ALTER TABLE ratings ADD CONSTRAINT valid_date CHECK (rating_date >= '2000-01-01');

-- Insert some values into movies table
INSERT INTO movies
VALUES
(101, 'Gone with the Wind', 1939, 'Victor Fleming'),
(102, 'Star Wars', 1977, 'George Lucas'),
(103, 'The Sound of Music', 1965, 'Robert Wise'),
(104, 'E.T.', 1982, 'Steven Spielberg'),
(105, 'Titanic', 1997, 'James Cameron'),
(106, 'Snow White', 1937, null),
(107, 'Avatar', 2009, 'James Cameron'),
(108, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');

-- Insert some values into reviewers table
INSERT INTO reviewers
VALUES
(201, 'Sarah Martinez'),
(202, 'Daniel Lewis'),
(203, 'Brittany Harris'),
(204, 'Mike Anderson'),
(205, 'Chris Jackson'),
(206, 'Elizabeth Thomas'),
(207, 'James Cameron'),
(208, 'Ashley White');

-- Insert some values into ratings table
INSERT INTO ratings
VALUES
(201, 101, 2, '2011-01-22'),
(201, 101, 4, '2011-01-27'),
(202, 106, 4, null),
(203, 103, 2, '2011-01-20'),
(203, 108, 4, '2011-01-12'),
(203, 108, 2, '2011-01-30'),
(204, 101, 3, '2011-01-09'),
(205, 103, 3, '2011-01-27'),
(205, 104, 2, '2011-01-22'),
(205, 108, 4, null),
(206, 107, 3, '2011-01-15'),
(206, 106, 5, '2011-01-19'),
(207, 107, 5, '2011-01-20'),
(208, 104, 3, '2011-01-02');

-- Select all the records from the movies table
SELECT *
FROM movies;

-- Select all the records from the reviewers table
SELECT *
FROM reviewers;

-- Select all the records from the ratings table
SELECT *
FROM ratings;
