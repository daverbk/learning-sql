USE bank;

# Indexes are special tables that the database
# search engine uses to speed up data retrieval
# An index is a sorted list of values from a table
# It doesn't contain the same data, just defined columns

# Create index
ALTER TABLE department
    ADD INDEX dept_name_idx (name);

# For SQL Server / Oracle Database
# CREATE INDEX dept_name_idx
# ON department (name)

# Check indexes for table
SHOW INDEX FROM department;

# Delete index
ALTER TABLE department
    DROP INDEX dept_name_idx;

# For SQL Server / Oracle Database
# DROP INDEX dept_name_idx

# Unique indexes
ALTER TABLE department
    ADD UNIQUE INDEX dept_name_idx (name);

# For SQL Server / Oracle Database
# CREATE UNIQUE INDEX dept_name_idx
# ON department (name)

# When trying to insert a duplicate value into a column
# that has a unique index, the database will throw an error
INSERT INTO department (dept_id, name)
VALUES (999, 'Operations');

# Composite indexes
ALTER TABLE employee
    ADD INDEX emp_names_idx (lname, fname);

# There are different indexes types: B-Tree, Text, Bitmap

# We can use the EXPLAIN statement to see how the database
# will execute a query
EXPLAIN
SELECT cust_id, SUM(avail_balance) tot_bal
FROM account
WHERE cust_id IN (1, 5, 9, 11)
GROUP BY cust_id;

# For SQL Server
# SET SHOWPLAN_TEXT ON
# For Oracle Database
# EXPLAIN PLAN
# it records the execution plan of a query into plan_table

# Let's check what will happen if we add an index
ALTER TABLE account
    ADD INDEX acc_bal_idx (cust_id, avail_balance);

EXPLAIN
SELECT cust_id, SUM(avail_balance) tot_bal
FROM account
WHERE cust_id IN (1, 5, 9, 11)
GROUP BY cust_id;

# Because of having an index the database will use
# the data from it without calling the account table

