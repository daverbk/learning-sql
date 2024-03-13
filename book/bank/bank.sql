/* begin table creation */

CREATE TABLE department
(
    dept_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name    VARCHAR(20)       NOT NULL,
    CONSTRAINT pk_department PRIMARY KEY (dept_id)
);

CREATE TABLE branch
(
    branch_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name      VARCHAR(20)       NOT NULL,
    address   VARCHAR(30),
    city      VARCHAR(20),
    state     VARCHAR(2),
    zip       VARCHAR(12),
    CONSTRAINT pk_branch PRIMARY KEY (branch_id)
);

CREATE TABLE employee
(
    emp_id             SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    fname              VARCHAR(20)       NOT NULL,
    lname              VARCHAR(20)       NOT NULL,
    start_date         DATE              NOT NULL,
    end_date           DATE,
    superior_emp_id    SMALLINT UNSIGNED,
    dept_id            SMALLINT UNSIGNED,
    title              VARCHAR(20),
    assigned_branch_id SMALLINT UNSIGNED,
    CONSTRAINT fk_e_emp_id
        FOREIGN KEY (superior_emp_id) REFERENCES employee (emp_id),
    CONSTRAINT fk_dept_id
        FOREIGN KEY (dept_id) REFERENCES department (dept_id),
    CONSTRAINT fk_e_branch_id
        FOREIGN KEY (assigned_branch_id) REFERENCES branch (branch_id),
    CONSTRAINT pk_employee PRIMARY KEY (emp_id)
);

CREATE TABLE product_type
(
    product_type_cd VARCHAR(10) NOT NULL,
    name            VARCHAR(50) NOT NULL,
    CONSTRAINT pk_product_type PRIMARY KEY (product_type_cd)
);

CREATE TABLE product
(
    product_cd      VARCHAR(10) NOT NULL,
    name            VARCHAR(50) NOT NULL,
    product_type_cd VARCHAR(10) NOT NULL,
    date_offered    DATE,
    date_retired    DATE,
    CONSTRAINT fk_product_type_cd FOREIGN KEY (product_type_cd)
        REFERENCES product_type (product_type_cd),
    CONSTRAINT pk_product PRIMARY KEY (product_cd)
);

CREATE TABLE customer
(
    cust_id      INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fed_id       VARCHAR(12)      NOT NULL,
    cust_type_cd ENUM ('I','B')   NOT NULL,
    address      VARCHAR(30),
    city         VARCHAR(20),
    state        VARCHAR(20),
    postal_code  VARCHAR(10),
    CONSTRAINT pk_customer PRIMARY KEY (cust_id)
);

CREATE TABLE individual
(
    cust_id    INTEGER UNSIGNED NOT NULL,
    fname      VARCHAR(30)      NOT NULL,
    lname      VARCHAR(30)      NOT NULL,
    birth_date DATE,
    CONSTRAINT fk_i_cust_id FOREIGN KEY (cust_id)
        REFERENCES customer (cust_id),
    CONSTRAINT pk_individual PRIMARY KEY (cust_id)
);

CREATE TABLE business
(
    cust_id     INTEGER UNSIGNED NOT NULL,
    name        VARCHAR(40)      NOT NULL,
    state_id    VARCHAR(10)      NOT NULL,
    incorp_date DATE,
    CONSTRAINT fk_b_cust_id FOREIGN KEY (cust_id)
        REFERENCES customer (cust_id),
    CONSTRAINT pk_business PRIMARY KEY (cust_id)
);

CREATE TABLE officer
(
    officer_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    cust_id    INTEGER UNSIGNED  NOT NULL,
    fname      VARCHAR(30)       NOT NULL,
    lname      VARCHAR(30)       NOT NULL,
    title      VARCHAR(20),
    start_date DATE              NOT NULL,
    end_date   DATE,
    CONSTRAINT fk_o_cust_id FOREIGN KEY (cust_id)
        REFERENCES business (cust_id),
    CONSTRAINT pk_officer PRIMARY KEY (officer_id)
);

