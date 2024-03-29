USE leetcode;

# Tables: Sales, Product
CREATE TABLE IF NOT EXISTS Sales
(
    sale_id    INT,
    product_id INT,
    year       INT,
    quantity   INT,
    price      INT
);

CREATE TABLE IF NOT EXISTS Product
(
    product_id   INT,
    product_name VARCHAR(10)
);

TRUNCATE TABLE Sales;

INSERT INTO Sales (sale_id, product_id, year, quantity, price)
VALUES ('1', '100', '2008', '10', '5000');

INSERT INTO Sales (sale_id, product_id, year, quantity, price)
VALUES ('2', '100', '2009', '12', '5000');

INSERT INTO Sales (sale_id, product_id, year, quantity, price)
VALUES ('7', '200', '2011', '15', '9000');

TRUNCATE TABLE Product;

INSERT INTO Product (product_id, product_name)
VALUES ('100', 'Nokia');

INSERT INTO Product (product_id, product_name)
VALUES ('200', 'Apple');

INSERT INTO Product (product_id, product_name)
VALUES ('300', 'Samsung');

# Solution
SELECT product_id, year first_year, quantity, price
FROM Sales
WHERE (product_id, year) IN (SELECT product_id,
                                    MIN(year) year
                             FROM Sales
                             GROUP BY product_id);
