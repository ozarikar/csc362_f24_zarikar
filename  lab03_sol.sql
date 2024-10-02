DROP DATABASE IF EXISTS movie_rating;


CREATE DATABASE movie_rating;

USE movie_rating;


/* Create a table */
CREATE TABLE Movies (
    PRIMARY KEY (Movie_id),
    movie_id            INT AUTO_INCREMENT,
    movie_title          VARCHAR(300),
    release_date         Date,
    genre               VARCHAR(50)
);

CREATE TABLE Consumers (
    PRIMARY KEY (consumer_id),
    consumer_id                    INT AUTO_INCREMENT,
    consumer_first_name            VARCHAR(64),
    consumer_last_name             VARCHAR(64),
    consumer_address               VARCHAR(150),
    consumer_city                  VARCHAR(15),
    consumer_state                 VARCHAR(2),
    consumer_zip_code              VARCHAR(6)
);

CREATE TABLE Ratings (
    PRIMARY KEY (movie_id,consumer_id),
    movie_id                  INT,
    consumer_id               INT,
    rating_when_rated         DATETIME,
    rating_star_number        INT
);
