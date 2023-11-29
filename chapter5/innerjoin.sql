# Cross join
SELECT e.fname, e.lname, d.name
FROM employee e JOIN department d;

# Join ON
SELECT e.fname, e.lname, d.name
FROM employee e JOIN department d
    ON e.dept_id = d.dept_id;