USE leetcode;

# Table: Customer
CREATE TABLE IF NOT EXISTS Customer
(
    id         INT,
    name       VARCHAR(25),
    referee_id INT
);

TRUNCATE TABLE Customer;

INSERT INTO Customer (id, name, referee_id)
VALUES ('1', 'Will', 'None');

INSERT INTO Customer (id, name, referee_id)
VALUES ('2', 'Jane', 'None');

INSERT INTO Customer (id, name, referee_id)
VALUES ('3', 'Alex', '2');

INSERT INTO Customer (id, name, referee_id)
VALUES ('4', 'Bill', 'None');

INSERT INTO Customer (id, name, referee_id)
VALUES ('5', 'Zack', '1');

INSERT INTO Customer (id, name, referee_id)
VALUES ('6', 'Mark', '2');

# Solution
SELECT name
FROM Customer
WHERE referee_id != 2
   OR referee_id IS NULL;
