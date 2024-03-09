USE leetcode;

# Table: Activities
CREATE TABLE IF NOT EXISTS Activities
(
    sell_date DATE,
    product   VARCHAR(20)
);

TRUNCATE TABLE Activities;

INSERT INTO Activities (sell_date, product)
VALUES ('2020-05-30', 'Headphone')

INSERT INTO Activities (sell_date, product)
VALUES ('2020-06-01', 'Pencil');

INSERT INTO Activities (sell_date, product)
VALUES ('2020-06-02', 'Mask');

INSERT INTO Activities (sell_date, product)
VALUES ('2020-05-30', 'Basketball')

INSERT INTO Activities (sell_date, product)
VALUES ('2020-06-01', 'Bible');

INSERT INTO Activities (sell_date, product)
VALUES ('2020-06-02', 'Mask');

INSERT INTO Activities (sell_date, product)
VALUES ('2020-05-30', 'T-Shirt');

# Solution
SELECT sell_date,
       COUNT(DISTINCT product)        num_sold,
       GROUP_CONCAT(DISTINCT product) products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;
