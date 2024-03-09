USE leetcode;

# Table: Employees
CREATE TABLE IF NOT EXISTS Employees
(
    employee_id INT,
    name        VARCHAR(20),
    manager_id  INT,
    salary      INT
);

TRUNCATE TABLE Employees;

INSERT INTO Employees (employee_id, name, manager_id, salary)
VALUES ('3', 'Mila', '9', '60301');

INSERT INTO Employees (employee_id, name, manager_id, salary)
VALUES ('12', 'Antonella', 'None', '31000');

INSERT INTO Employees (employee_id, name, manager_id, salary)
VALUES ('13', 'Emery', 'None', '67084');

INSERT INTO Employees (employee_id, name, manager_id, salary)
VALUES ('1', 'Kalel', '11', '21241');

INSERT INTO Employees (employee_id, name, manager_id, salary)
VALUES ('9', 'Mikaela', 'None', '50937');

INSERT INTO Employees (employee_id, name, manager_id, salary)
VALUES ('11', 'Joziah', '6', '28485');

# Solution
SELECT e1.employee_id
FROM Employees e1
         LEFT JOIN Employees e2
                   ON e1.manager_id = e2.employee_id
WHERE e2.employee_id IS NULL
  AND e1.manager_id IS NOT NULL
  AND e1.salary < 30000
ORDER BY employee_id;
