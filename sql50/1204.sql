USE leetcode;

# Table: Queue
CREATE TABLE IF NOT EXISTS Queue
(
    person_id   INT,
    person_name VARCHAR(30),
    weight      INT,
    turn        INT
);

TRUNCATE TABLE Queue;

INSERT INTO Queue (person_id, person_name, weight, turn)
VALUES ('5', 'Alice', '250', '1');

INSERT INTO Queue (person_id, person_name, weight, turn)
VALUES ('4', 'Bob', '175', '5');

INSERT INTO Queue (person_id, person_name, weight, turn)
VALUES ('3', 'Alex', '350', '2');

INSERT INTO Queue (person_id, person_name, weight, turn)
VALUES ('6', 'John Cena', '400', '3');

INSERT INTO Queue (person_id, person_name, weight, turn)
VALUES ('1', 'Winston', '500', '6');

INSERT INTO Queue (person_id, person_name, weight, turn)
VALUES ('2', 'Marie', '200', '4');

# Solution
SELECT person_name
FROM (SELECT *, SUM(weight) OVER (ORDER BY turn) AS weight_so_far FROM Queue) cnt
WHERE cnt.weight_so_far <= 1000
ORDER BY weight_so_far DESC
LIMIT 1;
