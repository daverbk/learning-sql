USE leetcode;

# Table: RequestAccepted
CREATE TABLE IF NOT EXISTS RequestAccepted
(
    requester_id INT  NOT NULL,
    accepter_id  INT  NULL,
    accept_date  DATE NULL
);

TRUNCATE TABLE RequestAccepted;

INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date)
VALUES ('1', '2', '2016/06/03');

INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date)
VALUES ('1', '3', '2016/06/08');

INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date)
VALUES ('2', '3', '2016/06/08');

INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date)
VALUES ('3', '4', '2016/06/09');

# Solution
SELECT id, COUNT(*) num
FROM (SELECT requester_id id
      FROM RequestAccepted
      UNION ALL
      SELECT accepter_id id
      FROM RequestAccepted) tbl
GROUP BY id
ORDER BY num DESC
LIMIT 1;
