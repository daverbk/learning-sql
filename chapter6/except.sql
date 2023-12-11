# EXCEPT return first table without
# possible intersections with second table
SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
    AND (title = 'Teller' OR title = 'Head Teller')
EXCEPT
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;

# Known as 'minus' in Oracle Database

# We can use EXCEPT ALL to remove
# records for each their appearance
# in the intersecting set