USE bank;

# 6.1
# 1) { L M N O P Q R S T }
# 2) { L M N O P P Q R S T }
# 3) { P }
# 4) { L M N O }

# 6.2
SELECT fname, lname
FROM individual
UNION ALL
SELECT fname, lname
FROM employee;

# 6.3
SELECT fname, lname
FROM individual
UNION ALL
SELECT fname, lname
FROM employee
ORDER BY lname;
