USE leetcode;

# Table: Activity
CREATE TABLE IF NOT EXISTS Transactions
(
    id         INT,
    country    VARCHAR(4),
    state      ENUM ('approved', 'declined'),
    amount     INT,
    trans_date DATE
);

TRUNCATE TABLE Transactions;

INSERT INTO Transactions (id, country, state, amount, trans_date)
VALUES ('121', 'US', 'approved', '1000', '2018-12-18');

INSERT INTO Transactions (id, country, state, amount, trans_date)
VALUES ('122', 'US', 'declined', '2000', '2018-12-19');

INSERT INTO Transactions (id, country, state, amount, trans_date)
VALUES ('123', 'US', 'approved', '2000', '2019-01-01');

INSERT INTO Transactions (id, country, state, amount, trans_date)
VALUES ('124', 'DE', 'approved', '2000', '2019-01-07');

# Solution
SELECT DATE_FORMAT(trans_date, '%Y-%m')       month,
       country,
       COUNT(*)                               trans_count,
       SUM(IF(state = 'approved', 1, 0))      approved_count,
       SUM(amount)                            trans_total_amount,
       SUM(IF(state = 'approved', amount, 0)) approved_total_amount
FROM Transactions
GROUP BY month, country;
