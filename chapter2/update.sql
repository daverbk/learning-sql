# Fix William's incorrect naming
UPDATE person
SET first_name = 'Williams'
WHERE person_id = 1;

# Check changes
SELECT person_id, first_name, last_name
FROM person
WHERE person_id = 1;

# Update William's address data
UPDATE person
SET address = '1225 Tremont St.', city = 'Boston',
state = 'MA', country = 'USA', postal_code = '02138'
WHERE person_id = 1;

# Check changes
SELECT address, city, state, country, postal_code
FROM person
WHERE person_id = 1;