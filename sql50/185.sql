USE leetcode;

# Tables: Employee, Department
CREATE TABLE IF NOT EXISTS Employee
(
    id           INT,
    name         VARCHAR(255),
    salary       INT,
    departmentId INT
);

CREATE TABLE IF NOT EXISTS Department
(
    id   INT,
    name VARCHAR(255)
);

TRUNCATE TABLE Employee;

INSERT INTO Employee (id, name, salary, departmentId)
VALUES ('1', 'Joe', '85000', '1');

INSERT INTO Employee (id, name, salary, departmentId)
VALUES ('2', 'Henry', '80000', '2');

INSERT INTO Employee (id, name, salary, departmentId)
VALUES ('3', 'Sam', '60000', '2');

INSERT INTO Employee (id, name, salary, departmentId)
VALUES ('4', 'Max', '90000', '1');

INSERT INTO Employee (id, name, salary, departmentId)
VALUES ('5', 'Janet', '69000', '1');

INSERT INTO Employee (id, name, salary, departmentId)
VALUES ('6', 'Randy', '85000', '1');

INSERT INTO Employee (id, name, salary, departmentId)
VALUES ('7', 'Will', '70000', '1');

TRUNCATE TABLE Department;

INSERT INTO Department (id, name)
VALUES ('1', 'IT');

INSERT INTO Department (id, name)
VALUES ('2', 'Sales');

# Solution
WITH employee_department AS
         (SELECT d.id,
                 d.name                                                     AS Department,
                 salary                                                     AS Salary,
                 e.name                                                     AS Employee,
                 DENSE_RANK() OVER (PARTITION BY d.id ORDER BY salary DESC) AS rnk
          FROM Department d
                   JOIN Employee e
                        ON d.id = e.departmentId)
SELECT Department, Employee, Salary
FROM employee_department
WHERE rnk <= 3;
