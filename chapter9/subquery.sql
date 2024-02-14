# Types of subquieries
# 1) Resulting in one row and one column (scalar) -
#    can be used with regular comparison operators
# 2) Resulting in multiple rows and one column
# 3) Resulting in multiple rows and columns
# 4) Non-correlated
# 5) Correlated

SELECT account_id, product_cd, avail_balance
FROM account
WHERE account_id = (SELECT MAX(account_id) FROM account);

# Non-correlated subquieries (mostly in UPDATE and DELETE)
# Scalar sub-quivery

SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE open_emp_id <> (
    SELECT e.emp_id
    FROM employee e
    INNER JOIN branch b
        ON e.assigned_branch_id = b.branch_id
    WHERE e.title = 'Head Teller' AND b.city = 'Woburn'
);

# SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY
# All can be used in subquieries

# This one will result in
# [21000][1242] Subquery returns more than 1 row

SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE open_emp_id <> (
    SELECT e.emp_id
    FROM employee e
    INNER JOIN branch b
        ON e.assigned_branch_id = b.branch_id
    WHERE e.title = 'Teller' AND b.city = 'Woburn'
);

# The error happens because we can't compare
# an expression open_emp_id (1) with a set of
# expressions emp_id (2)

# IN operator can be use to search in a set of values
SELECT branch_id, name, city
FROM branch
WHERE name IN ('Headquarters', 'Quincy Branch');

SELECT emp_id, fname, lname, title
FROM employee
WHERE employee.emp_id IN (
    SELECT superior_emp_id
    FROM employee
);

# IN can be used in pair with NOT

SELECT emp_id, fname, lname, title
FROM employee
WHERE employee.emp_id NOT IN (
    SELECT superior_emp_id
    FROM employee
    WHERE superior_emp_id IS NOT NULL
);

# ALL allows us to compare single value with
# each of the resulting set

SELECT emp_id, fname, lname, title
FROM employee
WHERE emp_id <> ALL (
    SELECT superior_emp_id
    FROM employee
    WHERE superior_emp_id IS NOT NULL
);

# Comparison of a value with a NULL results in empty set

SELECT emp_id, fname, lname, title
FROM employee
WHERE emp_id NOT IN (1, 2, NULL);

# ANY is close to ALL, but returns a true
# if there is at least one match
# = ANY is equivalent to IN

SELECT account_id, cust_id, product_cd, avail_balance
FROM account
WHERE avail_balance > ANY (
    SELECT a.avail_balance
    FROM account a
    INNER JOIN individual i
        ON a.cust_id = i.cust_id
    WHERE i.fname = 'Frank' AND i.lname = 'Tucker'
);

# Subquieries resulting in multiple columns

SELECT account_id, product_cd, cust_id
FROM account
WHERE (open_branch_id, open_emp_id) IN (
    SELECT b.branch_id, e.emp_id
    FROM branch b
    INNER JOIN employee e
        ON b.branch_id = e.assigned_branch_id
    WHERE b.name = 'Woburn Branch'
        AND (e.title = 'Teller' OR e.title = 'Head Teller')
);

# Correlated subquieries
# Mentioning of c.cust_id makes it correlated

SELECT c.cust_id, c.cust_type_cd, c.city
FROM customer c
WHERE 2 = (
    SELECT COUNT(*)
    FROM account a
    WHERE a.cust_id = c.cust_id
);
