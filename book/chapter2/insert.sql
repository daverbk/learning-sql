# Add a new person
INSERT INTO person
    (person_id, first_name, last_name, gender, birth_date)
VALUES (NULL, 'William', 'Turner', 'M', '1972-05-27');

# Check the changes
SELECT person_id, first_name, last_name, birth_date
FROM person;

# Select by id
SELECT person_id, first_name, last_name, birth_date
FROM person
WHERE person_id = 1;

# Select by first name
SELECT person_id, first_name, last_name, birth_date
FROM person
WHERE first_name = 'William';

# Add William's favorite food
INSERT INTO favorite_food (person_id, food)
VALUES (1, 'pizza');

INSERT INTO favorite_food (person_id, food)
VALUES (1, 'cookies');

INSERT INTO favorite_food (person_id, food)
VALUES (1, 'nachos');

# Check William's favorite foods
SELECT food
FROM favorite_food
WHERE person_id = 1
ORDER BY food;

# Add one more person
INSERT INTO person
( person_id, first_name, last_name, gender, birth_date
, address, city, state, country, postal_code)
VALUES (NULL, 'Susan', 'Smith', 'F', '1975-11-02',
        '23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

# Check added person
SELECT person_id, first_name, last_name, birth_date
FROM person;
