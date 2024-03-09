USE leetcode;

# Table: Activity
CREATE TABLE IF NOT EXISTS Followers
(
    user_id     INT,
    follower_id INT
);

TRUNCATE TABLE Followers;

INSERT INTO Followers (user_id, follower_id)
VALUES ('0', '1');

INSERT INTO Followers (user_id, follower_id)
VALUES ('1', '0');

INSERT INTO Followers (user_id, follower_id)
VALUES ('2', '0');

INSERT INTO Followers (user_id, follower_id)
VALUES ('2', '1');

# Solution
SELECT user_id, COUNT(follower_id) followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;
