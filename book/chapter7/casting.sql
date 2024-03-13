# use cast()
SELECT CAST('1456328' AS SIGNED INTEGER);

# will stop casting when sees a string literal
SELECT CAST('999ABC111' AS SIGNED INTEGER);
