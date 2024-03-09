USE leetcode;

# Table: Courses
CREATE TABLE IF NOT EXISTS Courses
(
    student VARCHAR(255),
    class   VARCHAR(255)
);

TRUNCATE TABLE Courses;

INSERT INTO Courses (student, class)
VALUES ('A', 'Math');

INSERT INTO Courses (student, class)
VALUES ('B', 'English');

INSERT INTO Courses (student, class)
VALUES ('C', 'Math');

INSERT INTO Courses (student, class)
VALUES ('D', 'Biology');

INSERT INTO Courses (student, class)
VALUES ('E', 'Math');

INSERT INTO Courses (student, class)
VALUES ('F', 'Computer');

INSERT INTO Courses (student, class)
VALUES ('G', 'Math');

INSERT INTO Courses (student, class)
VALUES ('H', 'Math');

INSERT INTO Courses (student, class)
VALUES ('I', 'Math');

# Solution
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) > 4;
