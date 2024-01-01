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

# 1661. Average Time of Process per Machine
SELECT machine_id,
       ROUND(SUM(CASE WHEN activity_type = 'start' THEN timestamp * -1 ELSE timestamp END) * 1.0
                 / (SELECT COUNT(DISTINCT process_id)), 3) AS processing_time
FROM Activity
GROUP BY machine_id

# 577. Employee Bonus
SELECT e.name name, b.bonus bonus
FROM Employee e
LEFT JOIN Bonus b
ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus is null;

# 1280. Students and Examinations
SELECT s.student_id, s.student_name, sub.subject_name, COUNT(e.subject_name) attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
    ON s.student_id = e.student_id
    AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
