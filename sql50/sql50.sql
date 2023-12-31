# 1757. Recyclable and Low Fat Products
SELECT product_id FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';

# 584. Find Customer Referee
SELECT name FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL;

# 595. Big Countries
SELECT name,population,area FROM World
WHERE area > 2999999 OR population > 24999999;

# 1148. Article Views I
SELECT DISTINCT author_id as id FROM Views
WHERE author_id = viewer_id
ORDER BY id;

# 1683. Invalid Tweets
SELECT tweet_id FROM Tweets
WHERE LENGTH(content) > 15;

# 1378. Replace Employee ID With The Unique Identifier
SELECT EmployeeUNI.unique_id, Employees.name
FROM Employees LEFT JOIN EmployeeUNI
ON Employees.id = EmployeeUNI.id;

# 1068. Product Sales Analysis I
SELECT Product.product_name, Sales.year, Sales.price
FROM Sales
JOIN Product
ON Sales.product_id = Product.product_id;

# 1581. Customer Who Visited but Did Not Make Any Transactions
SELECT customer_id, COUNT(*) AS count_no_trans
FROM Visits
WHERE visit_id NOT IN (SELECT visit_id FROM Transactions)
GROUP BY customer_id;

# 197. Rising Temperature
SELECT w1.id
FROM Weather w1
JOIN Weather w2
ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature;