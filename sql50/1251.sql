USE leetcode;

# Tables: Prices, UnitsSold
CREATE TABLE IF NOT EXISTS Prices
(
    product_id INT,
    start_date DATE,
    end_date   DATE,
    price      INT
);

CREATE TABLE IF NOT EXISTS UnitsSold
(
    product_id    INT,
    purchase_date DATE,
    units         INT
);

TRUNCATE TABLE Prices;

INSERT INTO Prices (product_id, start_date, end_date, price)
VALUES ('1', '2019-02-17', '2019-02-28', '5');

INSERT INTO Prices (product_id, start_date, end_date, price)
VALUES ('1', '2019-03-01', '2019-03-22', '20');

INSERT INTO Prices (product_id, start_date, end_date, price)
VALUES ('2', '2019-02-01', '2019-02-20', '15');

INSERT INTO Prices (product_id, start_date, end_date, price)
VALUES ('2', '2019-02-21', '2019-03-31', '30');

TRUNCATE TABLE UnitsSold;

INSERT INTO UnitsSold (product_id, purchase_date, units)
VALUES ('1', '2019-02-25', '100');

INSERT INTO UnitsSold (product_id, purchase_date, units)
VALUES ('1', '2019-03-01', '15');

INSERT INTO UnitsSold (product_id, purchase_date, units)
VALUES ('2', '2019-02-10', '200');

INSERT INTO UnitsSold (product_id, purchase_date, units)
VALUES ('2', '2019-03-22', '30');

# Solution
SELECT p.product_id,
       IFNULL(ROUND(SUM(u.units * p.price) / SUM(u.units), 2), 0) average_price
FROM Prices p
         LEFT JOIN UnitsSold u
                   ON p.product_id = u.product_id
                       AND u.purchase_date BETWEEN start_date
                          AND end_date
GROUP BY p.product_id;
