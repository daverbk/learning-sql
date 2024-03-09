USE leetcode;

# Table: Accounts
CREATE TABLE IF NOT EXISTS Accounts
(
    account_id INT,
    income     INT
);

TRUNCATE TABLE Accounts;

INSERT INTO Accounts (account_id, income)
VALUES ('3', '108939');

INSERT INTO Accounts (account_id, income)
VALUES ('2', '12747');

INSERT INTO Accounts (account_id, income)
VALUES ('8', '87709');

INSERT INTO Accounts (account_id, income)
VALUES ('6', '91796');

# Solution
SELECT 'Low Salary' category, SUM(income < 20000) accounts_count
FROM Accounts
UNION
SELECT 'Average Salary' category, SUM(income BETWEEN 20000 AND 50000) accounts_count
FROM Accounts
UNION
SELECT 'High Salary' category, SUM(income > 50000) accounts_count
FROM Accounts;
