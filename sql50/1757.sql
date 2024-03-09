USE leetcode;

# Table: Products
CREATE TABLE IF NOT EXISTS Products
(
    product_id INT,
    low_fats   ENUM ('Y', 'N'),
    recyclable ENUM ('Y','N')
);

TRUNCATE TABLE Products;

INSERT INTO Products (product_id, low_fats, recyclable)
VALUES ('0', 'Y', 'N');

INSERT INTO Products (product_id, low_fats, recyclable)
VALUES ('1', 'Y', 'Y');

INSERT INTO Products (product_id, low_fats, recyclable)
VALUES ('2', 'N', 'Y');

INSERT INTO Products (product_id, low_fats, recyclable)
VALUES ('3', 'Y', 'Y');

INSERT INTO Products (product_id, low_fats, recyclable)
VALUES ('4', 'N', 'N');

# Solution
SELECT product_id
FROM Products
WHERE low_fats = 'Y'
  AND recyclable = 'Y';
