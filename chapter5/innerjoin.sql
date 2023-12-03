# Cross join
SELECT e.fname, e.lname, d.name
FROM employee e JOIN department d;

# Join ON
SELECT e.fname, e.lname, d.name
FROM employee e JOIN department d
    ON e.dept_id = d.dept_id;

# Explicit INNER join
SELECT e.fname, e.lname, d.name
FROM employee e INNER JOIN department d
    ON e.dept_id = d.dept_id;

# If columns names are similar we can use USING instead of ON
SELECT e.fname, e.lname, d.name
FROM employee e INNER JOIN department d
    USING(dept_id);

# Old syntax join
SELECT e.fname, e.lname, d.name
FROM employee e INNER JOIN department d
WHERE e.dept_id = d.dept_id;

# SQL92 and old syntax difference (SQL92 looks preferable)
SELECT a.account_id, a.cust_id, a.open_date, a.product_cd
FROM account a, branch b, employee e
WHERE a.open_emp_id = e.emp_id
    AND e.start_date <= '2003-01-01'
    AND e.assigned_branch_id = b.branch_id
    AND (e.title = 'Teller' OR e.title = 'Head Teller')
    AND b.name = 'Woburn Branch';

SELECT a.account_id, a.cust_id, a.open_date, a.product_cd
FROM account a INNER JOIN employee e
    ON a.open_emp_id = e.emp_id
    INNER JOIN branch b
    ON e.assigned_branch_id = b.branch_id
WHERE e.start_date <= '2003-01-01'
    AND (e.title = 'Teller' OR e.title = 'Head Teller')
    AND b.name = 'Woburn Branch';

# Join on 3 or more tables
SELECT a.account_id, c.fed_id, e.fname, e.lname
FROM account a INNER JOIN customer c
    ON a.cust_id = c.cust_id
    INNER JOIN employee e
    ON a.open_emp_id = e.emp_id
WHERE c.cust_type_cd = 'B';

# Is equal to
SELECT a.account_id, c.fed_id, e.fname, e.lname
FROM customer c INNER JOIN account a
    ON a.cust_id = c.cust_id
    INNER JOIN employee e
    ON a.open_emp_id = e.emp_id
WHERE c.cust_type_cd = 'B';

# Sub-queries as tables
SELECT a.account_id, a.cust_id, a.open_date, a.product_cd
FROM account a
    INNER JOIN
    (SELECT emp_id, assigned_branch_id
     FROM employee
     WHERE (title = 'Teller' OR title = 'Head Teller')) e
    ON a.open_emp_id = e.emp_id
    INNER JOIN
    (SELECT branch_id
     FROM branch
     WHERE name = 'Woburn Branch') b
ON e.assigned_branch_id = b.branch_id;