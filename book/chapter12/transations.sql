# START TRANSACTION, COMMIT, ROLLBACK are executed implicitly
# All db servers have a 'start transaction' command
START TRANSACTION;

# All db servers have a 'commit' command
COMMIT;

# All db servers have a 'rollback' command
ROLLBACK;

# It's recommended to disable the autocommit mode
SET autocommit = 0;

# For SQL Server
# SET IMPLICIT_TRANSACTIONS ON;

# If we don't want to completely rollback
# there is a 'savepoint' command
SAVEPOINT my_savepoint;

# To rollback to the savepoint
ROLLBACK TO SAVEPOINT my_savepoint;

# Example usage of savepoint
START TRANSACTION;

UPDATE product
SET date_retired = CURRENT_TIMESTAMP()
WHERE product_cd = 'XYZ';

SAVEPOINT before_close_accounts;

UPDATE account
SET status = 'CLOSED', close_date = CURRENT_TIMESTAMP(),
    last_activity_date = CURRENT_TIMESTAMP()
WHERE product_cd = 'XYZ';

ROLLBACK TO SAVEPOINT before_close_accounts;

COMMIT;

# There are multiple storage engines in MySQL
# InnoDB is the most popular one
SHOW TABLE STATUS LIKE 'transaction';

# To change the storage engine
ALTER TABLE transaction ENGINE = InnoDB;
