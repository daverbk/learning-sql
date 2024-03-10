# There are 4 types of constraints:
# Primary Key, Foreign Key, Unique, and Check

# Primary Key
# A primary key is a field in a table which uniquely
# identifies each row/record in a database table

# Foreign Key
# A foreign key is a field in a table that is primary key in another table

# Unique
# A unique constraint is a single field or combination
# of fields that uniquely defines a record

# Check
# A check constraint is used to limit the
# value range that can be placed in a column

# Create a constraint
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

# We can alter a table to add constraints
ALTER TABLE product
ADD CONSTRAINT pk_product PRIMARY KEY (product_cd);

ALTER TABLE product
ADD CONSTRAINT fk_product_type_cd FOREIGN KEY (product_type_cd)
    REFERENCES product_type (product_type_cd);

# We can also drop constraints
ALTER TABLE product
DROP PRIMARY KEY;

ALTER TABLE product
DROP FOREIGN KEY fk_product_type_cd;

# Cascading constraints
ALTER TABLE product
DROP CONSTRAINT fk_product_type_cd;

ALTER TABLE product
ADD CONSTRAINT fk_product_type_cd FOREIGN KEY (product_type_cd)
    REFERENCES product_type (product_type_cd)
    ON UPDATE CASCADE;

# If we now update the product_type_cd in the product_type table
# the product_type_cd in the product table will also be updated
UPDATE product_type
SET product_type_cd = 'XYZ'
WHERE product_type_cd = 'LOAN';

SELECT product_type_cd, name
FROM product_type;

SELECT product_type_cd, product_cd, name
FROM product
ORDER BY product_type_cd;

# We can also set the ON DELETE CASCADE
ALTER TABLE product
DROP CONSTRAINT fk_product_type_cd;

ALTER TABLE product
ADD CONSTRAINT fk_product_type_cd FOREIGN KEY (product_type_cd)
    REFERENCES product_type (product_type_cd)
    ON DELETE CASCADE;

# If we now delete a product_type_cd in the product_type table
# the product_type_cd in the product table will also be deleted
