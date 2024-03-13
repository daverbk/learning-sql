USE bank;

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
WHERE open_emp_id <> (SELECT e.emp_id
                      FROM employee e
                               INNER JOIN branch b
                                          ON e.assigned_branch_id = b.branch_id
                      WHERE e.title = 'Head Teller'
                        AND b.city = 'Woburn');

# SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY
# All can be used in subquieries

# This one will result in
# [21000][1242] Subquery returns more than 1 row
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE open_emp_id <> (SELECT e.emp_id
                      FROM employee e
                               INNER JOIN branch b
                                          ON e.assigned_branch_id = b.branch_id
                      WHERE e.title = 'Teller'
                        AND b.city = 'Woburn');

# The error happens because we can't compare
# an expression open_emp_id (1) with a set of
# expressions emp_id (2)

# IN operator can be use to search in a set of values
SELECT branch_id, name, city
FROM branch
WHERE name IN ('Headquarters', 'Quincy Branch');

SELECT emp_id, fname, lname, title
FROM employee
WHERE employee.emp_id IN (SELECT superior_emp_id
                          FROM employee);

# IN can be used in pair with NOT
SELECT emp_id, fname, lname, title
FROM employee
WHERE employee.emp_id NOT IN (SELECT superior_emp_id
                              FROM employee
                              WHERE superior_emp_id IS NOT NULL);

# ALL allows us to compare single value with
# each of the resulting set
SELECT emp_id, fname, lname, title
FROM employee
WHERE emp_id <> ALL (SELECT superior_emp_id
                     FROM employee
                     WHERE superior_emp_id IS NOT NULL);

# Comparison of a value with a NULL results in empty set
SELECT emp_id, fname, lname, title
FROM employee
WHERE emp_id NOT IN (1, 2, NULL);

# ANY is close to ALL, but returns a true
# if there is at least one match
# = ANY is equivalent to IN
SELECT account_id, cust_id, product_cd, avail_balance
FROM account
WHERE avail_balance > ANY (SELECT a.avail_balance
                           FROM account a
                                    INNER JOIN individual i
                                               ON a.cust_id = i.cust_id
                           WHERE i.fname = 'Frank'
                             AND i.lname = 'Tucker');

# Subquieries resulting in multiple columns
SELECT account_id, product_cd, cust_id
FROM account
WHERE (open_branch_id, open_emp_id) IN (SELECT b.branch_id, e.emp_id
                                        FROM branch b
                                                 INNER JOIN employee e
                                                            ON b.branch_id = e.assigned_branch_id
                                        WHERE b.name = 'Woburn Branch'
                                          AND (e.title = 'Teller' OR e.title = 'Head Teller'));

# Correlated subquieries
# Mentioning of c.cust_id makes it correlated
SELECT c.cust_id, c.cust_type_cd, c.city
FROM customer c
WHERE 2 = (SELECT COUNT(*)
           FROM account a
           WHERE a.cust_id = c.cust_id);

# Exists is one of the most popular
# in conditions with correlated subquieries
SELECT a.account_id, a.product_cd, a.cust_id, a.avail_balance
FROM account a
WHERE EXISTS (SELECT *
              FROM transaction t
              WHERE t.account_id = a.account_id
                AND t.txn_date = '2005-01-22');

# EXISTS can be used in pair with NOT
SELECT a.account_id, a.product_cd, a.cust_id, a.avail_balance
FROM account a
WHERE NOT EXISTS (SELECT *
                  FROM transaction t
                  WHERE t.account_id = a.account_id
                    AND t.txn_date = '2005-01-22');

# Correlated subquieries can be used in UPDATE
UPDATE account a
SET a.last_activity_date = (SELECT MAX(txn_date)
                            FROM transaction t
                            WHERE t.account_id = a.account_id)
WHERE EXISTS (SELECT *
              FROM transaction t
              WHERE t.account_id = a.account_id);

# Correlated subquieries can be used in DELETE
# This might not work for mysql as it doesn't support pseudonyms in DELETE
DELETE
FROM department d
WHERE NOT EXISTS (SELECT 1
                  FROM employee e
                  WHERE e.dept_id = d.dept_id);

# Sub-queries as data sources
SELECT d.dept_id, d.name, e_cnt.how_many num_emp
FROM department d
         INNER JOIN (SELECT dept_id, COUNT(*) how_many
                     FROM employee
                     GROUP BY dept_id) e_cnt
                    ON d.dept_id = e_cnt.dept_id;

# Forming a table from sub-queries
SELECT cust_groups.name, COUNT(*) num_customers
FROM (SELECT SUM(a.avail_balance) cust_balance
      FROM account a
               INNER JOIN product p
                          ON a.product_cd = p.product_cd
      WHERE p.product_type_cd = 'ACCOUNT'
      GROUP BY a.cust_id) cust_rollup
         INNER JOIN (SELECT 'Small Fly' name, 0 low_limit, 4999.99 high_limit
                     UNION ALL
                     SELECT 'Average Joes' name, 5000 low_limit, 9999.99 high_limit
                     UNION ALL
                     SELECT 'Heavy Hitters' name, 10000 low_limit, 99999999.99 high_limit) cust_groups
                    ON cust_rollup.cust_balance
                        BETWEEN cust_groups.low_limit
                        AND cust_groups.high_limit
GROUP BY cust_groups.name;

# Sub-queries in HAVING
SELECT open_emp_id, COUNT(*) num_accounts
FROM account
GROUP BY open_emp_id
HAVING COUNT(*) = (SELECT MAX(emp_cnt.how_many)
                   FROM (SELECT COUNT(*) how_many
                         FROM account
                         GROUP BY open_emp_id) emp_cnt);

# We can use scalar sub-queries in ORDER BY
SELECT emp.emp_id,
       CONCAT(emp.fname, ' ', emp.lname)         emp_name,
       (SELECT CONCAT(boss.fname, ' ', boss.lname)
        FROM employee boss
        WHERE boss.emp_id = emp.superior_emp_id) boss_name
FROM employee emp
WHERE emp.superior_emp_id IS NOT NULL
ORDER BY (SELECT boss.lname
          FROM employee boss
          WHERE boss.emp_id = emp.superior_emp_id), emp_id;

# We can use scalar sub-queries in INSERT
INSERT INTO account
(account_id, product_cd, cust_id, open_date, last_activity_date,
 status, open_branch_id, open_emp_id, avail_balance, pending_balance)
VALUES (NULL,
        (SELECT product_cd FROM product WHERE name = 'savings account'),
        (SELECT cust_id FROM customer WHERE fed_id = '555-55-5555'),
        '2005-01-25', '2005-01-25', 'ACTIVE',
        (SELECT branch_id FROM branch WHERE name = 'Quincy Branch'),
        (SELECT emp_id FROM employee WHERE lname = 'Portman' AND fname = 'Frank'),
        0, 0);
