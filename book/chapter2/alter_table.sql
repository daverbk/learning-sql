# To edit person pk we need to remove it from the favorite_food fk
ALTER TABLE favorite_food
    DROP FOREIGN KEY fk_person_id,
    MODIFY person_id SMALLINT UNSIGNED;

# Edit the pk of person
ALTER TABLE person MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;

# Return the fk to favorite_food
ALTER TABLE favorite_food
    ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id)
          REFERENCES person (person_id);
