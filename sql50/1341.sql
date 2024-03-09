USE leetcode;

# Tables: Movies, Users, MovieRating
CREATE TABLE IF NOT EXISTS Movies
(
    movie_id INT,
    title    VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS Users
(
    user_id INT,
    name    VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS MovieRating
(
    movie_id   INT,
    user_id    INT,
    rating     INT,
    created_at DATE
);

TRUNCATE TABLE Movies;

INSERT INTO Movies (movie_id, title)
VALUES ('1', 'Avengers');

INSERT INTO Movies (movie_id, title)
VALUES ('2', 'Frozen 2');

INSERT INTO Movies (movie_id, title)
VALUES ('3', 'Joker');

TRUNCATE TABLE Users;

INSERT INTO Users (user_id, name)
VALUES ('1', 'Daniel');

INSERT INTO Users (user_id, name)
VALUES ('2', 'Monica');

INSERT INTO Users (user_id, name)
VALUES ('3', 'Maria');

INSERT INTO Users (user_id, name)
VALUES ('4', 'James');

TRUNCATE TABLE MovieRating;

INSERT INTO MovieRating (movie_id, user_id, rating, created_at)
VALUES ('1', '1', '3', '2020-01-12');

INSERT INTO MovieRating (movie_id, user_id, rating, created_at)
VALUES ('1', '2', '4', '2020-02-11');

INSERT INTO MovieRating (movie_id, user_id, rating, created_at)
VALUES ('1', '3', '2', '2020-02-12');

INSERT INTO MovieRating (movie_id, user_id, rating, created_at)
VALUES ('1', '4', '1', '2020-01-01');

INSERT INTO MovieRating (movie_id, user_id, rating, created_at)
VALUES ('2', '1', '5', '2020-02-17');

INSERT INTO MovieRating (movie_id, user_id, rating, created_at)
VALUES ('2', '2', '2', '2020-02-01');

INSERT INTO MovieRating (movie_id, user_id, rating, created_at)
VALUES ('2', '3', '2', '2020-03-01');

INSERT INTO MovieRating (movie_id, user_id, rating, created_at)
VALUES ('3', '1', '3', '2020-02-22');

INSERT INTO MovieRating (movie_id, user_id, rating, created_at)
VALUES ('3', '2', '4', '2020-02-25');

# Solution
(SELECT name AS results
 FROM Users u
          INNER JOIN MovieRating mr
                     USING (user_id)
 GROUP BY user_id, name
 ORDER BY COUNT(movie_id) DESC, name
 LIMIT 1)
UNION ALL
(SELECT title AS results
 FROM MovieRating mr
          INNER JOIN Movies
                     USING (movie_id)
 WHERE MONTH(created_at) = 2
   AND YEAR(created_at) = 2020
 GROUP BY movie_id, title
 ORDER BY AVG(rating) DESC, title
 LIMIT 1);
