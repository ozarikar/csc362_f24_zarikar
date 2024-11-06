
DROP DATABASE IF EXISTS school;

CREATE DATABASE school;

USE school;


/* Create a table */
CREATE TABLE instructors (
    PRIMARY KEY (instructor_id),
    instructor_id             INT AUTO_INCREMENT,
    instructor_first_name     VARCHAR(50),
    instructor_last_name      VARCHAR(50),
    instructor_campus_phone    VARCHAR(50)
);

/* fills data in the table */
INSERT INTO instructors (instructor_first_name,instructor_last_name,instructor_campus_phone)
VALUES ('Kira', 'Bently', '363-9948 '),
       ('Timothy',   'Ennis', '527-4992   '),
       ('Shannon', 'Black', '322-5992'),
       ('Estela',  'Rosales', '322-6992');

/* prints the table*/
SELECT * FROM instructors;
