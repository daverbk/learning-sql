# ORDER BY must mention the columns
# of the first SELECT
SELECT emp_id, assigned_branch_id
FROM employee
WHERE title = 'Teller'
UNION
SELECT open_emp_id, open_branch_id
FROM account
WHERE product_cd = 'SAV'
ORDER BY emp_id;

# Usage of a column from the second SELECT
SELECT emp_id, assigned_branch_id
FROM employee
WHERE title = 'Teller'
UNION
SELECT open_emp_id, open_branch_id
FROM account
WHERE product_cd = 'SAV'
# ORDER BY open_emp_id; -> would cause an error

# Compound queries are executed in the order
# UP -> DOWN
# BUT:
# 1) INTERSECT is executed first
# 2) We can set the execution order by parentheses
SELECT cust_id
FROM account
WHERE product_cd IN('SAV', 'MM')
UNION ALL # <- first separator between requests
SELECT a.cust_id
FROM account a INNER JOIN branch b
    ON a.open_branch_id = b.branch_id
WHERE b.name = 'Woburn Branch'
UNION # <- second separator between requests
SELECT cust_id
FROM account
WHERE avail_balance BETWEEN 500 AND 2500;

# To compare the previous with
SELECT cust_id
FROM account
WHERE product_cd IN('SAV', 'MM')
UNION
SELECT a.cust_id
FROM account a INNER JOIN branch b
    ON a.open_branch_id = b.branch_id
WHERE b.name = 'Woburn Branch'
UNION ALL
SELECT cust_id
FROM account
WHERE avail_balance BETWEEN 500 AND 2500

# An example with ()
(SELECT cust_id
FROM account
WHERE product_cd IN('SAV', 'MM')
UNION ALL
SELECT a.cust_id
FROM account a INNER JOIN branch b
    ON a.open_branch_id = b.branch_id
WHERE b.name = 'Woburn Branch')
INTERSECT
(SELECT cust_id
FROM account
WHERE avail_balance BETWEEN 500 AND 2500
EXCEPT
SELECT cust_id
FROM account
WHERE product_cd = 'CD'
    AND avail_balance < 1000);