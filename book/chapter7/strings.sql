USE bank;

CREATE TABLE string_tbl
(
    char_fld  CHAR(30),
    vchar_fld VARCHAR(30),
    text_fld  TEXT
);

# The easiest way to fill a string column is via ''
INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
    VALUE ('This string is 28 characters',
           'This string is 28 characters',
           'This string is 28 characters');

# If we exceed the set column string length (30) will lead to exception
UPDATE string_tbl
SET vchar_fld = 'This is a piece of extremely long varchar data';

# To escape ' symbol use an extra ' or a \ :)
UPDATE string_tbl
SET text_fld = 'This string didn''t work, but it does now with an extra \'';

# Select with escape symbols
SELECT QUOTE(text_fld)
FROM string_tbl;

# We can use CHAR() to get unusual letters
SELECT CHAR(138, 139, 140);

# We can use concat to concatenate regular and unusual letters
SELECT CONCAT('danke sch', CHAR(195), 'n');

# To know ASCII element we can use ASCII()
SELECT ASCII('ö');

# We can use LENGTH() to count of letters in a string
SELECT LENGTH(char_fld)  char_length,
       LENGTH(vchar_fld) varchar_length,
       LENGTH(text_fld)  text_length
FROM string_tbl;

# We can find substring index (not found will return 0)
SELECT POSITION('characters' IN vchar_fld)
FROM string_tbl;

# Or locate(), the difference is that using the second
# we can set search starting position
SELECT LOCATE('is', vchar_fld, 5)
FROM string_tbl;

# We can compare strings with STRCMP('first', 'second')
# will return 0 if equal
# -1 if sorted first comes before second
# 1 if sorted first comes after second
SELECT STRCMP('12345', '12345')   12345_12345,
       STRCMP('abcd', 'xyz')      abcd_xyz,
       STRCMP('abcd', 'QRSTUV')   abcd_QRSTUV,
       STRCMP('qrstuv', 'QRSTUV') qrstuv_QRSTUV,
       STRCMP('12345', 'xyz')     12345_xyz,
       STRCMP('xyz', 'qrstuv')    xyz_qrstuv;

# The same way we can use LIKE and REGEXP
# 1 if matches
# 0 if not
SELECT name, name LIKE '%ns' ends_in_ns
FROM department;

# REGEXP example
SELECT cust_id,
       cust_type_cd,
       fed_id,
       fed_id REGEXP '.{3}-.{2}-.{4}' is_ss_no_format
FROM customer;

# We can use CONCAT to add data to the end of an existing string
UPDATE string_tbl
SET text_fld = CONCAT(text_fld, ', but now it is longer');

# We can use CONCAT for different data types at once
SELECT CONCAT(fname, ' ', lname, ' has been a ',
              title, ' since ', start_date) emp_narrative
FROM employee
WHERE title = 'Teller'
   OR title = 'Head Teller';

# We can use INSERT to insert data into a string
SELECT INSERT('goodbye world', 9, 0, 'cruel ') string;

# Depending on the third argument INSERT
# either inserts or replaces part of the string
SELECT INSERT('goodbye world', 1, 7, 'hello') string;

# We can get a substring with SUBSTRING
SELECT SUBSTRING('goodbye cruel world', 9, 5);
