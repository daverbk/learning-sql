# Delete record
DELETE FROM person
WHERE person_id = 2;

# Check deletion result
SELECT first_name, last_name
FROM person;
