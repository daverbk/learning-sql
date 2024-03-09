USE leetcode;

# Table: MyNumbers
CREATE TABLE IF NOT EXISTS MyNumbers
(
    num INT
);

TRUNCATE TABLE MyNumbers;

INSERT INTO MyNumbers (num)
VALUES ('8');

INSERT INTO MyNumbers (num)
VALUES ('8');

INSERT INTO MyNumbers (num)
VALUES ('3');

INSERT INTO MyNumbers (num)
VALUES ('3');

INSERT INTO MyNumbers (num)
VALUES ('1');

INSERT INTO MyNumbers (num)
VALUES ('4');

INSERT INTO MyNumbers (num)
VALUES ('5');

INSERT INTO MyNumbers (num)
VALUES ('6');

# Solution
SELECT MAX(num) AS num
FROM (SELECT num
      FROM MyNumbers
      GROUP BY num
      HAVING COUNT(num) = 1) unique_numbers;
