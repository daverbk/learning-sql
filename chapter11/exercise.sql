# 11.1
SELECT emp_id,
       CASE
           WHEN title IN ('President', 'Vice President', 'Treasurer', 'Loan Manager')
                THEN 'Management'
           WHEN title IN ('Operations Manager', 'Head Teller', 'Teller')
                THEN 'Operations'
           ELSE 'Unknown'
       END department
FROM employee;

# 11.2
SELECT
    SUM(IF(open_branch_id = 1, 1, 0)) branch_1,
    SUM(IF(open_branch_id = 2, 1, 0)) branch_2,
    SUM(IF(open_branch_id = 3, 1, 0)) branch_3,
    SUM(IF(open_branch_id = 4, 1, 0)) branch_4
FROM account;
