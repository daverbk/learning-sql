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
WHERE name IN ('Headquarters', 'Quincy Branch')
