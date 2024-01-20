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
GROUP BY machine_id;

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

# 570. Managers with at Least 5 Direct Reports
SELECT e1.name
FROM Employee e1
JOIN Employee e2 ON e1.id = e2.managerId
GROUP BY e2.managerId
HAVING COUNT(*) >= 5;

# 1934. Confirmation Rate
SELECT s.user_id, ROUND(AVG(IF(c.action = 'confirmed',1,0)), 2) confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id;

# 620. Not Boring Movies
SELECT *
FROM Cinema
WHERE MOD(id, 2) != 0
    AND description NOT LIKE '%boring%'
ORDER BY rating DESC;

# 1251. Average Selling Price
SELECT p.product_id, IFNULL(ROUND(SUM(u.units * p.price) / SUM(u.units), 2), 0) average_price
FROM Prices p
LEFT JOIN UnitsSold u
    ON p.product_id = u.product_id
    AND u.purchase_date BETWEEN start_date
    AND end_date
GROUP BY p.product_id;

# 1075. Project Employees I
SELECT p.project_id, ROUND(AVG(e.experience_years), 2) average_years
FROM Project p
LEFT JOIN Employee e
    ON p.employee_id = e.employee_id
GROUP BY p.project_id;

# 1633. Percentage of Users Attended a Contest
SELECT r.contest_id,
       ROUND(COUNT(*) / (SELECT COUNT(DISTINCT user_id) FROM Users) * 100, 2) percentage
FROM Register r
LEFT JOIN Users u
    ON u.user_id = r.user_id
GROUP BY r.contest_id
ORDER BY percentage DESC, r.contest_id;

# 1211. Queries Quality and Percentage
SELECT query_name,
    ROUND(AVG(rating / position), 2) quality,
    ROUND(SUM(IF(rating < 3, 1, 0)) * 100 / COUNT(*), 2) poor_query_percentage
FROM Queries
WHERE query_name IS NOT NULL
GROUP BY query_name;

# 1193. Monthly Transactions I
SELECT DATE_FORMAT(trans_date, '%Y-%m') month,
    country,
    COUNT(*) trans_count,
    SUM(IF(state = 'approved', 1, 0)) approved_count,
    SUM(amount) trans_total_amount,
    SUM(IF(state = 'approved', amount, 0)) approved_total_amount
FROM Transactions
GROUP BY month, country;

# 1174. Immediate Food Delivery II
SELECT ROUND(AVG(order_date = customer_pref_delivery_date) * 100, 2) immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date)
    FROM Delivery
    GROUP BY customer_id
);

# 550. Game Play Analysis IV
SELECT ROUND(COUNT(DISTINCT player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) fraction
FROM Activity
WHERE (player_id, DATE_SUB(event_date, INTERVAL 1 DAY))
IN (SELECT player_id, MIN(event_date) AS first_login FROM ACTIVITY GROUP BY player_id);

# 2356. Number of Unique Subjects Taught by Each Teacher
SELECT teacher_id, COUNT(DISTINCT subject_id) cnt
FROM Teacher
GROUP BY teacher_id;

# 1141. User Activity for the Past 30 Days I
SELECT activity_date day, COUNT(DISTINCT user_id) active_users
FROM Activity
WHERE DATEDIFF('2019-07-27', activity_date) < 30
    AND DATEDIFF('2019-07-27', activity_date) >= 0
GROUP BY day;
