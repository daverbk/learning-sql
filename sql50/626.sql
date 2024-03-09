USE leetcode;

# Table: Seat
CREATE TABLE IF NOT EXISTS Seat
(
    id      INT,
    student VARCHAR(255)
);

TRUNCATE TABLE Seat;

INSERT INTO Seat (id, student)
VALUES ('1', 'Abbot');

INSERT INTO Seat (id, student)
VALUES ('2', 'Doris');

INSERT INTO Seat (id, student)
VALUES ('3', 'Emerson');

INSERT INTO Seat (id, student)
VALUES ('4', 'Green');

INSERT INTO Seat (id, student)
VALUES ('5', 'Jeames');

# Solution
SELECT IF(id < (SELECT MAX(id) FROM Seat),
          IF(id % 2 = 0, id - 1, id + 1),
          IF(id % 2 = 0, id - 1, id)) AS id,
       student
FROM Seat
ORDER BY id;
