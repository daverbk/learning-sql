# 5.1
SELECT e.emp_id, e.fname, e.lname, b.name
FROM employee e INNER JOIN branch b
    ON e.assigned_branch_id = b.branch_id;

# 5.2
SELECT a.account_id, c.fed_id, p.name
FROM account a INNER JOIN customer c
    ON a.cust_id = c.cust_id
    INNER JOIN product p
    ON a.product_cd = p.product_cd
WHERE c.cust_type_cd = 'I';

# 5.3
SELECT e1.emp_id, e1.fname, e1.lname
FROM employee e1 INNER JOIN employee mgr
    ON e1.superior_emp_id = mgr.emp_id
WHERE e1.dept_id != mgr.emp_id;
