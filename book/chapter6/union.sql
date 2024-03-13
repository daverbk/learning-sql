USE bank;

# A compound query with UNION set operator
SELECT 1 num, 'abc' str
UNION
SELECT 9 num, 'xyz' str;

# UNION ALL (all the records are included)
SELECT cust_id, lname name
FROM individual
UNION ALL
SELECT cust_id, name
FROM business;

# UNION ALL doesn't delete duplicates
SELECT cust_id, lname name
FROM individual
UNION ALL
SELECT cust_id, name
FROM business
UNION ALL
SELECT cust_id, name
FROM business;

# Another example of duplicates preservation
SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
  AND (title = 'Teller' OR title = 'Head Teller')
UNION ALL
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;

# UNION deletes the duplicates
SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
  AND (title = 'Teller' OR title = 'Head Teller')
UNION
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;
