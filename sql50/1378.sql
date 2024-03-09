USE leetcode;

# Tables: Employees, EmployeeUNI
CREATE TABLE IF NOT EXISTS Employees
(
    id   INT,
    name VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS EmployeeUNI
(
    id        INT,
    unique_id INT
);

TRUNCATE TABLE Employees;

INSERT INTO Employees (id, name)
VALUES ('1', 'Alice');

INSERT INTO Employees (id, name)
VALUES ('7', 'Bob');

INSERT INTO Employees (id, name)
VALUES ('11', 'Meir');

INSERT INTO Employees (id, name)
VALUES ('90', 'Winston');

INSERT INTO Employees (id, name)
VALUES ('3', 'Jonathan');

TRUNCATE TABLE EmployeeUNI;

INSERT INTO EmployeeUNI (id, unique_id)
VALUES ('3', '1');

INSERT INTO EmployeeUNI (id, unique_id)
VALUES ('11', '2');

INSERT INTO EmployeeUNI (id, unique_id)
VALUES ('90', '3');

# Solution
SELECT EmployeeUNI.unique_id, Employees.name
FROM Employees
         LEFT JOIN EmployeeUNI
                   ON Employees.id = EmployeeUNI.id;
