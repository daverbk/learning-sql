USE BANK;

# Create person table
CREATE TABLE person
(person_id SMALLINT UNSIGNED,
first_name VARCHAR(20),
last_name VARCHAR(20),
gender ENUM('M', 'F'),
birth_date DATE,
address VARCHAR(30),
city VARCHAR(20),
state VARCHAR(20),
country VARCHAR(20),
postal_code VARCHAR(20),
CONSTRAINT pk_person PRIMARY KEY (person_id));

# Check table description
DESC person;

# Create favorite_food table
CREATE TABLE favorite_food
(person_id SMALLINT UNSIGNED,
food VARCHAR(20),
CONSTRAINT pk_favorite_food PRIMARY KEY (person_id, food),
CONSTRAINT fk_person_id FOREIGN KEY (person_id)
REFERENCES person(person_id));

# Check table description
DESC favorite_food;
