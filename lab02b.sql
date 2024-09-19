/*
  Lab 02: MariaDB Tutorial
  CSC 362 Database Systems
  Originally by Thomas E. Allen
  Updated by William Bailey
*/

/* Create the database (dropping the previous version if necessary */
DROP DATABASE IF EXISTS school;

CREATE DATABASE school;

USE school;


/* Create the two tables */
CREATE TABLE instructors (
    PRIMARY KEY (instructor_id),
    instructor_id             INT AUTO_INCREMENT,
    instructor_first_name     VARCHAR(50),
    instructor_last_name      VARCHAR(50),
    instructor_campus_phone    VARCHAR(50)
);


INSERT INTO instructors (instructor_first_name,instructor_last_name,instructor_campus_phone)
VALUES ('Kira', 'Bently', '363-9948 '),
       ('Timothy',   'Ennis', '527-4992   '),
       ('Shannon', 'Black', '322-5992'),
       ('Estela',  'Rosales', '322-6992');

/* Use SELECT to display some "reports" from the 3 tables. */
SELECT * FROM instructors;

/* End of file lab02a.sql */
