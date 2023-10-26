# Empty set
SELECT emp_id, fname, lname
FROM employee
WHERE lname = 'Bkadf1';

# The opposite
SELECT fname, lname
FROM employee;

# The "*" means all
SELECT *
FROM department;

# Not only column names can be selected
SELECT emp_id, 'ACTIVE',
emp_id * 3.14159, UPPER(lname)
FROM employee;

# Calling mysql functions
SELECT version(), user(), database();

# Table names pseudonyms
SELECT emp_id,
'ACTIVE' status,
emp_id * 3.14159 empid_x_pi,
UPPER(lname) last_upper_name
FROM employee;

# Distinct results
SELECT DISTINCT cust_id
FROM account;