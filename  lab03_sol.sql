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
    zip_code                       VARCHAR(10)
);

CREATE TABLE Ratings (
    PRIMARY KEY (movie_id,consumer_id),
    movie_id                  INT,
    consumer_id               INT,
    rating_date_time         DATETIME,
    rating_stars             INT
);


INSERT INTO Movies (movie_title,release_date,genre)
VALUES ("The Hunt for Red October",'1990-03-02', "Acton, Adventure, Thriller"),
       ("Lady Bird",'2017-12-01',	"Comedy, Drama"),
       ("Inception",'2010-08-16',"Acton, Adventure, Science Fiction"),
       ("Monty Python and the Holy Grail",'1975-04-03',"Comedy");

INSERT INTO Consumers (consumer_first_name,consumer_last_name,consumer_address,consumer_city,consumer_state,zip_code)
VALUES ("Toru","Okada","800 Glenridge Ave","Hobart","IN","46343"),
       ("Kumiko","Okada","864 NW Bohemia St","Vincentown","NJ","08088"),
       ("Noboru","Wataya","342 Joy Ridge St","Hermitage","TN","37076"),
       ("May","Kasahara","5 Kent Rd","East Haven","CT","06512");

INSERT INTO Ratings (movie_id,consumer_id,rating_date_time,rating_stars)
VALUES (1,1,'2010-09-02 10:54:19',4),
       (1,3,'2012-08-05 15:00:01',3),
       (1,4,'2016-10-02 23:58:12',1),
       (2,3,'2017-03-27 00:12:48',2),
       (2,4,'2018-08-02 00:54:42',4);

SHOW CREATE TABLE Movies;
SHOW CREATE TABLE Consumers;
SHOW CREATE TABLE Ratings;

SELECT * FROM Consumers; /*View all consumer data*/
SELECT * FROM Movies; /*View all Movie data*/
SELECT * FROM Ratings;


SELECT consumer_first_name, consumer_last_name, movie_title, rating_star_number
      FROM Movies
          NATURAL JOIN Ratings
          NATURAL JOIN Consumers;

