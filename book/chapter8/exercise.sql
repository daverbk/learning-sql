USE bank;

# 8.1
SELECT COUNT(*)
FROM account;

# 8.2
SELECT cust_id, COUNT(account_id) accounts_count
FROM account
GROUP BY cust_id;

# 8.3
SELECT cust_id, COUNT(account_id) accounts_count
FROM account
GROUP BY cust_id
HAVING accounts_count > 1;

# 8.4
SELECT product_cd, open_branch_id, SUM(avail_balance) avaliable_remainder
FROM account
GROUP BY product_cd, open_branch_id
HAVING COUNT(*) > 1
ORDER BY avaliable_remainder DESC;
