USE bank;

# 10.1
SELECT p.product_cd, a.account_id, a.cust_id, a.avail_balance
FROM product p
         LEFT OUTER JOIN account a
                         ON a.product_cd = p.product_cd;

# 10.2
SELECT p.product_cd, a.account_id, a.cust_id, a.avail_balance
FROM account a
         RIGHT OUTER JOIN product p
                          ON p.product_cd = a.product_cd;

# 10.3
SELECT a.account_id, a.product_cd, i.fname, i.lname, b.name
FROM account a
         LEFT OUTER JOIN business b
                         ON a.cust_id = b.cust_id
         LEFT OUTER JOIN individual i
                         ON a.cust_id = i.cust_id;

# 10.4
SELECT ones.num + tens.num + 1 number
FROM (SELECT 0 num
      UNION ALL
      SELECT 1 num
      UNION ALL
      SELECT 2 num
      UNION ALL
      SELECT 3 num
      UNION ALL
      SELECT 4 num
      UNION ALL
      SELECT 5 num
      UNION ALL
      SELECT 6 num
      UNION ALL
      SELECT 7 num
      UNION ALL
      SELECT 8 num
      UNION ALL
      SELECT 9 num) ones
         CROSS JOIN
     (SELECT 0 num
      UNION ALL
      SELECT 10 num
      UNION ALL
      SELECT 20 num
      UNION ALL
      SELECT 30 num
      UNION ALL
      SELECT 40 num
      UNION ALL
      SELECT 50 num
      UNION ALL
      SELECT 60 num
      UNION ALL
      SELECT 70 num
      UNION ALL
      SELECT 80 num
      UNION ALL
      SELECT 90 num) tens;

