# 3.1
SELECT emp_id, fname, lname
FROM employee
ORDER BY lname, fname;

# 3.2
SELECT account_id, cust_id, avail_balance
FROM account
WHERE status = 'ACTIVE'
    AND avail_balance > 2500;

# 3.3
SELECT DISTINCT open_emp_id
FROM account;

# 3.4
SELECT p.product_cd, a.cust_id, a.avail_balance
FROM product p INNER JOIN account a
    ON p.product_cd = a.product_cd
WHERE p.product_type_cd = 'ACCOUNT';