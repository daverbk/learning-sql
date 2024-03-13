USE bank;

# 4.1
# IDs -> 1, 2, 3, 5, 6, 7

# 4.2
# IDs -> 4, 9

# 4.3
SELECT account_id, open_date
FROM account
WHERE open_date BETWEEN '2002-01-01' AND '2002-12-31';

# 4.4
SELECT cust_id, lname, fname
FROM individual
WHERE lname LIKE '_a%e%';