CREATE TABLE account
(
    account_id         INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    product_cd         VARCHAR(10)      NOT NULL,
    cust_id            INTEGER UNSIGNED NOT NULL,
    open_date          DATE             NOT NULL,
    close_date         DATE,
    last_activity_date DATE,
    status             ENUM ('ACTIVE','CLOSED','FROZEN'),
    open_branch_id     SMALLINT UNSIGNED,
    open_emp_id        SMALLINT UNSIGNED,
    avail_balance      FLOAT(10, 2),
    pending_balance    FLOAT(10, 2),
    CONSTRAINT fk_product_cd FOREIGN KEY (product_cd)
        REFERENCES product (product_cd),
    CONSTRAINT fk_a_cust_id FOREIGN KEY (cust_id)
        REFERENCES customer (cust_id),
    CONSTRAINT fk_a_branch_id FOREIGN KEY (open_branch_id)
        REFERENCES branch (branch_id),
    CONSTRAINT fk_a_emp_id FOREIGN KEY (open_emp_id)
        REFERENCES employee (emp_id),
    CONSTRAINT pk_account PRIMARY KEY (account_id)
);

CREATE TABLE transaction
(
    txn_id              INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    txn_date            DATETIME         NOT NULL,
    account_id          INTEGER UNSIGNED NOT NULL,
    txn_type_cd         ENUM ('DBT','CDT'),
    amount              DOUBLE(10, 2)    NOT NULL,
    teller_emp_id       SMALLINT UNSIGNED,
    execution_branch_id SMALLINT UNSIGNED,
    funds_avail_date    DATETIME,
    CONSTRAINT fk_t_account_id FOREIGN KEY (account_id)
        REFERENCES account (account_id),
    CONSTRAINT fk_teller_emp_id FOREIGN KEY (teller_emp_id)
        REFERENCES employee (emp_id),
    CONSTRAINT fk_exec_branch_id FOREIGN KEY (execution_branch_id)
        REFERENCES branch (branch_id),
    CONSTRAINT pk_transaction PRIMARY KEY (txn_id)
);

/* end table creation */

/* begin bank population */

/* department bank */
INSERT INTO department
    (dept_id, name)
VALUES (NULL, 'Operations'),
       (NULL, 'Loans'),
       (NULL, 'Administration');

/* branch bank */
INSERT INTO branch
    (branch_id, name, address, city, state, zip)
VALUES (NULL, 'Headquarters', '3882 Main St.', 'Waltham', 'MA', '02451'),
       (NULL, 'Woburn Branch', '422 Maple St.', 'Woburn', 'MA', '01801'),
       (NULL, 'Quincy Branch', '125 Presidential Way', 'Quincy', 'MA', '02169'),
       (NULL, 'So. NH Branch', '378 Maynard Ln.', 'Salem', 'NH', '03079');

/* employee bank */
INSERT INTO employee
(emp_id, fname, lname, start_date,
 dept_id, title, assigned_branch_id)
