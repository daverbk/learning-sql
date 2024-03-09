USE leetcode;

# Table: Employee
CREATE TABLE IF NOT EXISTS Employee
(
    employee_id   INT,
    department_id INT,
    primary_flag  ENUM ('Y','N')
);

TRUNCATE TABLE Employee;

INSERT INTO Employee (employee_id, department_id, primary_flag)
VALUES ('1', '1', 'N');

INSERT INTO Employee (employee_id, department_id, primary_flag)
VALUES ('2', '1', 'Y');

INSERT INTO Employee (employee_id, department_id, primary_flag)
VALUES ('2', '2', 'N');

INSERT INTO Employee (employee_id, department_id, primary_flag)
VALUES ('3', '3', 'N');

INSERT INTO Employee (employee_id, department_id, primary_flag)
VALUES ('4', '2', 'N');

INSERT INTO Employee (employee_id, department_id, primary_flag)
VALUES ('4', '3', 'Y');

INSERT INTO Employee (employee_id, department_id, primary_flag)
VALUES ('4', '4', 'N');

# Solution
SELECT employee_id, department_id
FROM employee
WHERE primary_flag = 'Y'
UNION
SELECT employee_id, department_id
FROM employee
GROUP BY employee_id
HAVING COUNT(*) = 1;
