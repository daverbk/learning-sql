USE leetcode;

# Table: Employees
CREATE TABLE IF NOT EXISTS Employees
(
    employee_id INT,
    name        VARCHAR(20),
    reports_to  INT,
    age         INT
);

TRUNCATE TABLE Employees;

INSERT INTO Employees (employee_id, name, reports_to, age)
VALUES ('9', 'Hercy', 'None', '43');

INSERT INTO Employees (employee_id, name, reports_to, age)
VALUES ('6', 'Alice', '9', '41');

INSERT INTO Employees (employee_id, name, reports_to, age)
VALUES ('4', 'Bob', '9', '36');

INSERT INTO Employees (employee_id, name, reports_to, age)
VALUES ('2', 'Winston', 'None', '37');

# Solution
SELECT e1.employee_id,
       e1.name,
       COUNT(e2.employee_id) reports_count,
       ROUND(AVG(e2.age))    average_age
FROM Employees e1
         INNER JOIN Employees e2
                    ON e1.employee_id = e2.reports_to
GROUP BY e1.employee_id
ORDER BY e1.employee_id;
