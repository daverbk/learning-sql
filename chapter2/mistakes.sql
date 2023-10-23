# Try to create record with existing pk value
# Would result in [23000][1062] Duplicate entry '1' for key
INSERT INTO person
(person_id, first_name, last_name, gender, birth_date)
VALUES (1, 'Charles', 'Fulton', 'M', '1968-01-15');

# Try to create record with non-existing fk value
# Would result in [23000][1452] Cannot add or update a child row: a foreign key constraint fails
INSERT INTO favorite_food (person_id, food)
VALUES (999, 'lasagna');

# Try to create record with wrong enum value
# Would result in truncated data or error depending on server
UPDATE person
SET gender = 'O'
WHERE person_id = 1;

# Try to add date in format that is different from the default
# Would result in Incorrect date value: 'DEC-21-1980' for column 'birth_date' at row 1
UPDATE person
SET birth_date = 'DEC-21-1980'
WHERE person_id = 1;

# Additional
# See the warnings if present
SHOW WARNINGS;

# See the tables
SHOW TABLES;