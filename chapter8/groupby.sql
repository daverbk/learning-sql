# Open accounts by employee
SELECT open_emp_id, COUNT(*) how_many
FROM account
GROUP BY open_emp_id;

# GROUP BY is performed after WHERE
# Results in "Invalid use of group function"
SELECT open_emp_id, COUNT(*) how_many
FROM account
WHERE COUNT(*) > 4
GROUP BY open_emp_id;

# We can use HAVING in this case
SELECT open_emp_id, COUNT(*) how_many
FROM account
GROUP BY open_emp_id
HAVING COUNT(*) > 4;

# Aggregate functions perform operations over the each row of a group
# Examples: Max(), Min(), Avg(), Sum(), Count()
SELECT MAX(avail_balance) max_balance,
       MIN(avail_balance) min_balance,
       AVG(avail_balance) avg_balance,
       SUM(avail_balance) tot_balance,
       COUNT(*)           num_accounts
FROM account
WHERE product_cd = 'CHK';

# Would result in error because server cannot
# resolve the groups to apply aggregate functions to
SELECT product_cd,
       MAX(avail_balance) max_balance,
       MIN(avail_balance) min_balance,
       AVG(avail_balance) avg_balance,
       SUM(avail_balance) tot_balance,
       COUNT(*) num_accounts
FROM account;

# Server knows that it has to first set up 6
# and apply functions to each of them
SELECT product_cd,
       MAX(avail_balance) max_balance,
       MIN(avail_balance) min_balance,
       AVG(avail_balance) avg_balance,
       SUM(avail_balance) tot_balance,
       COUNT(*) num_accounts
FROM account
GROUP BY product_cd;

# Counting distinct records
SELECT COUNT(DISTINCT open_emp_id)
FROM account;

# Aggregate functions can be used with expressions
SELECT MAX(pending_balance - avail_balance) max_uncleared
FROM account;

# grouping by multiple columns
# we receive 14 groups
SELECT product_cd, open_branch_id,
       SUM(avail_balance) tot_balance
FROM account
GROUP BY product_cd, open_branch_id;

# grouping by expression
SELECT EXTRACT(YEAR FROM start_date) year,
       COUNT(*) how_many
FROM employee
GROUP BY EXTRACT(YEAR FROM start_date);

# rollups
SELECT product_cd, open_branch_id,
       SUM(avail_balance) tot_balance
FROM account
GROUP BY product_cd, open_branch_id WITH ROLLUP;

# having is used to filter grouping
# where is executed before grouping
# having is executed after grouping
SELECT product_cd, SUM(avail_balance) prod_balance
FROM account
WHERE status = 'ACTIVE'
GROUP BY product_cd
HAVING SUM(avail_balance) >= 10000;