VALUES (NULL, 'Michael', 'Smith', '2005-06-22',
        (SELECT dept_id FROM department WHERE name = 'Administration'),
        'President',
        (SELECT branch_id FROM branch WHERE name = 'Headquarters')),
       (NULL, 'Susan', 'Barker', '2006-09-12',
        (SELECT dept_id FROM department WHERE name = 'Administration'),
        'Vice President',
        (SELECT branch_id FROM branch WHERE name = 'Headquarters')),
       (NULL, 'Robert', 'Tyler', '2005-02-09',
        (SELECT dept_id FROM department WHERE name = 'Administration'),
        'Treasurer',
        (SELECT branch_id FROM branch WHERE name = 'Headquarters')),
       (NULL, 'Susan', 'Hawthorne', '2006-04-24',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Operations Manager',
        (SELECT branch_id FROM branch WHERE name = 'Headquarters')),
       (NULL, 'John', 'Gooding', '2007-11-14',
        (SELECT dept_id FROM department WHERE name = 'Loans'),
        'Loan Manager',
        (SELECT branch_id FROM branch WHERE name = 'Headquarters')),
       (NULL, 'Helen', 'Fleming', '2008-03-17',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Head Teller',
        (SELECT branch_id FROM branch WHERE name = 'Headquarters')),
       (NULL, 'Chris', 'Tucker', '2008-09-15',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Teller',
        (SELECT branch_id FROM branch WHERE name = 'Headquarters')),
       (NULL, 'Sarah', 'Parker', '2006-12-02',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Teller',
        (SELECT branch_id FROM branch WHERE name = 'Headquarters')),
       (NULL, 'Jane', 'Grossman', '2006-05-03',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Teller',
        (SELECT branch_id FROM branch WHERE name = 'Headquarters')),
       (NULL, 'Paula', 'Roberts', '2006-07-27',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Head Teller',
        (SELECT branch_id FROM branch WHERE name = 'Woburn Branch')),
       (NULL, 'Thomas', 'Ziegler', '2004-10-23',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Teller',
        (SELECT branch_id FROM branch WHERE name = 'Woburn Branch')),
       (NULL, 'Samantha', 'Jameson', '2007-01-08',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Teller',
        (SELECT branch_id FROM branch WHERE name = 'Woburn Branch')),
       (NULL, 'John', 'Blake', '2004-05-11',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Head Teller',
        (SELECT branch_id FROM branch WHERE name = 'Quincy Branch')),
       (NULL, 'Cindy', 'Mason', '2006-08-09',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Teller',
        (SELECT branch_id FROM branch WHERE name = 'Quincy Branch')),
       (NULL, 'Frank', 'Portman', '2007-04-01',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Teller',
        (SELECT branch_id FROM branch WHERE name = 'Quincy Branch')),
       (NULL, 'Theresa', 'Markham', '2005-03-15',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Head Teller',
        (SELECT branch_id FROM branch WHERE name = 'So. NH Branch')),
       (NULL, 'Beth', 'Fowler', '2006-06-29',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Teller',
        (SELECT branch_id FROM branch WHERE name = 'So. NH Branch')),
       (NULL, 'Rick', 'Tulman', '2006-12-12',
        (SELECT dept_id FROM department WHERE name = 'Operations'),
        'Teller',
        (SELECT branch_id FROM branch WHERE name = 'So. NH Branch'));

/* create bank for self-referencing foreign key 'superior_emp_id' */
CREATE TEMPORARY TABLE emp_tmp AS
SELECT emp_id, fname, lname
FROM employee;

UPDATE employee
SET superior_emp_id =
            (SELECT emp_id FROM emp_tmp WHERE lname = 'Smith' AND fname = 'Michael')
WHERE ((lname = 'Barker' AND fname = 'Susan')
    OR (lname = 'Tyler' AND fname = 'Robert'));
UPDATE employee
SET superior_emp_id =
            (SELECT emp_id FROM emp_tmp WHERE lname = 'Tyler' AND fname = 'Robert')
WHERE lname = 'Hawthorne'
  AND fname = 'Susan';
UPDATE employee
SET superior_emp_id =
            (SELECT emp_id FROM emp_tmp WHERE lname = 'Hawthorne' AND fname = 'Susan')
WHERE ((lname = 'Gooding' AND fname = 'John')
    OR (lname = 'Fleming' AND fname = 'Helen')
    OR (lname = 'Roberts' AND fname = 'Paula')
    OR (lname = 'Blake' AND fname = 'John')
    OR (lname = 'Markham' AND fname = 'Theresa'));
UPDATE employee
SET superior_emp_id =
            (SELECT emp_id FROM emp_tmp WHERE lname = 'Fleming' AND fname = 'Helen')
WHERE ((lname = 'Tucker' AND fname = 'Chris')
    OR (lname = 'Parker' AND fname = 'Sarah')
    OR (lname = 'Grossman' AND fname = 'Jane'));
UPDATE employee
SET superior_emp_id =
            (SELECT emp_id FROM emp_tmp WHERE lname = 'Roberts' AND fname = 'Paula')
WHERE ((lname = 'Ziegler' AND fname = 'Thomas')
    OR (lname = 'Jameson' AND fname = 'Samantha'));
UPDATE employee
SET superior_emp_id =
            (SELECT emp_id FROM emp_tmp WHERE lname = 'Blake' AND fname = 'John')
