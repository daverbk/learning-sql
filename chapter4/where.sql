# WHERE true OR true -> true
# WHERE true OR false -> true
# WHERE false OR true -> true
# WHERE false OR false -> false

SELECT * FROM employee
WHERE title = 'Teller' OR start_date < '2003-01-01';

SELECT * FROM employee
WHERE title = 'Teller' AND start_date < '2003-01-01';

# WHERE true AND (true OR true) -> true
# WHERE true AND (true OR false) -> true
# WHERE true AND (false OR true) -> true
# WHERE true AND (false OR false) -> false
# WHERE false AND (true OR true) -> false
# WHERE false AND (true OR false) -> false
# WHERE false AND (false OR true) -> false
# WHERE false AND (false OR false) -> false

SELECT * FROM employee
WHERE end_date is NULL
AND (title = 'Teller' OR start_date < '2003-01-01');