USE bank;

# Outer join includes all rows of a table and
# adds data from the other table where it find a match
SELECT a.account_id, a.cust_id, b.name
FROM account a
         LEFT OUTER JOIN business b
                         ON a.cust_id = b.cust_id;

# The word on the left of the FROM keyword is responsible
# for the count rows that are included in the result set
# the word on the right of the FROM keyword is responsible
# for the rows data in case matches are found
SELECT c.cust_id, b.name
FROM customer c
         LEFT OUTER JOIN business b
                         ON c.cust_id = b.cust_id;

SELECT c.cust_id, b.name
FROM customer c
         RIGHT OUTER JOIN business b
                          ON c.cust_id = b.cust_id;

# We can use outer join with multiple tables
SELECT a.account_id,
       a.product_cd,
       CONCAT(i.fname, ' ', i.lname) person_name,
       b.name AS                     business_name
FROM account a
         LEFT OUTER JOIN individual i
                         ON a.cust_id = i.cust_id
         LEFT OUTER JOIN business b
                         ON a.cust_id = b.cust_id;

# Recursive outer joins
SELECT e.fname, e.lname, e.superior_emp_id, m.fname, m.lname
FROM employee e
         LEFT OUTER JOIN employee m
                         ON e.superior_emp_id = m.emp_id;

# Cross join
SELECT days.dt, COUNT(a.account_id)
FROM account a
         RIGHT OUTER JOIN
     (SELECT DATE_ADD('2004-01-01', INTERVAL (ones.num + tens.num + hundreds.num) DAY) dt
      FROM (SELECT 0 num
            UNION ALL
            SELECT 1
            UNION ALL
            SELECT 2
            UNION ALL
            SELECT 3
            UNION ALL
            SELECT 4
            UNION ALL
            SELECT 5
            UNION ALL
            SELECT 6
            UNION ALL
            SELECT 7
            UNION ALL
            SELECT 8
            UNION ALL
            SELECT 9) ones
               CROSS JOIN
           (SELECT 0 num
            UNION ALL
            SELECT 10
            UNION ALL
            SELECT 20
            UNION ALL
            SELECT 30
            UNION ALL
            SELECT 40
            UNION ALL
            SELECT 50
            UNION ALL
            SELECT 60
            UNION ALL
            SELECT 70
            UNION ALL
            SELECT 80
            UNION ALL
            SELECT 90) tens
               CROSS JOIN
           (SELECT 0 num
            UNION ALL
            SELECT 100
            UNION ALL
            SELECT 200
            UNION ALL
            SELECT 300) hundreds
      WHERE DATE_ADD('2004-01-01', INTERVAL (ones.num + tens.num + hundreds.num) DAY) < '2005-01-01') days
     ON days.dt = a.open_date
GROUP BY days.dt
HAVING COUNT(a.account_id) > 0;

# Natural join
# Searches for columns with the same name in both tables
SELECT a.account_id, a.cust_id, c.cust_type_cd, c.fed_id
FROM account a
         NATURAL JOIN customer c;

# If the column names don't match a cross join is performed
SELECT a.account_id, a.cust_id, a.open_branch_id
FROM account a
         NATURAL JOIN branch b;

# It's recommended to avoid using natural join
# preferring to use inner join with the columns specified
