USE leetcode;

# Table: Employee
CREATE TABLE IF NOT EXISTS Employee
(
    id     INT,
    salary INT
);

TRUNCATE TABLE Employee;

INSERT INTO Employee (id, salary)
VALUES ('1', '100');

INSERT INTO Employee (id, salary)
VALUES ('2', '200');

INSERT INTO Employee (id, salary)
VALUES ('3', '300');

# Solution
SELECT MAX(SALARY) AS SecondHighestSalary
FROM EMPLOYEE
WHERE SALARY < (SELECT MAX(SALARY) FROM EMPLOYEE);
