DROP DATABASE IF EXISTS pokemon_league;
CREATE DATABASE pokemon_league;
USE pokemon_league;

CREATE TABLE trainers (
    trainer_id          INT AUTO_INCREMENT,
    trainer_name        VARCHAR(32),
    trainer_hometown    VARCHAR(32),
    PRIMARY KEY (trainer_id)
);


CREATE TABLE pokemon (
    pokemon_id          INT AUTO_INCREMENT,
    pokemon_species     VARCHAR(32),
    pokemon_level       INT,
    trainer_id          INT,
    pokemon_is_in_party BOOLEAN,
    PRIMARY KEY (pokemon_id),
    FOREIGN KEY (trainer_id) REFERENCES trainers (trainer_id),
    CONSTRAINT minimum_pokemon_level CHECK (pokemon_level >= 1),
    CONSTRAINT maximum_pokemon_level CHECK (pokemon_level <= 100)
);


INSERT INTO trainers (trainer_name, trainer_hometown)
 VALUES ("Ash",     "Pallet Town"),
        ("Misty",   "Cerulean City"),
        ("Brock",   "Pewter City");


INSERT INTO pokemon (pokemon_species, pokemon_level, trainer_id, pokemon_is_in_party)
 VALUES ("Pikachu", "58", 1, TRUE),
        ("Staryu",  "44", 2, TRUE),
        ("Onyx",    "52", 3, TRUE),
        ("Magicarp","12", 1, FALSE);


DELIMITER //

-- Trigger to prevent a trainer from having more than 6 Pokémon
CREATE TRIGGER before_pokemon_insert 
BEFORE INSERT ON pokemon 
FOR EACH ROW 
BEGIN
    DECLARE pokemon_count INT;

    -- Count the number of Pokémon a trainer currently has
    SELECT COUNT(*) INTO pokemon_count
    FROM pokemon
    WHERE trainer_id = NEW.trainer_id;

    -- Check if adding this Pokémon would exceed the limit of 6
    IF pokemon_count >= 6 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A trainer can have a maximum of 6 Pokemon!';
    END IF;
END;
//

CREATE TRIGGER before_pokemon_delete
BEFORE DELETE ON pokemon
FOR EACH ROW
BEGIN
    DECLARE pokemon_count INT;

    -- counting number of pokemons associated with a trainer
    SELECT COUNT(*) INTO pokemon_count
    FROM pokemon
    WHERE trainer_id = OLD.trainer_id;

    -- check on if its already one left
    IF pokemon_count <= 1 THEN
    SQLSTATE '45000'
    SET MESSAGE_TEXT = 'A trainer must have at least 1 Pokemon !';
    END IF;
    END;
    //

DELIMITER ;


-- this is for testing purpose > 6
INSERT INTO pokemon (pokemon_species, pokemon_level, trainer_id, pokemon_is_in_party)
 VALUES ("Pikachu11", "58", 1, TRUE),
        ("Staryu11",  "44", 1, TRUE),
        ("Onyx11",    "52", 1, TRUE),
        ("Staryu21",  "44", 1, TRUE);

INSERT INTO pokemon (pokemon_species, pokemon_level, trainer_id, pokemon_is_in_party)
 VALUES ("Pikachu11", "58", 1, TRUE),
        ("Staryu11",  "44", 1, TRUE);        


SELECT pokemon_species from pokemon
where trainer_id = 1;

DELETE FROM pokemon
 where trainer_id = 2;