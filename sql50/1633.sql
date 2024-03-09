USE leetcode;

# Tables: Users, Register
CREATE TABLE IF NOT EXISTS Users
(
    user_id   INT,
    user_name VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Register
(
    contest_id INT,
    user_id    INT
);

TRUNCATE TABLE Users;

INSERT INTO Users (user_id, user_name)
VALUES ('6', 'Alice');

INSERT INTO Users (user_id, user_name)
VALUES ('2', 'Bob');

INSERT INTO Users (user_id, user_name)
VALUES ('7', 'Alex');

TRUNCATE TABLE Register;

INSERT INTO Register (contest_id, user_id)
VALUES ('215', '6');

INSERT INTO Register (contest_id, user_id)
VALUES ('209', '2');

INSERT INTO Register (contest_id, user_id)
VALUES ('208', '2');

INSERT INTO Register (contest_id, user_id)
VALUES ('210', '6');

INSERT INTO Register (contest_id, user_id)
VALUES ('208', '6');

INSERT INTO Register (contest_id, user_id)
VALUES ('209', '7');

INSERT INTO Register (contest_id, user_id)
VALUES ('209', '6');

INSERT INTO Register (contest_id, user_id)
VALUES ('215', '7');

INSERT INTO Register (contest_id, user_id)
VALUES ('208', '7');

INSERT INTO Register (contest_id, user_id)
VALUES ('210', '2');

INSERT INTO Register (contest_id, user_id)
VALUES ('207', '2');

INSERT INTO Register (contest_id, user_id)
VALUES ('210', '7');

# Solution
SELECT r.contest_id,
       ROUND(COUNT(*) / (SELECT COUNT(DISTINCT user_id) FROM Users) * 100, 2) percentage
FROM Register r
         LEFT JOIN Users u
                   ON u.user_id = r.user_id
GROUP BY r.contest_id
ORDER BY percentage DESC, r.contest_id;
