USE leetcode;

# Table: Users
CREATE TABLE IF NOT EXISTS Users
(
    user_id INT,
    name    VARCHAR(40)
);

TRUNCATE TABLE Users;

INSERT INTO Users (user_id, name)
VALUES ('1', 'aLice');

INSERT INTO Users (user_id, name)
VALUES ('2', 'bOB');

# Solution
SELECT user_id,
       CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2))) AS name
FROM Users
ORDER BY user_id;
