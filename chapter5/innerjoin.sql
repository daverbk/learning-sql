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
        WHERE start_date <= '2003-01-01'
            AND (title = 'Teller' OR title = 'Head Teller')) e
    ON a.open_emp_id = e.emp_id
    INNER JOIN
        (SELECT branch_id
        FROM branch
        WHERE name = 'Woburn Branch') b
    ON e.assigned_branch_id = b.branch_id;

# Sub-query 1
SELECT emp_id, assigned_branch_id
FROM employee
WHERE start_date <= '2003-01-01'
    AND (title = 'Teller' OR title = 'Head Teller');

# Sub-query 2
SELECT branch_id
FROM branch
WHERE name = 'Woburn Branch';

# Table reuse (pseudonyms for two branch 'name' columns are required)
SELECT a.account_id, e.emp_id,
       b_a.name open_branch, b_e.name emp_branch
FROM account a INNER JOIN branch b_a
    ON a.open_branch_id = b_a.branch_id
    INNER JOIN employee e
    ON a.open_emp_id = e.emp_id
    INNER JOIN branch b_e
    ON e.assigned_branch_id = b_e.branch_id
WHERE a.product_cd = 'CHK';

# Self-join (with a self-referencing key)
SELECT e.fname, e.lname, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
FROM employee e INNER JOIN employee e_mgr
ON e.superior_emp_id = e_mgr.emp_id;

# Non-equi-join
SELECT e.emp_id, e.fname, e.lname, e.start_date
FROM employee e INNER JOIN product p
    ON e.start_date >= p.date_offered
        AND e.start_date <= p.date_retired
WHERE p.name = 'no-fee checking';

# Self-non-equi-join
SELECT e1.fname, e1.lname, 'VS' vs, e2.fname, e2.lname
FROM employee e1 INNER JOIN employee e2
    ON e1.emp_id < e2.emp_id
WHERE e1.title = 'Teller' AND e2.title = 'Teller';

# Our goal is to express our intentions clearly
# All of the following quires result in same tales

SELECT a.account_id, a.product_cd, c.fed_id
FROM account a INNER JOIN customer c
    ON a.cust_id = c.cust_id
WHERE c.cust_type_cd = 'B';

SELECT a.account_id, a.product_cd, c.fed_id
FROM account a INNER JOIN customer c
    ON a.cust_id = c.cust_id
        AND c.cust_type_cd = 'B';

SELECT a.account_id, a.product_cd, c.fed_id
FROM account a INNER JOIN customer c
    WHERE a.cust_id = c.cust_id
        AND c.cust_type_cd = 'B';