# There are two settings of time zone
# System means that the sql server uses
# machine install on time zone settings
SELECT @@GLOBAL.TIME_ZONE, @@SESSION.TIME_ZONE;

# Set timezone for session (time_zone_name must be filled up)
SET TIME_ZONE = 'Europe/Zurich';

# To check timezones available
SELECT name
FROM mysql.time_zone_name;

# Default format for date types
# Date - YYYY-MM-DD
# Datetime - YYYY-MM-DD HH:MI:SS
# Timestamp - YYYY-MM-DD HH:MI:SS
# Time - HHH:MI:SS
UPDATE transaction
SET txn_date = '2005-03-27 15:30:00'
WHERE txn_id = 99999;

# String to date casting
SELECT CAST('2005-03-27 15:30:00' AS DATETIME);

SELECT CAST('2005-03-27' AS DATE) date_field,
       CAST('108:17:57' AS TIME)  time_field;

# We can use str_to_date() with a special formatting
UPDATE individual
SET birth_date = STR_TO_DATE('March 27, 2005', '%M %d, %Y')
WHERE cust_id = 9999;

# Current date time functions
SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();

# We can use date_add to add interval to a date
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY);

UPDATE transaction
SET txn_date = DATE_ADD(txn_date, INTERVAL '3:27:11' HOUR_SECOND)
WHERE txn_id = 9999;

# last_day() can select the last day of a given month
SELECT LAST_DAY('2005-03-25');

# convert_tz handles converting between timezones
SELECT CURRENT_TIMESTAMP()                                  current_est,
       CONVERT_TZ(CURRENT_TIMESTAMP(), 'US/Eastern', 'UTC') current_utc;

# dayname() returns day of the week
SELECT DAYNAME('2005-03-22');

# extract() can be used with an interval name
SELECT EXTRACT(YEAR FROM '2005-03-22 22:19:05');

# datediff() return the count of full dates between two dates
SELECT DATEDIFF('2005-09-05', '2005-06-22');