WHERE ((lname = 'Mason' AND fname = 'Cindy')
    OR (lname = 'Portman' AND fname = 'Frank'));
UPDATE employee
SET superior_emp_id =
            (SELECT emp_id FROM emp_tmp WHERE lname = 'Markham' AND fname = 'Theresa')
WHERE ((lname = 'Fowler' AND fname = 'Beth')
    OR (lname = 'Tulman' AND fname = 'Rick'));

DROP TABLE emp_tmp;

/* recreate employee self-referencing foreign key */
ALTER TABLE employee
    ADD CONSTRAINT fk_e_emp_id
        FOREIGN KEY (superior_emp_id) REFERENCES employee (emp_id);

/* product type bank */
INSERT INTO product_type
    (product_type_cd, name)
VALUES ('ACCOUNT', 'Customer Accounts'),
       ('LOAN', 'Individual and Business Loans'),
       ('INSURANCE', 'Insurance Offerings');

/* product bank */
INSERT INTO product
    (product_cd, name, product_type_cd, date_offered)
VALUES ('CHK', 'checking account', 'ACCOUNT', '2004-01-01'),
       ('SAV', 'savings account', 'ACCOUNT', '2004-01-01'),
       ('MM', 'money market account', 'ACCOUNT', '2004-01-01'),
       ('CD', 'certificate of deposit', 'ACCOUNT', '2004-01-01'),
       ('MRT', 'home mortgage', 'LOAN', '2004-01-01'),
       ('AUT', 'auto loan', 'LOAN', '2004-01-01'),
       ('BUS', 'business line of credit', 'LOAN', '2004-01-01'),
       ('SBL', 'small business loan', 'LOAN', '2004-01-01');

/* residential customer bank */
INSERT INTO customer
(cust_id, fed_id, cust_type_cd,
 address, city, state, postal_code)
VALUES (NULL, '111-11-1111', 'I', '47 Mockingbird Ln', 'Lynnfield', 'MA', '01940'),
       (NULL, '222-22-2222', 'I', '372 Clearwater Blvd', 'Woburn', 'MA', '01801'),
       (NULL, '333-33-3333', 'I', '18 Jessup Rd', 'Quincy', 'MA', '02169'),
       (NULL, '444-44-4444', 'I', '12 Buchanan Ln', 'Waltham', 'MA', '02451'),
       (NULL, '555-55-5555', 'I', '2341 Main St', 'Salem', 'NH', '03079'),
       (NULL, '666-66-6666', 'I', '12 Blaylock Ln', 'Waltham', 'MA', '02451'),
       (NULL, '777-77-7777', 'I', '29 Admiral Ln', 'Wilmington', 'MA', '01887'),
       (NULL, '888-88-8888', 'I', '472 Freedom Rd', 'Salem', 'NH', '03079'),
       (NULL, '999-99-9999', 'I', '29 Maple St', 'Newton', 'MA', '02458'),
       (NULL, '04-1111111', 'B', '7 Industrial Way', 'Salem', 'NH', '03079'),
       (NULL, '04-2222222', 'B', '287A Corporate Ave', 'Wilmington', 'MA', '01887'),
       (NULL, '04-3333333', 'B', '789 Main St', 'Salem', 'NH', '03079'),
       (NULL, '04-4444444', 'B', '4772 Presidential Way', 'Quincy', 'MA', '02169');

INSERT INTO individual
    (cust_id, fname, lname, birth_date)
