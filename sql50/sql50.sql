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

# 1070. Product Sales Analysis III
SELECT product_id, year first_year, quantity, price
FROM Sales
WHERE (product_id, year) IN (
    SELECT
      product_id,
      MIN(year) year
    FROM
      Sales
    GROUP BY
      product_id
);

# 596. Classes More Than 5 Students
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) > 4;

# 1729. Find Followers Count
SELECT user_id, COUNT(follower_id) followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;

# 619. Biggest Single Number
SELECT MAX(num) AS num
FROM (SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1
) unique_numbers;

# 1045. Customers Who Bought All Products
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) =
    (
        SELECT COUNT(product_key)
        FROM Product
);

# 1731. The Number of Employees Which Report to Each Employee
SELECT e1.employee_id, e1.name, COUNT(e2.employee_id) reports_count, ROUND(AVG(e2.age)) average_age
FROM Employees e1
INNER JOIN Employees e2
    ON e1.employee_id = e2.reports_to
GROUP BY e1.employee_id
ORDER BY e1.employee_id;

# 1789. Primary Department for Each Employee
SELECT employee_id, department_id
FROM employee
WHERE primary_flag = 'Y'
UNION
SELECT employee_id, department_id
FROM employee
GROUP BY employee_id
HAVING COUNT(*) = 1;

# 610. Triangle Judgement
SELECT x,y,z,
CASE
  WHEN x + y <= z
  OR x + z <= y
  OR y + z <= x
  THEN 'No'
  ELSE 'Yes'
END triangle
FROM triangle;

# 180. Consecutive Numbers
SELECT DISTINCT l1.Num ConsecutiveNums
FROM Logs l1,
    Logs l2,
    Logs l3
WHERE l1.Id = l2.Id - 1
    AND l2.Id = l3.Id - 1
    AND l1.Num = l2.Num
    AND l2.Num = l3.Num;


# 1164. Product Price at a Given Date
SELECT product_id, 10 AS price
FROM Products
GROUP BY product_id
HAVING MIN(change_date) > '2019-08-16'
UNION ALL
SELECT product_id, new_price price
FROM Products
WHERE (product_id, change_date) IN (
    SELECT product_id, MAX(change_date)
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
);

# 1204. Last Person to Fit in the Bus
SELECT person_name FROM
(SELECT *, SUM(weight) OVER(ORDER BY turn) AS weight_so_far FROM Queue) cnt
WHERE cnt.weight_so_far <= 1000
ORDER BY weight_so_far DESC
LIMIT 1;

# 1907. Count Salary Categories
SELECT "Low Salary" category, sum(income < 20000) accounts_count
FROM Accounts
UNION
SELECT "Average Salary" category, sum(income BETWEEN 20000 AND 50000) accounts_count
FROM Accounts
UNION
SELECT "High Salary" category, sum(income > 50000) accounts_count
FROM Accounts;

# 1978. Employees Whose Manager Left the Company
SELECT e1.employee_id
FROM Employees e1
LEFT JOIN Employees e2
    ON e1.manager_id = e2.employee_id
WHERE e2.employee_id IS NULL
    AND e1.manager_id IS NOT NULL
    AND e1.salary < 30000
ORDER BY employee_id;

# 626. Exchange Seats
SELECT
    IF(id < (SELECT MAX(id) FROM Seat),
    IF(id % 2 = 0, id - 1, id + 1),
    IF(id % 2 = 0, id - 1, id)) AS id,
    student
FROM Seat
ORDER BY id;

# 1341. Movie Rating
(SELECT name AS results
FROM Users u
INNER JOIN MovieRating mr
USING(user_id)
GROUP BY user_id
ORDER BY COUNT(movie_id) DESC, name ASC
LIMIT 1)

UNION ALL

(SELECT title AS results
FROM MovieRating mr
INNER JOIN Movies
USING (movie_id)
WHERE  MONTH(created_at) = 2 AND YEAR(created_at) = 2020
GROUP BY movie_id
ORDER BY AVG(rating) DESC, title ASC
LIMIT 1);

# 1321. Restaurant Growth
SELECT
    visits.visited_on AS visited_on,
    SUM(c.amount) AS amount,
    ROUND(SUM(c.amount) / 7.0, 2) average_amount
FROM (
    SELECT DISTINCT visited_on
    FROM Customer
    WHERE DATEDIFF(
        visited_on,
        (SELECT MIN(visited_on) FROM Customer)
    ) >= 6
) visits
LEFT JOIN Customer c
ON DATEDIFF(visits.visited_on, c.visited_on) BETWEEN 0 and 6
GROUP BY visits.visited_on
ORDER BY visited_on;

# 602. Friend Requests II: Who Has the Most Friends
SELECT id, COUNT(*) num
FROM(
    SELECT requester_id id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id id
    FROM RequestAccepted
) tbl
GROUP BY id
ORDER BY num DESC
LIMIT 1;

# 1667. Fix Names in a Table
SELECT user_id,
CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2))) name
FROM Users
ORDER BY user_id;

# 1527. Patients With a Condition
SELECT patient_id, patient_name, conditions
FROM Patients
WHERE conditions LIKE 'DIAB1%'
    OR conditions LIKE '% DIAB1%';

# 196. Delete Duplicate Emails
DELETE p1
FROM Person p1, Person p2
WHERE p1.email = p2.email AND p1.id > p2.id;

# 176. Second Highest Salary
SELECT MAX(SALARY) AS SecondHighestSalary
FROM EMPLOYEE
WHERE SALARY < (SELECT MAX(SALARY) FROM EMPLOYEE);

# 1484. Group Sold Products By The Date
SELECT sell_date,
       COUNT(DISTINCT product) num_sold,
       GROUP_CONCAT(DISTINCT product) products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;

# 1327. List the Products Ordered in a Period
SELECT p.product_name, SUM(o.unit) unit
FROM Products p
INNER JOIN Orders o
    ON p.product_id = o.product_id
WHERE MONTH(o.order_date) = 2 AND YEAR(o.order_date) = 2020
GROUP BY p.product_id
HAVING unit >= 100;
