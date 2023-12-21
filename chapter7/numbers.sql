# We can use all the regular operators
# same as parentheses to set execution order
SELECT (37 * 59) / (78 - (8 * 6));

# Other functions on numbers include
# Acos()
# Asin()
# Atan()
# Cos()
# Exp()
# Ln()
# Sin()
# Sqrt()
# Tan()

# mod() for modulo
SELECT mod(10,4);

SELECT mod(22.75, 5);

# pow() for sets first argument to the power of the second argument
SELECT pow(2, 8);

SELECT pow(2, 10) kilobyte, pow(2, 20) megabyte,
       pow(2, 30) kilobyte, pow(2, 40) terabyte;

# ceil(), floor(), round(), truncate() for decimal arguments
# ceil(), floor() are rough
SELECT ceil(72.445), floor(72.445);

# round() is more precise
SELECT round(72.4999), round(72.5), round(72.500001);

# round() can be used with an optional argument
# to specify count decimal points
SELECT round(72.0909, 1), round(72.0909, 2), round(72.0909, 3);

# truncate() basically truncates
# data without rounding
SELECT truncate(72.0909, 1), truncate(72.0909, 2),
       truncate(72.0909, 3);

# we can pass negative second argument
# to round() and truncate() to apply changes
# to the right decimal numbers
SELECT round(17, -1), truncate(17, -1);

# sign() returns -1 if balance is negative, 0 if balance is 0
# and 1 if positive
# abs() returns an absolute balance
SELECT account_id, sign(avail_balance), abs(avail_balance)
FROM account;

