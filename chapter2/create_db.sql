# Create a new user
CREATE USER 'user'@'localhost' IDENTIFIED BY '*******';

# Grant all privileges on the user
GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost';

# Create a new db
CREATE DATABASE bank;

# Select new db
USE bank;

# Use "SOURCE :filepath" to import data

# Check current date/time
SELECT now() FROM dual;

# Check available character sets
SHOW CHARACTER SET;