# WHERE true OR true -> true
# WHERE true OR false -> true
# WHERE false OR true -> true
# WHERE false OR false -> false

SELECT * FROM employee
WHERE title = 'Teller' OR start_date < '2003-01-01';

SELECT * FROM employee
WHERE title = 'Teller' AND start_date < '2003-01-01';

# WHERE true AND (true OR true) -> true
# WHERE true AND (true OR false) -> true
# WHERE true AND (false OR true) -> true
# WHERE true AND (false OR false) -> false
# WHERE false AND (true OR true) -> false
# WHERE false AND (true OR false) -> false
# WHERE false AND (false OR true) -> false
# WHERE false AND (false OR false) -> false

SELECT * FROM employee
WHERE end_date is NULL
AND (title = 'Teller' OR start_date < '2003-01-01');

# WHERE true AND NOT (true OR true) -> false
# WHERE true AND NOT (true OR false) -> false
# WHERE true AND NOT (false OR true) -> false
# WHERE true AND NOT (false OR false) -> true
# WHERE false AND NOT (true OR true) -> false
# WHERE false AND NOT (true OR false) -> false
# WHERE false AND NOT (false OR true) -> false
# WHERE false AND NOT (false OR false) -> false

SELECT * FROM employee
WHERE end_date is NULL
AND NOT (title = 'Teller' OR start_date < '2003-01-01');

SELECT * FROM employee
WHERE end_date is NULL
AND title != 'Teller' AND start_date >= '2003-01-01';

# Equality condition

SELECT pt.name product_type, p.name product
FROM product p INNER JOIN product_type pt
ON p.product_type_cd = pt.product_type_cd
WHERE pt.name = 'Customer Accounts';

# Inequality condition

SELECT pt.name product_type, p.name product
FROM product p INNER JOIN product_type pt
ON p.product_type_cd = pt.product_type_cd
WHERE pt.name != 'Customer Accounts';

# Deletion using conditions

DELETE FROM account
WHERE status = 'CLOSED' AND YEAR(close_date) = 1999;

# Range

SELECT emp_id, fname, lname, start_date
FROM employee
WHERE start_date < '2003-01-01';

SELECT emp_id, fname, lname, start_date
FROM employee
WHERE start_date < '2003-01-01'
AND start_date >= '2001-01-01';

# Between

SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE avail_balance BETWEEN 3000 AND 5000;

SELECT cust_id, fed_id
FROM customer
WHERE cust_type_cd = 'I'
AND fed_id BETWEEN '500-00-0000' AND '999-99-9999';

SELECT emp_id, fname, lname, start_date
FROM employee
WHERE start_date BETWEEN '2001-01-01' AND '2003-01-01';

# Server the actually generates

SELECT emp_id, fname, lname, start_date
FROM employee
WHERE start_date <= '2003-01-01'
AND start_date >= '2001-01-01';

# Set condition

SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd IN('CHK', 'SAV', 'CD', 'MM');

# Sub-query set condition

SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd IN (SELECT product_cd FROM product
    WHERE product_type_cd = 'ACCOUNT');

# NOT IN

SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd NOT IN('CHK', 'SAV', 'CD', 'MM');

# Starts with

SELECT emp_id, fname, lname
FROM employee
WHERE left(lname, 1) = 'T';

# LIKE; _ -> exactly one symbol; % -> any number of symbols (even none)

SELECT lname
FROM employee
WHERE lname LIKE  '_a%e%';

SELECT cust_id, fed_id
FROM customer
WHERE fed_id LIKE '___-__-____';

SELECT emp_id, fname, lname
FROM employee
WHERE lname LIKE 'F%' OR lname LIKE 'G%';

# Regular expressions

SELECT emp_id, fname, lname
FROM employee
WHERE lname REGEXP '^[FG]';

# Null conditions

SELECT emp_id, fname, lname, superior_emp_id
FROM employee
WHERE superior_emp_id IS NULL;

SELECT emp_id, fname, lname, superior_emp_id
FROM employee
WHERE superior_emp_id IS NOT NULL;

# Null condition doesn't with '='

SELECT emp_id, fname, lname, superior_emp_id
FROM employee
WHERE superior_emp_id = NULL;

# Possibility to miss data. The next query won't return the NULL records

SELECT emp_id, fname, lname, superior_emp_id
FROM employee
WHERE superior_emp_id != 6;

# Fix

SELECT emp_id, fname, lname, superior_emp_id
FROM employee
WHERE superior_emp_id != 6 OR superior_emp_id is NULL;
