USE leetcode;

# Table: Insurance
CREATE TABLE IF NOT EXISTS Insurance
(
    pid      INT,
    tiv_2015 FLOAT,
    tiv_2016 FLOAT,
    lat      FLOAT,
    lon      FLOAT
);

TRUNCATE TABLE Insurance;

INSERT INTO Insurance (pid, tiv_2015, tiv_2016, lat, lon)
VALUES ('1', '10', '5', '10', '10');

INSERT INTO Insurance (pid, tiv_2015, tiv_2016, lat, lon)
VALUES ('2', '20', '20', '20', '20');

INSERT INTO Insurance (pid, tiv_2015, tiv_2016, lat, lon)
VALUES ('3', '10', '30', '20', '20');

INSERT INTO Insurance (pid, tiv_2015, tiv_2016, lat, lon)
VALUES ('4', '10', '40', '40', '40');

# Solution
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (SELECT tiv_2015
                   FROM Insurance
                   GROUP BY tiv_2015
                   HAVING COUNT(tiv_2015) > 1)
  AND (lat, lon) IN (SELECT lat, lon
                     FROM Insurance
                     GROUP BY lat, lon
                     HAVING COUNT(*) = 1);
