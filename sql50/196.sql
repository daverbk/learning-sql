USE leetcode;

# Table: Person
CREATE TABLE IF NOT EXISTS Person
(
    Id    INT,
    Email VARCHAR(255)
);

TRUNCATE TABLE Person;

INSERT INTO Person (id, email)
VALUES ('1', 'john@example.com');

INSERT INTO Person (id, email)
VALUES ('2', 'bob@example.com');

INSERT INTO Person (id, email)
VALUES ('3', 'john@example.com');

# Solution
DELETE p1
FROM Person p1,
     Person p2
WHERE p1.email = p2.email
  AND p1.id > p2.id;