SELECT cust_id, 'James', 'Hadley', '1977-04-22'
FROM customer
WHERE fed_id = '111-11-1111'
UNION ALL
SELECT cust_id, 'Susan', 'Tingley', '1973-08-15'
FROM customer
WHERE fed_id = '222-22-2222'
UNION ALL
SELECT cust_id, 'Frank', 'Tucker', '1963-02-06'
FROM customer
WHERE fed_id = '333-33-3333'
UNION ALL
SELECT cust_id, 'John', 'Hayward', '1971-12-22'
FROM customer
WHERE fed_id = '444-44-4444'
UNION ALL
SELECT cust_id, 'Charles', 'Frasier', '1976-08-25'
FROM customer
WHERE fed_id = '555-55-5555'
UNION ALL
SELECT cust_id, 'John', 'Spencer', '1967-09-14'
FROM customer
WHERE fed_id = '666-66-6666'
UNION ALL
SELECT cust_id, 'Margaret', 'Young', '1951-03-19'
FROM customer
WHERE fed_id = '777-77-7777'
UNION ALL
SELECT cust_id, 'George', 'Blake', '1982-07-01'
FROM customer
WHERE fed_id = '888-88-8888'
UNION ALL
SELECT cust_id, 'Richard', 'Farley', '1973-06-16'
FROM customer
WHERE fed_id = '999-99-9999';

/* corporate customer bank */
INSERT INTO business
    (cust_id, name, state_id, incorp_date)
SELECT cust_id, 'Chilton Engineering', '12-345-678', '1995-05-01'
FROM customer
WHERE fed_id = '04-1111111'
UNION ALL
SELECT cust_id, 'Northeast Cooling Inc.', '23-456-789', '2001-01-01'
FROM customer
WHERE fed_id = '04-2222222'
UNION ALL
SELECT cust_id, 'Superior Auto Body', '34-567-890', '2002-06-30'
FROM customer
WHERE fed_id = '04-3333333'
UNION ALL
SELECT cust_id, 'AAA Insurance Inc.', '45-678-901', '1999-05-01'
FROM customer
WHERE fed_id = '04-4444444';


INSERT INTO officer
    (officer_id, cust_id, fname, lname, title, start_date)
SELECT NULL, cust_id, 'John', 'Chilton', 'President', '1995-05-01'
FROM customer
WHERE fed_id = '04-1111111'
UNION ALL
SELECT NULL, cust_id, 'Paul', 'Hardy', 'President', '2001-01-01'
FROM customer
WHERE fed_id = '04-2222222'
UNION ALL
SELECT NULL, cust_id, 'Carl', 'Lutz', 'President', '2002-06-30'
FROM customer
WHERE fed_id = '04-3333333'
UNION ALL
SELECT NULL, cust_id, 'Stanley', 'Cheswick', 'President', '1999-05-01'
FROM customer
WHERE fed_id = '04-4444444';

/* residential account bank */
INSERT INTO account (account_id, product_cd, cust_id, open_date,
                     last_activity_date, status, open_branch_id,
                     open_emp_id, avail_balance, pending_balance)
SELECT NULL,
       a.prod_cd,
       c.cust_id,
       a.open_date,
       a.last_date,
       'ACTIVE',
       e.branch_id,
       e.emp_id,
       a.avail,
       a.pend
FROM customer c
         CROSS JOIN
     (SELECT b.branch_id, e.emp_id
      FROM branch b
               INNER JOIN employee e ON e.assigned_branch_id = b.branch_id
      WHERE b.city = 'Woburn'
      LIMIT 1) e
         CROSS JOIN
     (SELECT 'CHK'        prod_cd,
             '2000-01-15' open_date,
             '2005-01-04' last_date,
             1057.75      avail,
             1057.75      pend
      UNION ALL
      SELECT 'SAV'        prod_cd,
             '2000-01-15' open_date,
             '2004-12-19' last_date,
             500.00       avail,
             500.00       pend
      UNION ALL
      SELECT 'CD'         prod_cd,
             '2004-06-30' open_date,
             '2004-06-30' last_date,
             3000.00      avail,
             3000.00      pend) a
WHERE c.fed_id = '111-11-1111';
INSERT INTO account (account_id, product_cd, cust_id, open_date,
                     last_activity_date, status, open_branch_id,
                     open_emp_id, avail_balance, pending_balance)
SELECT NULL,
       a.prod_cd,
       c.cust_id,
       a.open_date,
       a.last_date,
       'ACTIVE',
       e.branch_id,
       e.emp_id,
       a.avail,
       a.pend
