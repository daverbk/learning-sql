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
SELECT MOD(10, 4);

SELECT MOD(22.75, 5);

# pow() for sets first argument to the power of the second argument
SELECT POW(2, 8);

SELECT POW(2, 10) kilobyte,
       POW(2, 20) megabyte,
       POW(2, 30) kilobyte,
       POW(2, 40) terabyte;

# ceil(), floor(), round(), truncate() for decimal arguments
# ceil(), floor() are rough
SELECT CEIL(72.445), FLOOR(72.445);

# round() is more precise
SELECT ROUND(72.4999), ROUND(72.5), ROUND(72.500001);

# round() can be used with an optional argument
# to specify count decimal points
SELECT ROUND(72.0909, 1), ROUND(72.0909, 2), ROUND(72.0909, 3);

# truncate() basically truncates
# data without rounding
SELECT TRUNCATE(72.0909, 1),
       TRUNCATE(72.0909, 2),
       TRUNCATE(72.0909, 3);

# we can pass negative second argument
# to round() and truncate() to apply changes
# to the right decimal numbers
SELECT ROUND(17, -1), TRUNCATE(17, -1);

# sign() returns -1 if balance is negative, 0 if balance is 0
# and 1 if positive
# abs() returns an absolute balance
SELECT account_id, SIGN(avail_balance), ABS(avail_balance)
FROM account;
