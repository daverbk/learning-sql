USE leetcode;

# Table: Logs
CREATE TABLE IF NOT EXISTS Logs
(
    id  INT,
    num INT
);

TRUNCATE TABLE Logs;

INSERT INTO Logs (id, num)
VALUES ('1', '1');

INSERT INTO Logs (id, num)
VALUES ('2', '1');

INSERT INTO Logs (id, num)
VALUES ('3', '1');

INSERT INTO Logs (id, num)
VALUES ('4', '2');

INSERT INTO Logs (id, num)
VALUES ('5', '1');

INSERT INTO Logs (id, num)
VALUES ('6', '2');

INSERT INTO Logs (id, num)
VALUES ('7', '2');

# Solution
SELECT DISTINCT l1.Num ConsecutiveNums
FROM Logs l1,
     Logs l2,
     Logs l3
WHERE l1.Id = l2.Id - 1
  AND l2.Id = l3.Id - 1
  AND l1.Num = l2.Num
  AND l2.Num = l3.Num;