FROM customer c
         CROSS JOIN
     (SELECT b.branch_id, e.emp_id
      FROM branch b
               INNER JOIN employee e ON e.assigned_branch_id = b.branch_id
      WHERE b.city = 'Woburn'
      LIMIT 1) e
         CROSS JOIN
     (SELECT 'CHK'        prod_cd,
             '2001-03-12' open_date,
             '2004-12-27' last_date,
             2258.02      avail,
             2258.02      pend
      UNION ALL
      SELECT 'SAV'        prod_cd,
             '2001-03-12' open_date,
             '2004-12-11' last_date,
             200.00       avail,
             200.00       pend) a
WHERE c.fed_id = '222-22-2222';
INSERT INTO account (account_id, product_cd, cust_id, open_date,
                     last_activity_date, status, open_branch_id,
                     open_emp_id, avail_balance, pending_balance)
SELECT NULL,
       a.prod_cd,
       c.cust_id,
       a.open_date,
       a.last_date,
       'ACTIVE',
       e.branch_id,
       e.emp_id,
       a.avail,
       a.pend
FROM customer c
         CROSS JOIN
     (SELECT b.branch_id, e.emp_id
      FROM branch b
               INNER JOIN employee e ON e.assigned_branch_id = b.branch_id
      WHERE b.city = 'Quincy'
      LIMIT 1) e
         CROSS JOIN
     (SELECT 'CHK'        prod_cd,
             '2002-11-23' open_date,
             '2004-11-30' last_date,
             1057.75      avail,
             1057.75      pend
      UNION ALL
      SELECT 'MM'         prod_cd,
             '2002-12-15' open_date,
             '2004-12-05' last_date,
             2212.50      avail,
             2212.50      pend) a
WHERE c.fed_id = '333-33-3333';
INSERT INTO account (account_id, product_cd, cust_id, open_date,
                     last_activity_date, status, open_branch_id,
                     open_emp_id, avail_balance, pending_balance)
SELECT NULL,
       a.prod_cd,
       c.cust_id,
       a.open_date,
       a.last_date,
       'ACTIVE',
       e.branch_id,
       e.emp_id,
       a.avail,
       a.pend
FROM customer c
         CROSS JOIN
     (SELECT b.branch_id, e.emp_id
      FROM branch b
               INNER JOIN employee e ON e.assigned_branch_id = b.branch_id
      WHERE b.city = 'Waltham'
      LIMIT 1) e
         CROSS JOIN
     (SELECT 'CHK'        prod_cd,
             '2003-09-12' open_date,
             '2005-01-03' last_date,
             534.12       avail,
             534.12       pend
      UNION ALL
      SELECT 'SAV'        prod_cd,
             '2000-01-15' open_date,
             '2004-10-24' last_date,
             767.77       avail,
             767.77       pend
      UNION ALL
      SELECT 'MM'         prod_cd,
             '2004-09-30' open_date,
             '2004-11-11' last_date,
             5487.09      avail,
             5487.09      pend) a
WHERE c.fed_id = '444-44-4444';
INSERT INTO account (account_id, product_cd, cust_id, open_date,
                     last_activity_date, status, open_branch_id,
                     open_emp_id, avail_balance, pending_balance)
SELECT NULL,
       a.prod_cd,
       c.cust_id,
       a.open_date,
       a.last_date,
       'ACTIVE',
       e.branch_id,
       e.emp_id,
       a.avail,
       a.pend
FROM customer c
         CROSS JOIN
     (SELECT b.branch_id, e.emp_id
      FROM branch b
               INNER JOIN employee e ON e.assigned_branch_id = b.branch_id
      WHERE b.city = 'Salem'
      LIMIT 1) e
         CROSS JOIN
     (SELECT 'CHK'        prod_cd,
             '2004-01-27' open_date,
             '2005-01-05' last_date,
             2237.97      avail,
             2897.97      pend) a
WHERE c.fed_id = '555-55-5555';
INSERT INTO account (account_id, product_cd, cust_id, open_date,
                     last_activity_date, status, open_branch_id,
                     open_emp_id, avail_balance, pending_balance)
SELECT NULL,
       a.prod_cd,
       c.cust_id,
       a.open_date,
       a.last_date,
       'ACTIVE',
       e.branch_id,
       e.emp_id,
       a.avail,
       a.pend
