USE leetcode;

# Table: Triangle
CREATE TABLE IF NOT EXISTS Triangle
(
    x INT,
    y INT,
    z INT
);

TRUNCATE TABLE Triangle;

INSERT INTO Triangle (x, y, z)
VALUES ('13', '15', '30');

INSERT INTO Triangle (x, y, z)
VALUES ('10', '20', '15');

# Solution
SELECT x,
       y,
       z,
       IF(x + y <= z
              OR x + z <= y
              OR y + z <= x, 'No', 'Yes') triangle
FROM triangle;
