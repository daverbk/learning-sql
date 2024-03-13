USE bank;

# 9.1
SELECT account_id, product_cd, cust_id, avail_balance
FROM account a
WHERE product_cd IN (SELECT product_cd
                     FROM product
                     WHERE product_type_cd = 'LOAN');

# 9.2
SELECT account_id, product_cd, cust_id, avail_balance
FROM account a
WHERE EXISTS (SELECT 1
              FROM product p
              WHERE p.product_type_cd = 'LOAN'
                AND a.product_cd = p.product_cd);

# 9.3
SELECT e.emp_id, e.fname, e.lname, levels.name
FROM employee e
         INNER JOIN (SELECT 'trainee' name, '2004-01-01' start_dt, '2005-12-31' end_dt
                     UNION ALL
                     SELECT 'worker' name, '2002-01-01' start_dt, '2003-12-31' end_dt
                     UNION ALL
                     SELECT 'mentor' name, '2000-01-01' start_dt, '2001-12-31' end_dt) levels
                    ON e.start_date BETWEEN levels.start_dt AND levels.end_dt;

# 9.4
SELECT e.emp_id,
       e.fname,
       e.lname,
       (SELECT d.name
        FROM department d
        WHERE d.dept_id = e.dept_id)              dept_name,
       (SELECT b.name
        FROM branch b
        WHERE b.branch_id = e.assigned_branch_id) branch_name
FROM employee e;