FROM customer c
         CROSS JOIN
     (SELECT b.branch_id, e.emp_id
      FROM branch b
               INNER JOIN employee e ON e.assigned_branch_id = b.branch_id
      WHERE b.city = 'Waltham'
      LIMIT 1) e
         CROSS JOIN
     (SELECT 'CHK'        prod_cd,
             '2002-08-24' open_date,
             '2004-11-29' last_date,
             122.37       avail,
             122.37       pend
      UNION ALL
      SELECT 'CD'         prod_cd,
             '2004-12-28' open_date,
             '2004-12-28' last_date,
             10000.00     avail,
             10000.00     pend) a
WHERE c.fed_id = '666-66-6666';
INSERT INTO account (account_id, product_cd, cust_id, open_date,
                     last_activity_date, status, open_branch_id,
                     open_emp_id, avail_balance, pending_balance)
SELECT NULL,
       a.prod_cd,
       c.cust_id,
       a.open_date,
       a.last_date,
       'ACTIVE',
       e.branch_id,
       e.emp_id,
       a.avail,
       a.pend
FROM customer c
         CROSS JOIN
     (SELECT b.branch_id, e.emp_id
      FROM branch b
               INNER JOIN employee e ON e.assigned_branch_id = b.branch_id
      WHERE b.city = 'Woburn'
      LIMIT 1) e
         CROSS JOIN
     (SELECT 'CD'         prod_cd,
             '2004-01-12' open_date,
             '2004-01-12' last_date,
             5000.00      avail,
             5000.00      pend) a
WHERE c.fed_id = '777-77-7777';
INSERT INTO account (account_id, product_cd, cust_id, open_date,
                     last_activity_date, status, open_branch_id,
                     open_emp_id, avail_balance, pending_balance)
SELECT NULL,
       a.prod_cd,
       c.cust_id,
       a.open_date,
       a.last_date,
       'ACTIVE',
       e.branch_id,
       e.emp_id,
       a.avail,
       a.pend
FROM customer c
         CROSS JOIN
     (SELECT b.branch_id, e.emp_id
      FROM branch b
               INNER JOIN employee e ON e.assigned_branch_id = b.branch_id
      WHERE b.city = 'Salem'
      LIMIT 1) e
         CROSS JOIN
     (SELECT 'CHK'        prod_cd,
             '2001-05-23' open_date,
             '2005-01-03' last_date,
             3487.19      avail,
             3487.19      pend
      UNION ALL
      SELECT 'SAV'        prod_cd,
             '2001-05-23' open_date,
             '2004-10-12' last_date,
             387.99       avail,
             387.99       pend) a
WHERE c.fed_id = '888-88-8888';
INSERT INTO account (account_id, product_cd, cust_id, open_date,
                     last_activity_date, status, open_branch_id,
                     open_emp_id, avail_balance, pending_balance)
SELECT NULL,
       a.prod_cd,
       c.cust_id,
       a.open_date,
       a.last_date,
       'ACTIVE',
       e.branch_id,
       e.emp_id,
       a.avail,
       a.pend
FROM customer c
         CROSS JOIN
     (SELECT b.branch_id, e.emp_id
      FROM branch b
               INNER JOIN employee e ON e.assigned_branch_id = b.branch_id
      WHERE b.city = 'Waltham'
      LIMIT 1) e
         CROSS JOIN
     (SELECT 'CHK'        prod_cd,
             '2003-07-30' open_date,
             '2004-12-15' last_date,
             125.67       avail,
             125.67       pend
      UNION ALL
      SELECT 'MM'         prod_cd,
             '2004-10-28' open_date,
             '2004-10-28' last_date,
             9345.55      avail,
             9845.55      pend
      UNION ALL
      SELECT 'CD'         prod_cd,
             '2004-06-30' open_date,
             '2004-06-30' last_date,
             1500.00      avail,
             1500.00      pend) a
WHERE c.fed_id = '999-99-9999';

