
/*drops any data base of name movie_rating if exist*/
DROP DATABASE IF EXISTS movie_rating;

/* creates movie_rating dataBase*/
CREATE DATABASE movie_rating;

USE movie_rating;


/* Creates a table Movies*/
CREATE TABLE Movies (
    PRIMARY KEY (Movie_id),
    movie_id            INT AUTO_INCREMENT,
    movie_title          VARCHAR(300),
    release_date         Date,
    genre               VARCHAR(50)
);

/* Creates a table consumers*/
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

/* Creates a table Ratings*/
CREATE TABLE Ratings (
    PRIMARY KEY (movie_id,consumer_id),
    movie_id                  INT,
    consumer_id               INT,
    rating_date_time         DATETIME,
    rating_stars             INT
);

/* inserts data*/
INSERT INTO Movies (movie_title,release_date,genre)
VALUES ("The Hunt for Red October",'1990-03-02', "Acton, Adventure, Thriller"),
       ("Lady Bird",'2017-12-01',	"Comedy, Drama"),
       ("Inception",'2010-08-16',"Acton, Adventure, Science Fiction"),
       ("Monty Python and the Holy Grail",'1975-04-03',"Comedy");

/* Inserts data*/
INSERT INTO Consumers (consumer_first_name,consumer_last_name,consumer_address,consumer_city,consumer_state,zip_code)
VALUES ("Toru","Okada","800 Glenridge Ave","Hobart","IN","46343"),
       ("Kumiko","Okada","864 NW Bohemia St","Vincentown","NJ","08088"),
       ("Noboru","Wataya","342 Joy Ridge St","Hermitage","TN","37076"),
       ("May","Kasahara","5 Kent Rd","East Haven","CT","06512");

/* Inserts data*/
INSERT INTO Ratings (movie_id,consumer_id,rating_date_time,rating_stars)
VALUES (1,1,'2010-09-02 10:54:19',4),
       (1,3,'2012-08-05 15:00:01',3),
       (1,4,'2016-10-02 23:58:12',1),
       (2,3,'2017-03-27 00:12:48',2),
       (2,4,'2018-08-02 00:54:42',4);

/* will display the charecterstics of the tablse created*/
SHOW CREATE TABLE Movies;
SHOW CREATE TABLE Consumers;
SHOW CREATE TABLE Ratings;

SELECT * FROM Consumers; /*View all consumer data*/
SELECT * FROM Movies; /*View all Movie data*/
SELECT * FROM Ratings;/* View all ratings data*/


/*links the ratings table with movies and consumers and display data  */
SELECT consumer_first_name, consumer_last_name, movie_title, rating_stars
      FROM Movies
          NATURAL JOIN Ratings
          NATURAL JOIN Consumers;



/* The biggest design flaw i could see was that in the movies table
 the genre field can take more than one arguments since a movie can
 be in many genres therefore we should create a seperate linking table for it*/

/*drops any data base of name movie_rating if exist*/
 DROP DATABASE IF EXISTS movie_rating;

/* creates movie_rating dataBase*/
CREATE DATABASE movie_rating;

USE movie_rating;


/* Creates a table Movies*/
CREATE TABLE Movies (
    PRIMARY KEY (Movie_id),
    movie_id            INT AUTO_INCREMENT,
    movie_title          VARCHAR(300),
    release_date         Date
);

/* Creates a table genres*/
CREATE TABLE genres(
    PRIMARY KEY(genre_id),
    genre_id  INT AUTO_INCREMENT,
    genre_name VARCHAR(64)
);

/* Creates a table movie_genres*/
CREATE TABLE movie_genres(
    PRIMARY KEY (movie_id,genre_id),
    movie_id        INT,
    genre_id        INT
);

/* Creates a table Customers*/
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

/* Creates a table Ratings*/
CREATE TABLE Ratings (
    PRIMARY KEY (movie_id,consumer_id),
    movie_id                  INT,
    consumer_id               INT,
    rating_date_time         DATETIME,
    rating_stars             INT
);

/* Inserts data*/
INSERT INTO Movies (movie_title,release_date)
VALUES ("The Hunt for Red October",'1990-03-02'),
       ("Lady Bird",'2017-12-01'),
       ("Inception",'2010-08-16'),
       ("Monty Python and the Holy Grail",'1975-04-03');

/* Inserts data*/
INSERT INTO genres (genre_name)
VALUES ("Action"),
       ("Adventure"),
       ("Thriller"),
       ("Science Fiction"),
       ("Drama"),
       ("Comedy");

/* Inserts data*/
INSERT INTO movie_genres (movie_id,genre_id)
VALUES (1,1),
       (1,2),
       (1,3),
       (2,6),
       (2,5),
       (3,1),
       (3,2),
       (3,4),
       (4,6);

/* Inserts data*/
INSERT INTO Consumers (consumer_first_name,consumer_last_name,consumer_address,consumer_city,consumer_state,zip_code)
VALUES ("Toru","Okada","800 Glenridge Ave","Hobart","IN","46343"),
       ("Kumiko","Okada","864 NW Bohemia St","Vincentown","NJ","08088"),
       ("Noboru","Wataya","342 Joy Ridge St","Hermitage","TN","37076"),
       ("May","Kasahara","5 Kent Rd","East Haven","CT","06512");

/* Inserts data*/
INSERT INTO Ratings (movie_id,consumer_id,rating_date_time,rating_stars)
VALUES (1,1,'2010-09-02 10:54:19',4),
       (1,3,'2012-08-05 15:00:01',3),
       (1,4,'2016-10-02 23:58:12',1),
       (2,3,'2017-03-27 00:12:48',2),
       (2,4,'2018-08-02 00:54:42',4);



/*links the genres table with movies as linked in table movies_gesnres 
and display data as asked */
SELECT movie_title, genre_name 
    FROM Movies
        NATURAL JOIN movie_genres
        NATURAL JOIN genres;

/*links the ratings table with movies and consumers and display data  */
SELECT consumer_first_name, consumer_last_name, movie_title, rating_stars
      FROM Movies
          NATURAL JOIN Ratings
          NATURAL JOIN Consumers;

