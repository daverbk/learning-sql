USE bank;

# LIMIT can be used to restrict the number of rows returned by the query
SELECT open_emp_id, COUNT(*) how_many
FROM account
GROUP BY open_emp_id
LIMIT 3;

# LIMIT can be used in pair with ORDER BY to get the top N rows
SELECT open_emp_id, COUNT(*) how_many
FROM account
GROUP BY open_emp_id
ORDER BY how_many DESC
LIMIT 3;

# LIMIT is usually executed last in the query, so it is not
# possible for to edit the SELECT statement, only to restrict
# the number of rows returned

# LIMIT can be used with 2 arguments, the first is the offset
# and the second is the number of rows to return
SELECT open_emp_id, COUNT(*) how_many
FROM account
GROUP BY open_emp_id
ORDER BY how_many DESC
LIMIT 2, 1;

# INTO OUTFILE can be used to save the result of a query to a file
SELECT emp_id, fname, lname, start_date
INTO OUTFILE '/tmp/employee.csv'
FROM employee;

# FIELDS TERMINATED BY can be used to specify the delimiter
SELECT emp_id, fname, lname, start_date
INTO OUTFILE '/tmp/employee.csv'
    FIELDS TERMINATED BY ','
FROM employee;

# LINES TERMINATED BY can be used to specify the line terminator
SELECT emp_id, fname, lname, start_date
INTO OUTFILE '/tmp/employee.csv'
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
FROM employee;

# Upsert statements can be used
INSERT INTO branch
VALUES ('Los Angeles', 'CA', '90001', '213-555-1234', 'M', '10-01-2009')
ON DUPLICATE KEY UPDATE branch_id = branch_id;

# LIMIT can also be used for UPDATE and DELETE statements
UPDATE account
SET avail_balance = avail_balance + 100
WHERE product_cd IN ('CHK', 'SAV', 'MM')
ORDER BY open_date
LIMIT 10;

# DELETE / UPDATE can be applied to multiple tables at once
CREATE TABLE individual2 AS
SELECT *
FROM individual;

CREATE TABLE customer2 AS
SELECT *
FROM customer;

CREATE TABLE account2 AS
SELECT *
FROM account;

DELETE individual2, customer2, account2
FROM individual2
         INNER JOIN customer2
                    ON customer2.cust_id = individual2.cust_id
         INNER JOIN account2
                    ON account2.cust_id = individual2.cust_id
WHERE individual2.cust_id = 1;

UPDATE individual2
    INNER JOIN customer2
    ON customer2.cust_id = individual2.cust_id
    INNER JOIN account2
    ON account2.cust_id = individual2.cust_id
SET individual2.cust_id = individual2.cust_id + 10000,
    customer2.cust_id   = customer2.cust_id + 10000,
    account2.cust_id    = account2.cust_id + 10000
WHERE individual2.cust_id = 3;


# Multi-table DELETE / UPDATE will probably not work with InnoDB tables