/* corporate account bank */
INSERT INTO account (account_id, product_cd, cust_id, open_date,
                     last_activity_date, status, open_branch_id,
                     open_emp_id, avail_balance, pending_balance)
SELECT NULL,
       a.prod_cd,
       c.cust_id,
       a.open_date,
       a.last_date,
       'ACTIVE',
       e.branch_id,
       e.emp_id,
       a.avail,
       a.pend
FROM customer c
         CROSS JOIN
     (SELECT b.branch_id, e.emp_id
      FROM branch b
               INNER JOIN employee e ON e.assigned_branch_id = b.branch_id
      WHERE b.city = 'Salem'
      LIMIT 1) e
         CROSS JOIN
     (SELECT 'CHK'        prod_cd,
             '2002-09-30' open_date,
             '2004-12-15' last_date,
             23575.12     avail,
             23575.12     pend
      UNION ALL
      SELECT 'BUS'        prod_cd,
             '2002-10-01' open_date,
             '2004-08-28' last_date,
             0            avail,
             0            pend) a
WHERE c.fed_id = '04-1111111';
INSERT INTO account (account_id, product_cd, cust_id, open_date,
                     last_activity_date, status, open_branch_id,
                     open_emp_id, avail_balance, pending_balance)
SELECT NULL,
       a.prod_cd,
       c.cust_id,
       a.open_date,
       a.last_date,
       'ACTIVE',
       e.branch_id,
       e.emp_id,
       a.avail,
       a.pend
FROM customer c
         CROSS JOIN
     (SELECT b.branch_id, e.emp_id
      FROM branch b
               INNER JOIN employee e ON e.assigned_branch_id = b.branch_id
      WHERE b.city = 'Woburn'
      LIMIT 1) e
         CROSS JOIN
     (SELECT 'BUS'        prod_cd,
             '2004-03-22' open_date,
             '2004-11-14' last_date,
             9345.55      avail,
             9345.55      pend) a
WHERE c.fed_id = '04-2222222';
INSERT INTO account (account_id, product_cd, cust_id, open_date,
                     last_activity_date, status, open_branch_id,
                     open_emp_id, avail_balance, pending_balance)
SELECT NULL,
       a.prod_cd,
       c.cust_id,
       a.open_date,
       a.last_date,
       'ACTIVE',
       e.branch_id,
       e.emp_id,
       a.avail,
       a.pend
FROM customer c
         CROSS JOIN
     (SELECT b.branch_id, e.emp_id
      FROM branch b
               INNER JOIN employee e ON e.assigned_branch_id = b.branch_id
      WHERE b.city = 'Salem'
      LIMIT 1) e
         CROSS JOIN
     (SELECT 'CHK'        prod_cd,
             '2003-07-30' open_date,
             '2004-12-15' last_date,
             38552.05     avail,
             38552.05     pend) a
WHERE c.fed_id = '04-3333333';
INSERT INTO account (account_id, product_cd, cust_id, open_date,
                     last_activity_date, status, open_branch_id,
                     open_emp_id, avail_balance, pending_balance)
SELECT NULL,
       a.prod_cd,
       c.cust_id,
       a.open_date,
       a.last_date,
       'ACTIVE',
       e.branch_id,
       e.emp_id,
       a.avail,
       a.pend
FROM customer c
         CROSS JOIN
     (SELECT b.branch_id, e.emp_id
      FROM branch b
               INNER JOIN employee e ON e.assigned_branch_id = b.branch_id
      WHERE b.city = 'Quincy'
      LIMIT 1) e
         CROSS JOIN
     (SELECT 'SBL'        prod_cd,
             '2004-02-22' open_date,
             '2004-12-17' last_date,
             50000.00     avail,
             50000.00     pend) a
WHERE c.fed_id = '04-4444444';

/* put $100 in all checking/savings accounts on Jan 5th, 2008 */
INSERT INTO transaction (txn_id, txn_date, account_id, txn_type_cd,
                         amount, funds_avail_date)
SELECT NULL, '2008-01-05', a.account_id, 'DBT', 100, '2008-01-05'
FROM account a
WHERE a.product_cd IN ('CHK', 'SAV', 'CD', 'MM');

/* end bank population */
