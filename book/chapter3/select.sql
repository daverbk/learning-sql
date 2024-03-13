USE bank;

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
SELECT emp_id,
       'ACTIVE',
       emp_id * 3.14159,
       UPPER(lname)
FROM employee;

# Calling mysql functions
SELECT VERSION(), USER(), DATABASE();

# Table names pseudonyms
SELECT emp_id,
       'ACTIVE'         status,
       emp_id * 3.14159 empid_x_pi,
       UPPER(lname)     last_upper_name
FROM employee;

# Distinct results
SELECT DISTINCT cust_id
FROM account;

# Sub query
SELECT e.emp_id, e.fname, e.lname
FROM (SELECT emp_id, fname, lname, start_date, title FROM employee) e;

# Views
CREATE VIEW employee_vw AS
SELECT emp_id,
       fname,
       lname,
       YEAR(start_date) start_year
FROM employee;

SELECT emp_id, start_year
FROM employee_vw;

# Joining preview
SELECT employee.emp_id,
       employee.fname,
       employee.lname,
       department.name dept_name
FROM employee
         INNER JOIN department
                    ON employee.dept_id = department.dept_id;

# Joining preview with pseudonyms
SELECT e.emp_id,
       e.fname,
       e.lname,
       d.name dept_name
FROM employee e
         INNER JOIN department d
                    ON e.dept_id = d.dept_id;

# Where
SELECT emp_id, fname, lname, start_date, title
FROM employee
WHERE title = 'Head Teller';

# Where may contain as mush conditions as required with AND, OR
SELECT emp_id, fname, lname, start_date, title
FROM employee
WHERE title = 'Head Teller'
  AND start_date > '2002-01-01';

SELECT emp_id, fname, lname, start_date, title
FROM employee
WHERE title = 'Head Teller'
   OR start_date > '2002-01-01';

SELECT emp_id, fname, lname, start_date, title
FROM employee
WHERE (title = 'Head Teller' AND start_date > '2002-01-01')
   OR (title = 'Teller' AND start_date > '2003-01-01');

# Order by
SELECT open_emp_id, product_cd
FROM account
ORDER BY open_emp_id;

SELECT open_emp_id, product_cd
FROM account
ORDER BY open_emp_id, product_cd;

# DESC AND ASC (the second is used by default) with LIMIT (isn't included into ANSI standard)
SELECT account_id, product_cd, open_date, avail_balance
FROM account
ORDER BY avail_balance DESC
LIMIT 5;

# Sorting via expressions
SELECT cust_id, cust_type_cd, city, state, fed_id
FROM customer
ORDER BY RIGHT(fed_id, 3);

# Sorting by column number
SELECT emp_id, title, start_date, fname, lname
FROM employee
ORDER BY 2, 5;
