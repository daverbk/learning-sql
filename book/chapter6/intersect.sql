USE bank;

# This query returns an empty set
# as two sets are not intersecting in any way
(SELECT emp_id, fname, lname
 FROM employee)
INTERSECT
SELECT cust_id, fname, lname
FROM individual;

# Would return emp_id 10
SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
  AND (title = 'Teller' OR title = 'Head Teller')
INTERSECT
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;

# We can use INTERSECT ALL
# that will preserve the duplicates if any exist
