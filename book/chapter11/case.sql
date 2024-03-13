USE bank;

# Selecting customer names
# depending on the customer type
SELECT c.cust_id,
       c.fed_id,
       CASE
           WHEN c.cust_type_cd = 'I'
               THEN CONCAT(i.fname, ' ', i.lname)
           WHEN c.cust_type_cd = 'B'
               THEN b.name
           ELSE 'Unknown'
           END AS name
FROM customer c
         LEFT OUTER JOIN individual i
                         ON c.cust_id = i.cust_id
         LEFT OUTER JOIN business b
                         ON c.cust_id = b.cust_id;

# Searched case expression syntax
# CASE
#     WHEN condition1 THEN result1
#     WHEN condition2 THEN result2
#     ...
#     ELSE result -> is not required
# END

# CASE statements can contain any type of expression
SELECT c.cust_id,
       c.fed_id,
       CASE
           WHEN c.cust_type_cd = 'I'
               THEN (SELECT CONCAT(i.fname, ' ', i.lname)
                     FROM individual i
                     WHERE i.cust_id = c.cust_id)
           WHEN c.cust_type_cd = 'B'
               THEN (SELECT b.name
                     FROM business b
                     WHERE b.cust_id = c.cust_id)
           ELSE 'Unknown'
           END AS name
FROM customer c;

# Simple CASE expression syntax
# CASE VALUE
#     WHEN condition1 THEN result1
#     WHEN condition2 THEN result2
#     ...
#     ELSE result -> is not required
# END

# Simple CASE expression example
# CASE customer.cust_type_cd
#     WHEN 'I' THEN (
#         SELECT CONCAT(i.fname, ' ', i.lname)
#         FROM individual i
#         WHERE i.cust_id = c.cust_id
#     )
#     WHEN 'B' THEN (
#         SELECT b.name
#         FROM business b
#         WHERE b.cust_id = c.cust_id
#     )
#     ELSE 'Unknown Customer Type'
# END

# CASE / IF expressions examples
SELECT SUM(IF(EXTRACT(YEAR FROM open_date) = 2000, 1, 0)) year_2000,
       SUM(IF(EXTRACT(YEAR FROM open_date) = 2001, 1, 0)) year_2001,
       SUM(IF(EXTRACT(YEAR FROM open_date) = 2002, 1, 0)) year_2002,
       SUM(IF(EXTRACT(YEAR FROM open_date) = 2003, 1, 0)) year_2003,
       SUM(IF(EXTRACT(YEAR FROM open_date) = 2004, 1, 0)) year_2004,
       SUM(IF(EXTRACT(YEAR FROM open_date) = 2005, 1, 0)) year_2005
FROM ACCOUNT
WHERE open_date > '1999-12-31';

SELECT CONCAT('ALERT! : Account #', a.account_id, ' has incorrect balance!')
FROM account a
WHERE (a.avail_balance, a.pending_balance) <>
      (SELECT SUM(CASE
                      WHEN t.funds_avail_date > CURRENT_TIMESTAMP()
                          THEN 0
                      WHEN t.txn_type_cd = 'DBT'
                          THEN t.amount * -1
                      ELSE t.amount
          END),
              SUM(IF(t.txn_type_cd = 'DBT', t.amount * -1, t.amount))
       FROM transaction t
       WHERE t.account_id = a.account_id);

SELECT c.cust_id,
       c.fed_id,
       c.cust_type_cd,
       IF(EXISTS(SELECT 1
                 FROM account a
                 WHERE a.cust_id = c.cust_id
                   AND a.product_cd = 'CHK'), 'Y', 'N') has_checking,
       IF(EXISTS(SELECT 1
                 FROM account a
                 WHERE a.cust_id = c.cust_id
                   AND a.product_cd = 'SAV'), 'Y', 'N') has_savings
FROM customer c;

SELECT c.cust_id,
       c.fed_id,
       c.cust_type_cd,
       CASE (SELECT COUNT(*)
             FROM account a
             WHERE a.cust_id = c.cust_id)
           WHEN 0 THEN 'None'
           WHEN 1 THEN '1'
           WHEN 2 THEN '2'
           ELSE '3+'
           END num_accounts
FROM customer c;

# When dividing by zero MySql assigns null
SELECT 100 / 0;
# NULL

# Conditional logic can help with this
SELECT a.cust_id,
       a.product_cd,
       a.avail_balance /
       IF(prod_tots.tot_balance = 0, 1, prod_tots.tot_balance) AS pct_of_total
FROM account a
         INNER JOIN (SELECT a.product_cd, SUM(a.avail_balance) tot_balance
                     FROM account a
                     GROUP BY a.product_cd) prod_tots
                    ON a.product_cd = prod_tots.product_cd;
