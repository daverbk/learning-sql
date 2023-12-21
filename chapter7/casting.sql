# use cast()
SELECT cast('1456328' AS SIGNED INTEGER);

# will stop casting when sees a string literal
SELECT cast('999ABC111' AS SIGNED INTEGER);